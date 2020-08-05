# --------------------------------------------------------------------------------
# -- CustomLogic - Create Vivado Project
# --------------------------------------------------------------------------------
# --  Procedures: customlogicCreateProject
# --        File: create_vivado_project.tcl
# --        Date: 2019-05-31
# --         Rev: 0.2
# --      Author: PP
# --------------------------------------------------------------------------------
# -- 0.1, 2018-10-19, PP, Initial release
# --------------------------------------------------------------------------------

proc customlogicCreateProject {} {
  puts  " "
  puts  "EURESYS_INFO: Creating the CustomLogic Vivado project..."

  # Set the reference directory for source file relative paths
  set script_dir [file dirname [file normalize [info script]]]
  set customlogic_dir [file normalize $script_dir/..]

  # Set Project name
  set project_name CustomLogic

  # Create project
  create_project $project_name $customlogic_dir/07_vivado_project_canny -part xcku035-fbva676-2-e

  # Deactivate automatic order
  set_property source_mgmt_mode DisplayOnly [current_project]

  # Activate XPM_LIBRARIES
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY XPM_FIFO} [current_project]

  # Create 'sources_1' fileset (if not found)
  if {[string equal [get_filesets -quiet sources_1] ""]} {
    create_fileset -srcset sources_1
  }

  # Set 'sources_1' fileset object
  set obj [get_filesets sources_1]
  set files [list \
    "[file normalize "$customlogic_dir/02_coaxlink/hdl_enc/CustomLogicPkt.vp"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/hdl_enc/DmaBackEndPkt.vp"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/hdl_enc/CustomLogicPkt.vhdp"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/axi_dwidth_clk_converter_S128_M512.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/axi_dwidth_clk_converter_S256_M512.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/axi_interconnect_3xS512_M512.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/axi_lite_clock_converter.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/axis_data_fifo_256b.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/clk_wiz_cxp12.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/CounterDsp.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/EventSignalingBram.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/EventSignalingFifo_ku.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/ExtIOConfigBram.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/fifo_memento.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/FrameSizeDwDsp.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/gth_cxp_low_cxp12.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/LinkStreamFifo_132bx2048.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/LUT12x8.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/mem_if.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/MultiplierDsp.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/PacketFlowFifo_34bx512.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/PEGBram.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/PEGFifo_ku.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/PIXO_FIFO_259x1024.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/PoCXP_uBlaze.elf"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/PoCXP_uBlaze.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/reg2mem_rddwc.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/reg2mem_rdfifo.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/reg2mem_wrdwc.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/reg2mem_wrfifo.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/sout_fifo_wr128_rd256.xcix"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/ips/WrAxiAddrFifo.xcix"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/frame_to_line.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/mem_traffic_gen.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/control_registers.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/pix_lut8b.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/pix_threshold_proc.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/pix_threshold.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/pix_threshold_wrp.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/CustomLogic.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/lut_bram_8x256.xcix"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/sim/onboardmem.xcix"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/AXIvideo2xfMat.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/Block_Mat_exit1516_p.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/Block_Mat_exit15_pro.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/Canny.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/PixelProcessNew_1_s.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/TopDown_20_6_1024_s.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/canny_accel.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/canny_accel_iBuffyd2.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/canny_accel_oBuff_V.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w11_d2_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w14_d5760_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w16_d2_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w16_d2_A_x.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w16_d3_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w16_d4_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w24_d2_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w2_d2_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w32_d2_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w32_d3_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w57_d1_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w64_d1_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w8_d1_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w8_d2_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w8_d2_A_x.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w8_d3_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/fifo_w8_d6_A.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mul_VhK.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mul_WhU.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mul_Xh4.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mul_g8j.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mul_wdI.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mul_xdS.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mux_eOg.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mux_fYi.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mux_mb6.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mux_udo.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_mux_vdy.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_udivShg.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_udivThq.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/ip_accel_app_uremUhA.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_canny_aYie.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFAnglercU.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFCannyncg.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFDupliqcK.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFMagnisc4.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFPackNtde.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFSobelpcA.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xFSupprocq.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/start_for_xfMat2AZio.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFAngleKernel.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFAverageGaussianMas.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFAverageGaussianbkb.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFCannyKernel.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFCannyKernel_Block_s.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFCannyKernel_entry2.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFDuplicate_rows.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFMagnitudeKernel.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFPackNMS1096.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFSobel.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFSobel3x3.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFSuppression3x3.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFSuppression3x3_hbi.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xFSuppression3x3_jbC.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xfExtractPixels.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xfExtractPixels_1.vhd"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/xfMat2AXIvideo.vhd"]"\
  ]
  add_files -norecurse -fileset $obj $files

  # Set 'sources_1' fileset properties
  set obj [get_filesets sources_1]
  set_property "top" "CustomLogicTop" $obj

  # Create 'constrs_1' fileset (if not found)
  if {[string equal [get_filesets -quiet constrs_1] ""]} {
    create_fileset -constrset constrs_1
  }

  # Set 'constrs_1' fileset object
  set obj [get_filesets constrs_1]
  set files [list \
    "[file normalize "$customlogic_dir/02_coaxlink/constr/CxlCxp12_loc_common.xdc"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/constr/CxlCxp12_xil_x8_gen3.xdc"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/constr/CxlCxp12_timing_common.xdc"]"\
    "[file normalize "$customlogic_dir/02_coaxlink/constr/Bitstream_settings.xdc"]"\
    "[file normalize "$customlogic_dir/04_ref_design/canny/CustomLogic.xdc"]"\
  ]
  add_files -norecurse -fileset $obj $files

  # Set 'constrs_1' fileset properties
  set obj [get_filesets constrs_1]
  set_property "target_constrs_file" "[file normalize "$customlogic_dir/04_ref_design/canny/CustomLogic.xdc"]" $obj

  # Generate IPs
  foreach IpName [get_ips] {
    generate_target all [get_files "$IpName.xci"]
  }

  # Associate ELF file
  set_property SCOPED_TO_REF PoCXP_uBlaze [get_files -all -of_objects [get_fileset sources_1] {PoCXP_uBlaze.elf}]
  set_property SCOPED_TO_CELLS { inst/microblaze_I } [get_files -all -of_objects [get_fileset sources_1] {PoCXP_uBlaze.elf}]

  # Set Implementation strategy
  set_property strategy Performance_Retiming [get_runs impl_1]

  # Create 'sim_1' fileset (if not found)
  if {[string equal [get_filesets -quiet sim_1] ""]} {
    create_fileset -constrset sim_1
  }

  # Set 'sim_1' fileset object
  set obj [get_filesets sim_1]
  set files [list \
    "[file normalize "$customlogic_dir/04_ref_design/canny/sim/CustomLogicSimPkt.vhdp"]" \
    "[file normalize "$customlogic_dir/04_ref_design/canny/sim/SimulationCtrl_tb.vhd"]" \
    "[file normalize "$customlogic_dir/04_ref_design/canny/sim/tb_top.vhd"]" \
    "[file normalize "$customlogic_dir/04_ref_design/canny/sim/tb_top_behav.wcfg"]" \
  ]
  add_files -norecurse -fileset $obj $files

  # Set 'sim_1' fileset properties
  set obj [get_filesets sim_1]
  set_property "top" "tb_top" $obj
  set ipList [get_ips]
  foreach file $ipList {
    set_property used_in_simulation false [get_files $file.xci]
  }
  set_property used_in_simulation false [get_files "$customlogic_dir/02_coaxlink/hdl_enc/CustomLogicPkt.vp"]
  set_property used_in_simulation false [get_files "$customlogic_dir/02_coaxlink/hdl_enc/DmaBackEndPkt.vp"]
  set_property used_in_simulation false [get_files "$customlogic_dir/02_coaxlink/hdl_enc/CustomLogicPkt.vhdp"]
  set_property used_in_synthesis false [get_files "$customlogic_dir/04_ref_design/canny/sim/onboardmem/onboardmem.xci"]
  set_property used_in_implementation false [get_files "$customlogic_dir/04_ref_design/canny/sim/onboardmem/onboardmem.xci"]
  set_property used_in_simulation true [get_files "$customlogic_dir/04_ref_design/canny/sim/onboardmem/onboardmem.xci"]

  puts  "EURESYS_INFO: Creating the CustomLogic Vivado project... done"
}

customlogicCreateProject
