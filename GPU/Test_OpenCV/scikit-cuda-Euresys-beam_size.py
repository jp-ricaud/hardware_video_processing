#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""
.. module:: cuda-beame_size
  :SYNOPSIS: T
  :PLATFORM: Windows 10, Nvidia GPU, Euresys frame grabber library, Python 3.7, OpenCV 4.5

  ::

  This is a test module to simulate the measurement of the beam size with Euresys Coaxpress frame grabber and Nvidia GPU. OpenCV's cuda library is used when possible to do GPU acceleration.
  For test purpose.


  File     : cuda-beame_size.py
  Created  : November 02, 2020
  Updated  : November 02, 2020

  Copyright (C) 2020 - 2020 Synchrotron Soleil

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>

  MODIFICATIONS :
    --

.. note:: The beam is simulated by a paper in fron of the camera.
.. moduleauthor:: Jean-Paul Ricaud <jean-paul.ricaud@synchrotron-soleil.fr>
"""


from egrabber import *
import cv2
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import sys
import timeit
import cProfile
import pycuda.autoinit
from pycuda import gpuarray
import skcuda.linalg

cp = cProfile.Profile()

np.set_printoptions(threshold=sys.maxsize)


def preProcess_medianBlur(img_buffer, img_buffer_index):
    """Apply a median blur filter using the OpenCV's cuda createMedianFilter function

    :param img_buffer: a list of buffer containing the image to be proceed
    :type img_buffer: [cv2.cuda_GpuMat()]
    :param img_buffer_index: index of the image in the list
    :type img_buffer_index: int
    :return:
    :rtype:
    :raise:

    """
    median_filter = cv2.cuda.createMedianFilter(srcType=cv2.cuda_GpuMat().type(), windowSize=15, partition=128)
    img_buffer[img_buffer_index + 1] = median_filter.apply(img_buffer[img_buffer_index])


def preProcess_bilateral(img_buffer, img_buffer_index):
    """Apply a bilateral filter using the OpenCV's cuda bilateralFilter function

    :param img_buffer: a list of buffer containing the image to be proceed
    :type img_buffer: [cv2.cuda_GpuMat()]
    :param img_buffer_index: index of the image in the list
    :type img_buffer_index: int
    :return:
    :rtype:
    :raise:

    """
    img_buffer[img_buffer_index + 1] = cv2.cuda.bilateralFilter(img_buffer[img_buffer_index], 50, 75, 75)


def preProcess_CLAHE(img_buffer, img_buffer_index):
    """Apply an adaptative contrast filter using the OpenCV's cuda createCLAHE function

    :param img_buffer: a list of buffer containing the image to be proceed
    :type img_buffer: [cv2.cuda_GpuMat()]
    :param img_buffer_index: index of the image in the list
    :type img_buffer_index: int
    :return:
    :rtype:
    :raise:

    """
    clahe = cv2.cuda.createCLAHE(clipLimit=5.0, tileGridSize=(8, 8))
    img_buffer[img_buffer_index + 1] = clahe.apply(img_buffer[img_buffer_index], cv2.cuda_Stream.Null())


def preProcess_threshold(img_buffer, img_buffer_index):
    """Apply a threshold filter using the OpenCV's cuda threshold function

    :param img_buffer: a list of buffer containing the image to be proceed
    :type img_buffer: [cv2.cuda_GpuMat()]
    :param img_buffer_index: index of the image in the list
    :type img_buffer_index: int
    :return:
    :rtype:
    :raise:

    """
    _, img_buffer[img_buffer_index + 1] = cv2.cuda.threshold(img_buffer[img_buffer_index], 61, 255, cv2.THRESH_BINARY)


def preProcess_resize(img_buffer, img_buffer_index):
    """Resize the image using the OpenCV's cuda resize function

    :param img_buffer: a list of buffer containing the image to be proceed
    :type img_buffer: [cv2.cuda_GpuMat()]
    :param img_buffer_index: index of the image in the list
    :type img_buffer_index: int
    :return:
    :rtype:
    :raise:

    """
    img_buffer[img_buffer_index + 1] = cv2.cuda.resize(img_buffer[img_buffer_index], (1600, 846), interpolation=cv2.INTER_CUBIC)


def preProcess_canny(img_buffer, img_buffer_index):
    """Apply a canny contour detection to the image using the OpenCV's cuda createCannyEdgeDetector function

    :param img_buffer: a list of buffer containing the image to be proceed
    :type img_buffer: [cv2.cuda_GpuMat()]
    :param img_buffer_index: index of the image in the list
    :type img_buffer_index: int
    :return:
    :rtype:
    :raise:

    """
    img_buffer[img_buffer_index + 1] = cv2.cuda.createCannyEdgeDetector(50.0, 100.0, 27, False).detect(img_buffer[img_buffer_index])


class Measure_size():
    """Measure the size of the beam.

    """

    def draw_axis(self, img, p_, q_, colour, scale):
        """Draw the PCA axes on the image

        This is only for visualization and test purpose

        :param img: the image on which the axes are drawn
        :type img: Mat
        :param p_: center of the image
        :type p_: (int, int)
        :param q_: principal component axe
        :type q_: int
        :param colour: colour of the axe
        :type colour: (int, int, int)
        :param scale: scale factor
        :type scale: float
        :return:
        :rtype:
        :raise:

        """
        p = list(p_)
        q = list(q_)

        angle = np.arctan2(p[1] - q[1], p[0] - q[0])  # angle in radians
        hypotenuse = np.sqrt((p[1] - q[1]) * (p[1] - q[1]) + (p[0] - q[0]) * (p[0] - q[0]))

        # Here we lengthen the arrow by a factor of scale
        q[0] = p[0] - scale * hypotenuse * np.cos(angle)
        q[1] = p[1] - scale * hypotenuse * np.sin(angle)
        cv2.line(img, (int(p[0]), int(p[1])), (int(q[0]), int(q[1])), colour, 1, cv2.LINE_AA)

        # create the arrow hooks
        p[0] = q[0] + 9 * np.cos(angle + np.pi / 4)
        p[1] = q[1] + 9 * np.sin(angle + np.pi / 4)
        cv2.line(img, (int(p[0]), int(p[1])), (int(q[0]), int(q[1])), colour, 1, cv2.LINE_AA)

        p[0] = q[0] + 9 * np.cos(angle - np.pi / 4)
        p[1] = q[1] + 9 * np.sin(angle - np.pi / 4)
        cv2.line(img, (int(p[0]), int(p[1])), (int(q[0]), int(q[1])), colour, 1, cv2.LINE_AA)

    def get_orientation_opencv(self, pts, img):
        """Find the oriantation of the shape ; use OpenCV PCA function

        :param img: the image on which the axes are drawn
        :type img: Mat
        :param pts: contours in the image
        :type pts:
        :return angle: angle of the shape in radians
        :rtype angle: float
        :return center: center of the shape
        :rtype center: (int, int)
        :raise:

        """
        # Construct a buffer used by the pca analysis
        sz = len(pts)
        #data_pts = np.empty((sz, 2), dtype=np.float64)
        data_pts = np.empty((sz, 2), dtype=np.float32)
        for i in range(data_pts.shape[0]):
            data_pts[i, 0] = pts[i, 0, 0]
            data_pts[i, 1] = pts[i, 0, 1]

        #print("pts: {}".format(pts))
        #print("pts[i, 0, 0]: {}".format(pts[i, 0, 0]))
        #print("pts[i, 0, 1]: {}".format(pts[i, 0, 1]))
        #print("data_pts: {}".format(data_pts))

        #####################################################################
        # Perform PCA OpenCV analysis
        mean = np.empty((0))
        mean, eigenvectors, eigenvalues = cv2.PCACompute2(data_pts, mean)
         #print("\n")
         #print("mean : {}".format(mean))
         #print("eigenvalues : {}".format(eigenvalues))
         #print("eigenvectors : {}".format(eigenvectors))


        # Store the center of the object
        center = (int(mean[0, 0]), int(mean[0, 1]))

        # Draw the principal components
        cv2.circle(img, center, 5, (0, 0, 255), 2)
        p1 = (center[0] + 0.02 * eigenvectors[0, 0] * eigenvalues[0, 0], center[1] + 0.02 * eigenvectors[0, 1] * eigenvalues[0, 0])
        p2 = (center[0] - 0.02 * eigenvectors[1, 0] * eigenvalues[1, 0], center[1] - 0.02 * eigenvectors[1, 1] * eigenvalues[1, 0])
        self.draw_axis(img, center, p1, (0, 255, 0), 0.2)
        self.draw_axis(img, center, p2, (255, 255, 0), 0.5)

        angle = np.arctan2(eigenvectors[0, 1], eigenvectors[0, 0])  # orientation in radians
        #print("angle: {}".format(np.degrees(angle)))

        return angle, center


    def get_orientation_scikit(self, pts, img):
        """Find the oriantation of the shape ; use SciKit VSD function

        :param img: the image on which the axes are drawn
        :type img: Mat
        :param pts: contours in the image
        :type pts:
        :return angle: angle of the shape in radians
        :rtype angle: float
        :return center: center of the shape
        :rtype center: (int, int)
        :raise:

        """
        # Construct a buffer used by the pca analysis
        sz = len(pts)
        #data_pts = np.empty((sz, 2), dtype=np.float64)
        data_pts = np.empty((sz, 2), dtype=np.float32)
        for i in range(data_pts.shape[0]):
            data_pts[i, 0] = pts[i, 0, 0]
            data_pts[i, 1] = pts[i, 0, 1]

        #print("pts: {}".format(pts))
        #print("pts[i, 0, 0]: {}".format(pts[i, 0, 0]))
        #print("pts[i, 0, 1]: {}".format(pts[i, 0, 1]))
        #print("data_pts: {}".format(data_pts))

        #####################################################################
        # Perform PCA OpenCV analysis
        #mean = np.empty((0))
        #mean, eigenvectors, eigenvalues = cv2.PCACompute2(data_pts, mean)
        #print("\n")
        #print("mean : {}".format(mean))
        #print("eigenvalues : {}".format(eigenvalues))
        #print("eigenvectors : {}".format(eigenvectors))


        # Store the center of the object
#        center = (int(mean[0, 0]), int(mean[0, 1]))
#
#        # Draw the principal components
#        cv2.circle(img, center, 5, (0, 0, 255), 2)
#        p1 = (center[0] + 0.02 * eigenvectors[0, 0] * eigenvalues[0, 0], center[1] + 0.02 * eigenvectors[0, 1] * eigenvalues[0, 0])
#        p2 = (center[0] - 0.02 * eigenvectors[1, 0] * eigenvalues[1, 0], center[1] - 0.02 * eigenvectors[1, 1] * eigenvalues[1, 0])
#        self.draw_axis(img, center, p1, (0, 255, 0), 0.2)
#        self.draw_axis(img, center, p2, (255, 255, 0), 0.5)
        #####################################################################

        # Perform PCA scikit analysis
        #v_gpu = gpuarray.to_gpu(data_pts.T.copy())
        data_pts = data_pts - np.mean(data_pts, axis=0)
        v_gpu = gpuarray.to_gpu(data_pts.copy())
        a_gpu = skcuda.linalg.transpose(v_gpu)

        #U_d, s_d, V_d = skcuda.linalg.svd(v_gpu, 'S', 'S')
        U_d, s_d = skcuda.linalg.svd(a_gpu, 'A', 'N')
        mean_gpu = skcuda.misc.mean(U_d, axis=0)

        u = U_d.get()
        s = s_d.get()
        m = mean_gpu.get()
        #print("m: {}".format(m))

        #mean_sk = np.array([[-750.0 * np.mean(u[0,0]), -760 * np.mean(u[0,1])]])
        mean_sk = np.array([[1092.0 * m[0], 962.0 * m[1]]])
        eigenvectors_sk = u
        eigenvalues_sk = s
        #print("mean_sk : {} -- {}".format(mean_sk, mean/mean_sk))
        #print("eigenvalues_sk : {} -- {} -- {}".format(eigenvalues_sk, eigenvalues[0]/eigenvalues_sk[0], eigenvalues[1]/eigenvalues_sk[1]))
        #print("eigenvectors_sk : {} -- {} -- {}".format(eigenvectors_sk, eigenvectors[0]/eigenvectors_sk[0], eigenvectors[1]/eigenvectors_sk[1]))

        #print("s: {}".format(s**2))
        #print("u0: {}".format(u[:,0]))
        #print("u1: {}".format(u[:,1]))
        #print("\n")

        # Store the center of the object
        center_sk = (int(mean_sk[0, 0]), int(mean_sk[0, 1]))

        # Draw the principal components
        cv2.circle(img, center_sk, 5, (0, 255, 255), 2)
        p1_sk = (center_sk[0] + 0.053071 * eigenvectors_sk[0, 0] * eigenvalues_sk[0], center_sk[1] - 0.007614 * eigenvectors_sk[0, 1] * eigenvalues_sk[0])
        p2_sk = (center_sk[0] - 0.0096 * eigenvectors_sk[1, 0] * eigenvalues_sk[1], center_sk[1] - 0.0468 * eigenvectors_sk[1, 1] * eigenvalues_sk[1])
        self.draw_axis(img, center_sk, p1_sk, (0, 0, 255), 0.2)
        self.draw_axis(img, center_sk, p2_sk, (255, 0, 0), 0.5)

        angle_sk = np.arctan2(eigenvectors_sk[0, 1], eigenvectors_sk[0, 0])  # orientation in radians
        #print("angle: {}".format(np.degrees(angle_sk)))

        return angle_sk, center_sk


    def process(self, img):
        """Find the PCA of the shape

        :param img: the image on which the axes are drawn
        :type img: Mat
        :return BGR_img: a color image to trace the contour and the axes of the shape. Only for visualization during tests
        :rtype BGR_img: Mat
        :return (rotated_image, rotated_image_90): rotated shape to be horizontal and vertical
        :rtype (rotated_image, rotated_image_90): (Mat, Mat)
        :raise:

        """
        (image_high, image_width) = img.shape[:2]
        image_center = (image_width / 2, image_high / 2)
        PC_angle = []
        PC_center = []
        img_GPU = cv2.cuda_GpuMat()
        img_GPU.upload(img)

        BGR_img = cv2.merge((img, img, img))

        # Find all the contours in the thresholded image
        contours, _ = cv2.findContours(img, cv2.RETR_LIST, cv2.CHAIN_APPROX_NONE)

        for i, c in enumerate(contours):
            # Calculate the area of each contour
            area = cv2.contourArea(c)
            # Ignore contours that are too small or too large
            if area < 9e4 or 2e5 < area:
                continue

            #print("c: {}".format(c))

            # Draw each contour only for visualisation purposes
            cv2.drawContours(BGR_img, contours, i, (0, 0, 255), 2)
            # Find the orientation of each shape
            angle, center = self.get_orientation_opencv(c, BGR_img)
            #angle, center = self.get_orientation_scikit(c, BGR_img)
            PC_angle.append(angle)
            PC_center.append(center)

            PC1_angle = np.abs(np.degrees(PC_angle[0]))
            #print("angle: {}".format(PC1_angle))

            M = cv2.getRotationMatrix2D(image_center, PC1_angle, 1)
            rotated_image = cv2.cuda.warpAffine(img_GPU, M, (image_width, image_high))
            M = cv2.getRotationMatrix2D(image_center, 90.0 + PC1_angle, 1)
            rotated_image_90 = cv2.cuda.warpAffine(rotated_image, M, (image_width, image_high))

        return BGR_img, (rotated_image, rotated_image_90)

    def sum_pixels(self, img):
        """Sum the pixels to draw the shape histogram

        :param img: a list with the horizontal and the vertical image
        :type img: (Mat, Mat)
        :return histogram_int: a list with the shape's horizontal and vertical histogram
        :rtype histogram_int: [[int], [int]]
        :return max_histrogram_int: a list with the maximum of the histogram which give the size of the beam
        :rtype max_histrogram_int: [int, int]
        :raise:

        """
        histogram_int = [[], []]
        max_histrogram_int = [0, 0]
        for i, image in enumerate(img):
            histogram = []
            dst = (cv2.cuda.reduce(image, 0, cv2.REDUCE_SUM, dtype=cv2.CV_32S)).download()
            histogram = str(dst[0]).split()
            histogram_int[i] = list(map(int, histogram[1:-1]))
            max_histrogram_int[i] = np.max(histogram_int)

        return histogram_int, max_histrogram_int


class Process_and_plot():
    """Process the image and plot histograms with the horizontal and vertical size of the beam.

    The input and a color image with the contour and axes are also drawn for test vizualization only

    """
    def __init__(self, grabber, process):
        """Class Constructor

        """
        self.grabber = grabber
        self.process = process
        self.img_buffer = [cv2.cuda_GpuMat()]
        self.fig = plt.figure()
        self.plot_list = []
        self.frame_list = []
        self.frame_list.append(self.fig.add_subplot(2, 2, 1))
        self.frame_list.append(self.fig.add_subplot(2, 2, 2))
        self.frame_list.append(self.fig.add_subplot(2, 2, 3))
        self.frame_list.append(self.fig.add_subplot(2, 2, 4))

    #    self.preProcess_list = [preProcess_resize]
        self.preProcess_list = [preProcess_resize, preProcess_threshold]
    #    self.preProcess_list = [preProcess_resize, preProcess_threshold, preProcess_bilateral]
    #    self.preProcess_list = [preProcess_resize, preProcess_threshold, preProcess_bilateral, preProcess_CLAHE]
    #    self.preProcess_list = [preProcess_resize, preProcess_threshold, preProcess_bilateral, preProcess_CLAHE, preProcess_canny]
        for n in self.preProcess_list:
            self.img_buffer.append(cv2.cuda_GpuMat())
        self.img_buffer_size = len(self.img_buffer) - 1

        self.init_plot()

    def mono8_to_ndarray(self, ptr, w, h, size):
        data = cast(ptr, POINTER(c_ubyte * size)).contents
        c = 1
        return np.frombuffer(data, count=size, dtype=np.uint8).reshape((h, w, c))

    def init_plot(self):
        with Buffer(self.grabber, timeout=1000) as buffer:
            ptr = buffer.get_info(BUFFER_INFO_BASE, INFO_DATATYPE_PTR)
            w = buffer.get_info(BUFFER_INFO_WIDTH, INFO_DATATYPE_SIZET)
            h = buffer.get_info(BUFFER_INFO_HEIGHT, INFO_DATATYPE_SIZET)
            size = buffer.get_info(BUFFER_INFO_SIZE_FILLED, INFO_DATATYPE_SIZET)
            in_img = self.mono8_to_ndarray(ptr, w, h, size)

            self.plot_list.append(self.frame_list[0].imshow(in_img))
            self.plot_list.append(self.frame_list[1].imshow(in_img))
            self.plot_list.append(self.frame_list[2])
            self.plot_list.append(self.frame_list[3])

    def update_plot(self, i):
        with Buffer(self.grabber, timeout=1000) as buffer:
            ptr = buffer.get_info(BUFFER_INFO_BASE, INFO_DATATYPE_PTR)
            w = buffer.get_info(BUFFER_INFO_WIDTH, INFO_DATATYPE_SIZET)
            h = buffer.get_info(BUFFER_INFO_HEIGHT, INFO_DATATYPE_SIZET)
            size = buffer.get_info(BUFFER_INFO_SIZE_FILLED, INFO_DATATYPE_SIZET)
            in_img = self.mono8_to_ndarray(ptr, w, h, size)

            start_time = timeit.default_timer()
#            cp.enable()

            self.img_buffer[0].upload(in_img)
            [preProcess(self.img_buffer, img_buffer_index) for img_buffer_index, preProcess in enumerate(self.preProcess_list)]
            preProcessed_img = self.img_buffer[self.img_buffer_size].download()
            check_img, (rotated_image, rotated_image_90) = self.process.process(preProcessed_img)
            histogram, Max_histogram = self.process.sum_pixels((rotated_image, rotated_image_90))

#            cp.disable()
#            cp.print_stats()
            execution_time = timeit.default_timer() - start_time
            print("Total process time: {}\n".format(execution_time))

            self.plot_list[0].set_data(in_img)
            #check_img = rotated_image_90.download()
            self.plot_list[1].set_data(check_img)
            self.plot_list[2].clear()
            self.plot_list[2].plot(histogram[0])
            self.plot_list[3].clear()
            self.plot_list[3].plot(histogram[1])

    def plot_histogram(self):
       ani = FuncAnimation(self.fig, self.update_plot, interval=0)
       plt.show()


def main():
    skcuda.linalg.init()
    cv2.setNumThreads(16)
    gentl = EGenTL()
    grabber = EGrabber(gentl)
    pixelFormat = grabber.get_pixel_format()
    if pixelFormat != 'Mono8':
        print("Unsupported {} pixel format. This sample works with Mono8 pixel format only.".format(pixelFormat))
    else:
        grabber.realloc_buffers(3)
        grabber.start()
        process = Measure_size()
        video_processing = Process_and_plot(grabber, process)
        video_processing.plot_histogram()


if __name__ == '__main__':
    main()
