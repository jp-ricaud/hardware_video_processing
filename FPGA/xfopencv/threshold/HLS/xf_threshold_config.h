/***************************************************************************
Copyright (c) 2019, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

***************************************************************************/
#ifndef _XF_THRESHOLD_CONFIG_H_
#define _XF_THRESHOLD_CONFIG_H_

#include "hls_stream.h"
#include "ap_int.h"
#include "common/xf_common.h"
#include "common/xf_utility.h"
#include "common/xf_infra.h"
#include "imgproc/xf_threshold.hpp"
#include "xf_config_params.h"

typedef ap_uint<8>  ap_uint8_t;
typedef ap_uint<64> ap_uint64_t;


/*  set the height and weight  */
#define HEIGHT 4096
#define WIDTH  2168

#if RO
#define NPIX XF_NPPC8
#endif
#if NO
#define NPIX XF_NPPC1
#endif


void threshold_accel(xf::Mat<XF_8UC1, HEIGHT, WIDTH, NPIX> &_src, xf::Mat<XF_8UC1, HEIGHT, WIDTH, NPIX> &_dst, unsigned char thresh, unsigned char maxval);


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

// ap_axiu<data, keep, strb, user> ; ug902-98
void ip_accel_app(hls::stream< ap_axiu<256,1,1,1> >& _src, hls::stream< ap_axiu<256,1,1,1> >& _dst, int height, int width, unsigned char threshold, unsigned char maxval, Metadata_t *MetaIn, Metadata_t *MetaOut);

#endif  // end of _XF_THRESHOLD_CONFIG_H_
