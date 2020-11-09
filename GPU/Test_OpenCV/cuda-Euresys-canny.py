from egrabber import *
import cv2
import numpy as np
import sys
import timeit

gui = 'nogui' not in sys.argv


def process(img):
    img_GPU = cv2.cuda_GpuMat()
    img_proc = cv2.cuda_GpuMat()
    img_canny = cv2.cuda_GpuMat()

    start_time = timeit.default_timer()
    img_GPU.upload(img)

    clahe = cv2.cuda.createCLAHE(clipLimit=5.0, tileGridSize=(8, 8))
    img_clahe = clahe.apply(img_GPU, cv2.cuda_Stream.Null())
    img_bilateral_filter = cv2.cuda.bilateralFilter(img_clahe, 5, 75, 75)
    img_resized = cv2.cuda.resize(img_bilateral_filter, (800, 800), interpolation=cv2.INTER_CUBIC)
    img_canny = cv2.cuda.createCannyEdgeDetector(50.0, 100.0, 3 ,False).detect(img_resized)

    out = img_canny.download()
    print("Process time: {}\n".format(timeit.default_timer() - start_time))

    return out


def mono8_to_ndarray(ptr, w, h, size):
    data = cast(ptr, POINTER(c_ubyte * size)).contents
    c = 1
    return np.frombuffer(data, count=size, dtype=np.uint8).reshape((h,w,c))


def loop(grabber):
    countLimit = 10
    count = 0
    grabber.start()
    while True:
        with Buffer(grabber, timeout=1000) as buffer:
            ptr = buffer.get_info(BUFFER_INFO_BASE, INFO_DATATYPE_PTR)
            w = buffer.get_info(BUFFER_INFO_WIDTH, INFO_DATATYPE_SIZET)
            h = buffer.get_info(BUFFER_INFO_HEIGHT, INFO_DATATYPE_SIZET)
            size = buffer.get_info(BUFFER_INFO_SIZE_FILLED, INFO_DATATYPE_SIZET)
            img = mono8_to_ndarray(ptr, w, h, size)

            out = process(img)

            count += 1
            if gui:
                cv2.imshow("Press any key to exit", out)
                if cv2.waitKey(1) >= 0:
                #if count == countLimit:
                    break
            elif count == countLimit:
                break


def run(grabber):
    grabber.realloc_buffers(3)
    loop(grabber)
    if gui:
        cv2.destroyAllWindows()

gentl = EGenTL()
grabber = EGrabber(gentl)
pixelFormat = grabber.get_pixel_format()
if pixelFormat != 'Mono8':
    print("Unsupported {} pixel format. This sample works with Mono8 pixel format only.".format(pixelFormat))
else:
    run(grabber)
