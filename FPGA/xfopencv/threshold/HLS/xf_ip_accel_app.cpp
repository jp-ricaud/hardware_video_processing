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

#include "xf_threshold_config.h"

Metadata_t meta_data_proc(Metadata_t MetaIn){
  static Metadata_t MetaTmp = MetaIn;
  return MetaTmp;
  //return MetaIn;
}


void threshold_accel(xf::Mat<XF_8UC1, HEIGHT, WIDTH, NPIX> &_src, xf::Mat<XF_8UC1, HEIGHT, WIDTH, NPIX> &_dst, unsigned char thresh, unsigned char maxval);

// ap_axiu<data, keep, strb, user> ; ug902-98
void ip_accel_app(hls::stream< ap_axiu<256,1,1,1> >& _src, hls::stream< ap_axiu<256,1,1,1> >& _dst, int height, int width, unsigned char threshold, unsigned char maxval, Metadata_t *MetaIn, Metadata_t *MetaOut)
{

  #pragma HLS INTERFACE axis register both  port=_src
  #pragma HLS INTERFACE axis register both  port=_dst

   xf::Mat<XF_8UC1, HEIGHT, WIDTH, NPIX> imgInput(height, width);
   xf::Mat<XF_8UC1, HEIGHT, WIDTH, NPIX> imgOutput(height, width);

  #pragma HLS stream variable=imgInput.data dim=1 depth=1
  #pragma HLS stream variable=imgOutput.data dim=1 depth=1
  #pragma HLS dataflow

  #pragma HLS INTERFACE ap_none port=MetaOut
  #pragma HLS INTERFACE ap_vld register port=MetaIn
  (*MetaOut) = meta_data_proc((*MetaIn));

  xf::AXIvideo2xfMat(_src, imgInput);

  threshold_accel(imgInput, imgOutput, threshold, maxval);

  xf::xfMat2AXIvideo(imgOutput, _dst);
}
