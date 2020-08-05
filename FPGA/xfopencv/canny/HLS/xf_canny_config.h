

#ifndef _XF_CANNY_CONFIG_H__
#define _XF_CANNY_CONFIG_H__

#include "hls_stream.h"
#include "ap_int.h"
#include "common/xf_common.h"
#include "common/xf_utility.h"
#include "common/xf_infra.h"
#include "imgproc/xf_canny.hpp"
#include "imgproc/xf_edge_tracing.hpp"
#include "xf_config_params.h"

#define WIDTH 1920
#define HEIGHT 1080

#if NO
#define INTYPE XF_NPPC1
#define OUTTYPE XF_NPPC32
#elif RO
#define INTYPE XF_NPPC8
#define OUTTYPE XF_NPPC32
#endif

#if L1NORM
#define NORM_TYPE XF_L1NORM
#elif L2NORM
#define NORM_TYPE XF_L2NORM
#endif

#define XF_USE_URAM false

// Euresys metadata definition
typedef struct Metadata_struct {
   unsigned char StreamId;
   unsigned short SourceTag;
   ap_int<24>     Xsize;
   ap_int<24>     Xoffs;
   ap_int<24>     Ysize;
   ap_int<24>     Yoffs;
   ap_int<24>     DsizeL;
   unsigned short PixelF;
   unsigned short TapG;
   unsigned char Flags;
   unsigned int Timestamp;
   unsigned char PixProcessingFlgs;
   unsigned int ModPixelF;
   unsigned int Status;
} Metadata_t;

//void canny_accel(xf::Mat<XF_8UC1, HEIGHT, WIDTH, INTYPE> &_src, xf::Mat<XF_2UC1, HEIGHT, WIDTH, XF_NPPC32> &_dst1, xf::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC8> &_dst2, unsigned char low_threshold, unsigned char high_threshold);

// ap_axiu<data, keep, strb, user> ; ug902-98
void ip_accel_app(hls::stream< ap_axiu<256,1,1,1> >& _src, hls::stream< ap_axiu<256,1,1,1> >& _dst, int height, int width,  unsigned char low_threshold, unsigned char high_threshold, Metadata_t *MetaIn, Metadata_t *MetaOut);

#endif

