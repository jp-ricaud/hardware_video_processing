--------------------------------------------------------------------------------
-- Project: CustomLogic
--------------------------------------------------------------------------------
--  Module: CustomLogic
--    File: CustomLogic.vhd
--    Date: 2019-10-24
--     Rev: 0.3
--  Author: PP
--------------------------------------------------------------------------------
-- CustomLogic wrapper for the user design
--------------------------------------------------------------------------------
-- 0.1, 2017-12-15, PP, Initial release
-- 0.2, 2019-07-12, PP, Updated CustomLogic interfaces
-- 0.3, 2019-10-24, PP, Added General Purpose I/O Interface
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CustomLogic is
  generic (
    STREAM_DATA_WIDTH     : natural := 128;
    MEMORY_DATA_WIDTH     : natural := 128
  );
    port (
    ---- CustomLogic Common Interfaces -------------------------------------
    -- Clock/Reset
    clk250            : in  std_logic;  -- Clock 250 MHz
    srst250           : in  std_logic;  -- Global reset (PCIe reset)
    -- General Purpose I/O Interface
    user_output_ctrl      : out std_logic_vector( 15 downto 0);
    user_output_status      : in  std_logic_vector(  7 downto 0);
    standard_io_set1_status   : in  std_logic_vector(  9 downto 0);
    standard_io_set2_status   : in  std_logic_vector(  9 downto 0);
    module_io_set_status    : in  std_logic_vector( 39 downto 0);
    -- Control Slave Interface
    s_ctrl_addr         : in  std_logic_vector( 15 downto 0);
    s_ctrl_data_wr_en     : in  std_logic;
    s_ctrl_data_wr        : in  std_logic_vector( 31 downto 0);
    s_ctrl_data_rd        : out std_logic_vector( 31 downto 0);
    -- On-Board Memory Master Interface (AXI 4)
    m_axi_resetn        : in  std_logic;  -- AXI 4 Interface reset
    m_axi_awaddr        : out std_logic_vector( 31 downto 0);
    m_axi_awlen         : out std_logic_vector(  7 downto 0);
    m_axi_awsize        : out std_logic_vector(  2 downto 0);
    m_axi_awburst         : out std_logic_vector(  1 downto 0);
    m_axi_awlock        : out std_logic;
    m_axi_awcache         : out std_logic_vector(  3 downto 0);
    m_axi_awprot        : out std_logic_vector(  2 downto 0);
    m_axi_awqos         : out std_logic_vector(  3 downto 0);
    m_axi_awvalid         : out std_logic;
    m_axi_awready         : in  std_logic;
    m_axi_wdata         : out std_logic_vector(MEMORY_DATA_WIDTH   - 1 downto 0);
    m_axi_wstrb         : out std_logic_vector(MEMORY_DATA_WIDTH/8 - 1 downto 0);
    m_axi_wlast         : out std_logic;
    m_axi_wvalid        : out std_logic;
    m_axi_wready        : in  std_logic;
    m_axi_bresp         : in  std_logic_vector(  1 downto 0);
    m_axi_bvalid        : in  std_logic;
    m_axi_bready        : out std_logic;
    m_axi_araddr        : out std_logic_vector( 31 downto 0);
    m_axi_arlen         : out std_logic_vector(  7 downto 0);
    m_axi_arsize        : out std_logic_vector(  2 downto 0);
    m_axi_arburst         : out std_logic_vector(  1 downto 0);
    m_axi_arlock        : out std_logic;
    m_axi_arcache         : out std_logic_vector(  3 downto 0);
    m_axi_arprot        : out std_logic_vector(  2 downto 0);
    m_axi_arqos         : out std_logic_vector(  3 downto 0);
    m_axi_arvalid         : out std_logic;
    m_axi_arready         : in  std_logic;
    m_axi_rdata         : in  std_logic_vector(MEMORY_DATA_WIDTH - 1 downto 0);
    m_axi_rresp         : in  std_logic_vector(  1 downto 0);
    m_axi_rlast         : in  std_logic;
    m_axi_rvalid        : in  std_logic;
    m_axi_rready        : out std_logic;
    ---- CustomLogic Device/Channel Interfaces -----------------------------
    -- AXI Stream Slave Interface
    s_axis_resetn       : in  std_logic;  -- AXI Stream Interface reset
    s_axis_tvalid       : in  std_logic;
    s_axis_tready       : out std_logic;
    s_axis_tdata        : in  std_logic_vector(STREAM_DATA_WIDTH - 1 downto 0);
    s_axis_tuser        : in  std_logic_vector(  3 downto 0);
    -- Metadata Slave Interface
    s_mdata_StreamId      : in  std_logic_vector( 7 downto 0);
    s_mdata_SourceTag     : in  std_logic_vector(15 downto 0);
    s_mdata_Xsize       : in  std_logic_vector(23 downto 0);
    s_mdata_Xoffs       : in  std_logic_vector(23 downto 0);
    s_mdata_Ysize       : in  std_logic_vector(23 downto 0);
    s_mdata_Yoffs       : in  std_logic_vector(23 downto 0);
    s_mdata_DsizeL        : in  std_logic_vector(23 downto 0);
    s_mdata_PixelF        : in  std_logic_vector(15 downto 0);
    s_mdata_TapG        : in  std_logic_vector(15 downto 0);
    s_mdata_Flags       : in  std_logic_vector( 7 downto 0);
    s_mdata_Timestamp     : in  std_logic_vector(31 downto 0);
    s_mdata_PixProcFlgs     : in  std_logic_vector( 7 downto 0);
    s_mdata_Status        : in  std_logic_vector(31 downto 0);
    -- AXI Stream Master Interface
    m_axis_tvalid       : out std_logic;
    m_axis_tready       : in  std_logic;
    m_axis_tdata        : out std_logic_vector(STREAM_DATA_WIDTH - 1 downto 0);
    m_axis_tuser        : out std_logic_vector(  3 downto 0);
    -- Metadata Master Interface
    m_mdata_StreamId      : out std_logic_vector( 7 downto 0);
    m_mdata_SourceTag     : out std_logic_vector(15 downto 0);
    m_mdata_Xsize       : out std_logic_vector(23 downto 0);
    m_mdata_Xoffs       : out std_logic_vector(23 downto 0);
    m_mdata_Ysize       : out std_logic_vector(23 downto 0);
    m_mdata_Yoffs       : out std_logic_vector(23 downto 0);
    m_mdata_DsizeL        : out std_logic_vector(23 downto 0);
    m_mdata_PixelF        : out std_logic_vector(15 downto 0);
    m_mdata_TapG        : out std_logic_vector(15 downto 0);
    m_mdata_Flags       : out std_logic_vector( 7 downto 0);
    m_mdata_Timestamp     : out std_logic_vector(31 downto 0);
    m_mdata_PixProcFlgs     : out std_logic_vector( 7 downto 0);
    m_mdata_Status        : out std_logic_vector(31 downto 0);
    -- Memento Master Interface
    m_memento_event       : out std_logic;
    m_memento_arg0        : out std_logic_vector(31 downto 0);
    m_memento_arg1        : out std_logic_vector(31 downto 0)
    );
end entity CustomLogic;

architecture behav of CustomLogic is

  ----------------------------------------------------------------------------
  -- Constants
  ----------------------------------------------------------------------------


  ----------------------------------------------------------------------------
  -- Types
  ----------------------------------------------------------------------------


  ----------------------------------------------------------------------------
  -- Functions
  ----------------------------------------------------------------------------


  ----------------------------------------------------------------------------
  -- Components
  ----------------------------------------------------------------------------


  ----------------------------------------------------------------------------
  -- Signals
  ----------------------------------------------------------------------------
  -- Control Registers
  signal MemTrafficGen_en         : std_logic;
  signal Frame2Line_bypass        : std_logic;
  signal MementoEvent_en          : std_logic;
  signal MementoEvent_arg0        : std_logic_vector(31 downto 0);
  signal PixelLut_bypass          : std_logic;
  signal PixelLut_coef_start        : std_logic;
  signal PixelLut_coef          : std_logic_vector( 7 downto 0);
  signal PixelLut_coef_vld        : std_logic;
  signal PixelLut_coef_done       : std_logic;
  signal PixelThreshold_bypass      : std_logic;
  signal PixelThreshold_level     : std_logic_vector( 7 downto 0);

  -- Pixel LUT
  signal PixelLut_tvalid          : std_logic;
  signal PixelLut_tready          : std_logic;
  signal PixelLut_tdata         : std_logic_vector(STREAM_DATA_WIDTH - 1 downto 0);
  signal PixelLut_tuser         : std_logic_vector( 3 downto 0);
  signal PixelLut_StreamId      : std_logic_vector( 7 downto 0);
  signal PixelLut_SourceTag     : std_logic_vector(15 downto 0);
  signal PixelLut_Xsize       : std_logic_vector(23 downto 0);
  signal PixelLut_Xoffs       : std_logic_vector(23 downto 0);
  signal PixelLut_Ysize       : std_logic_vector(23 downto 0);
  signal PixelLut_Yoffs       : std_logic_vector(23 downto 0);
  signal PixelLut_DsizeL        : std_logic_vector(23 downto 0);
  signal PixelLut_PixelF        : std_logic_vector(15 downto 0);
  signal PixelLut_TapG        : std_logic_vector(15 downto 0);
  signal PixelLut_Flags       : std_logic_vector( 7 downto 0);
  signal PixelLut_Timestamp     : std_logic_vector(31 downto 0);
  signal PixelLut_PixProcFlgs     : std_logic_vector( 7 downto 0);
  signal PixelLut_Status        : std_logic_vector(31 downto 0);

  -- HLS Pixel Threshold
  signal HlsPixTh_tvalid          : std_logic;
  signal HlsPixTh_tready          : std_logic;
  signal HlsPixTh_tdata         : std_logic_vector(STREAM_DATA_WIDTH - 1 downto 0);
  signal HlsPixTh_tuser         : std_logic_vector( 3 downto 0);
  signal HlsPixTh_StreamId      : std_logic_vector( 7 downto 0);
  signal HlsPixTh_SourceTag     : std_logic_vector(15 downto 0);
  signal HlsPixTh_Xsize       : std_logic_vector(23 downto 0);
  signal HlsPixTh_Xoffs       : std_logic_vector(23 downto 0);
  signal HlsPixTh_Ysize       : std_logic_vector(23 downto 0);
  signal HlsPixTh_Yoffs       : std_logic_vector(23 downto 0);
  signal HlsPixTh_DsizeL        : std_logic_vector(23 downto 0);
  signal HlsPixTh_PixelF        : std_logic_vector(15 downto 0);
  signal HlsPixTh_TapG        : std_logic_vector(15 downto 0);
  signal HlsPixTh_Flags       : std_logic_vector( 7 downto 0);
  signal HlsPixTh_Timestamp     : std_logic_vector(31 downto 0);
  signal HlsPixTh_PixProcFlgs     : std_logic_vector( 7 downto 0);
  signal HlsPixTh_Status        : std_logic_vector(31 downto 0);

  -- Memento Events
  signal Wraparound_pls         : std_logic;
  signal Wraparound_cnt         : std_logic_vector(31 downto 0);


  ----------------------------------------------------------------------------
  -- Debug
  ----------------------------------------------------------------------------
  -- attribute mark_debug : string;
  -- attribute mark_debug of s_axis_resetn  : signal is "true";
  -- attribute mark_debug of s_axis_tvalid  : signal is "true";
  -- attribute mark_debug of s_axis_tready  : signal is "true";
  -- attribute mark_debug of s_axis_tuser   : signal is "true";


begin

  -- Control Registers
  iControlRegs : entity work.control_registers
    port map (
      clk             => clk250,
      srst            => srst250,
      s_ctrl_addr         => s_ctrl_addr,
      s_ctrl_data_wr_en     => s_ctrl_data_wr_en,
      s_ctrl_data_wr        => s_ctrl_data_wr,
      s_ctrl_data_rd        => s_ctrl_data_rd,
      MemTrafficGen_en      => MemTrafficGen_en,
      UserOutput_ctrl       => user_output_ctrl,
      UserOutput_status     => user_output_status,
      StandardIoSet1_status   => standard_io_set1_status,
      StandardIoSet2_status   => standard_io_set2_status,
      ModuleIoSet_status      => module_io_set_status,
      Frame2Line_bypass(0)    => Frame2Line_bypass,
      MementoEvent_en(0)      => MementoEvent_en,
      MementoEvent_arg0     => MementoEvent_arg0,
      PixelLut_bypass(0)      => PixelLut_bypass,
      PixelLut_coef_start(0)    => PixelLut_coef_start,
      PixelLut_coef_vld(0)    => PixelLut_coef_vld,
      PixelLut_coef       => PixelLut_coef,
      PixelLut_coef_done(0)   => PixelLut_coef_done,
      PixelThreshold_bypass(0)  => PixelThreshold_bypass,
      PixelThreshold_level    => PixelThreshold_level
    );

  -- Read/Write On-Board Memory
  iMemTrafficGen : entity work.mem_traffic_gen
    generic map (
      DATA_WIDTH      => MEMORY_DATA_WIDTH
    )
    port map (
      clk         => clk250,
      MemTrafficGen_en  => MemTrafficGen_en,
      Wraparound_pls    => Wraparound_pls,
      Wraparound_cnt    => Wraparound_cnt,
      m_axi_resetn    => m_axi_resetn,
      m_axi_awaddr    => m_axi_awaddr,
      m_axi_awlen     => m_axi_awlen,
      m_axi_awsize    => m_axi_awsize,
      m_axi_awburst     => m_axi_awburst,
      m_axi_awlock    => m_axi_awlock,
      m_axi_awcache     => m_axi_awcache,
      m_axi_awprot    => m_axi_awprot,
      m_axi_awqos     => m_axi_awqos,
      m_axi_awvalid     => m_axi_awvalid,
      m_axi_awready     => m_axi_awready,
      m_axi_wdata     => m_axi_wdata,
      m_axi_wstrb     => m_axi_wstrb,
      m_axi_wlast     => m_axi_wlast,
      m_axi_wvalid    => m_axi_wvalid,
      m_axi_wready    => m_axi_wready,
      m_axi_bresp     => m_axi_bresp,
      m_axi_bvalid    => m_axi_bvalid,
      m_axi_bready    => m_axi_bready,
      m_axi_araddr    => m_axi_araddr,
      m_axi_arlen     => m_axi_arlen,
      m_axi_arsize    => m_axi_arsize,
      m_axi_arburst     => m_axi_arburst,
      m_axi_arlock    => m_axi_arlock,
      m_axi_arcache     => m_axi_arcache,
      m_axi_arprot    => m_axi_arprot,
      m_axi_arqos     => m_axi_arqos,
      m_axi_arvalid     => m_axi_arvalid,
      m_axi_arready     => m_axi_arready,
      m_axi_rdata     => m_axi_rdata,
      m_axi_rresp     => m_axi_rresp,
      m_axi_rlast     => m_axi_rlast,
      m_axi_rvalid    => m_axi_rvalid,
      m_axi_rready    => m_axi_rready
    );

  -- Pixel Lookup Table 8-bit
  iPixelLut : entity work.pix_lut8b
    generic map (
      DATA_WIDTH          => STREAM_DATA_WIDTH
    )
    port map (
      clk             => clk250,
      srst            => srst250,
      PixelLut_bypass       => PixelLut_bypass,
      PixelLut_coef_start     => PixelLut_coef_start,
      PixelLut_coef_vld     => PixelLut_coef_vld,
      PixelLut_coef       => PixelLut_coef,
      PixelLut_coef_done      => PixelLut_coef_done,
      s_axis_resetn         => s_axis_resetn,
      s_axis_tvalid       => s_axis_tvalid,
      s_axis_tready       => s_axis_tready,
      s_axis_tdata        => s_axis_tdata,
      s_axis_tuser        => s_axis_tuser,
      s_mdata_StreamId      => s_mdata_StreamId,
      s_mdata_SourceTag     => s_mdata_SourceTag,
      s_mdata_Xsize       => s_mdata_Xsize,
      s_mdata_Xoffs       => s_mdata_Xoffs,
      s_mdata_Ysize       => s_mdata_Ysize,
      s_mdata_Yoffs       => s_mdata_Yoffs,
      s_mdata_DsizeL        => s_mdata_DsizeL,
      s_mdata_PixelF        => s_mdata_PixelF,
      s_mdata_TapG        => s_mdata_TapG,
      s_mdata_Flags       => s_mdata_Flags,
      s_mdata_Timestamp     => s_mdata_Timestamp,
      s_mdata_PixProcFlgs     => s_mdata_PixProcFlgs,
      s_mdata_Status        => s_mdata_Status,
      m_axis_tvalid       => PixelLut_tvalid,
      m_axis_tready       => PixelLut_tready,
      m_axis_tdata        => PixelLut_tdata,
      m_axis_tuser        => PixelLut_tuser,
      m_mdata_StreamId      => PixelLut_StreamId,
      m_mdata_SourceTag     => PixelLut_SourceTag,
      m_mdata_Xsize       => PixelLut_Xsize,
      m_mdata_Xoffs       => PixelLut_Xoffs,
      m_mdata_Ysize       => PixelLut_Ysize,
      m_mdata_Yoffs       => PixelLut_Yoffs,
      m_mdata_DsizeL        => PixelLut_DsizeL,
      m_mdata_PixelF        => PixelLut_PixelF,
      m_mdata_TapG        => PixelLut_TapG,
      m_mdata_Flags       => PixelLut_Flags,
      m_mdata_Timestamp     => PixelLut_Timestamp,
      m_mdata_PixProcFlgs     => PixelLut_PixProcFlgs,
      m_mdata_Status        => PixelLut_Status
    );

  -- HLS Pixel Threshold
  iHlsPixTh : entity work.pix_threshold_wrp
    generic map (
      DATA_WIDTH          => STREAM_DATA_WIDTH
    )
    port map (
      clk             => clk250,
      srst            => srst250,
      HlsThreshold_bypass     => PixelThreshold_bypass,
      HlsThreshold_level      => PixelThreshold_level,
      s_axis_resetn         => s_axis_resetn,
      s_axis_tvalid       => PixelLut_tvalid,
      s_axis_tready       => PixelLut_tready,
      s_axis_tdata        => PixelLut_tdata,
      s_axis_tuser        => PixelLut_tuser,
      s_mdata_StreamId      => PixelLut_StreamId,
      s_mdata_SourceTag     => PixelLut_SourceTag,
      s_mdata_Xsize       => PixelLut_Xsize,
      s_mdata_Xoffs       => PixelLut_Xoffs,
      s_mdata_Ysize       => PixelLut_Ysize,
      s_mdata_Yoffs       => PixelLut_Yoffs,
      s_mdata_DsizeL        => PixelLut_DsizeL,
      s_mdata_PixelF        => PixelLut_PixelF,
      s_mdata_TapG        => PixelLut_TapG,
      s_mdata_Flags       => PixelLut_Flags,
      s_mdata_Timestamp     => PixelLut_Timestamp,
      s_mdata_PixProcFlgs     => PixelLut_PixProcFlgs,
      s_mdata_Status        => PixelLut_Status,
      m_axis_tvalid       => HlsPixTh_tvalid,
      m_axis_tready       => HlsPixTh_tready,
      m_axis_tdata        => HlsPixTh_tdata,
      m_axis_tuser        => HlsPixTh_tuser,
      m_mdata_StreamId      => HlsPixTh_StreamId,
      m_mdata_SourceTag     => HlsPixTh_SourceTag,
      m_mdata_Xsize       => HlsPixTh_Xsize,
      m_mdata_Xoffs       => HlsPixTh_Xoffs,
      m_mdata_Ysize       => HlsPixTh_Ysize,
      m_mdata_Yoffs       => HlsPixTh_Yoffs,
      m_mdata_DsizeL        => HlsPixTh_DsizeL,
      m_mdata_PixelF        => HlsPixTh_PixelF,
      m_mdata_TapG        => HlsPixTh_TapG,
      m_mdata_Flags       => HlsPixTh_Flags,
      m_mdata_Timestamp     => HlsPixTh_Timestamp,
      m_mdata_PixProcFlgs     => HlsPixTh_PixProcFlgs,
      m_mdata_Status        => HlsPixTh_Status
    );

  -- Frame to Line
  iFrame2Line : entity work.frame_to_line
    generic map (
      DATA_WIDTH          => STREAM_DATA_WIDTH
    )
    port map (
      clk             => clk250,
      srst            => srst250,
      Frame2Line_bypass     => Frame2Line_bypass,
      s_axis_resetn         => s_axis_resetn,
      s_axis_tvalid       => HlsPixTh_tvalid,
      s_axis_tready       => HlsPixTh_tready,
      s_axis_tdata        => HlsPixTh_tdata,
      s_axis_tuser        => HlsPixTh_tuser,
      s_mdata_StreamId      => HlsPixTh_StreamId,
      s_mdata_SourceTag     => HlsPixTh_SourceTag,
      s_mdata_Xsize       => HlsPixTh_Xsize,
      s_mdata_Xoffs       => HlsPixTh_Xoffs,
      s_mdata_Ysize       => HlsPixTh_Ysize,
      s_mdata_Yoffs       => HlsPixTh_Yoffs,
      s_mdata_DsizeL        => HlsPixTh_DsizeL,
      s_mdata_PixelF        => HlsPixTh_PixelF,
      s_mdata_TapG        => HlsPixTh_TapG,
      s_mdata_Flags       => HlsPixTh_Flags,
      s_mdata_Timestamp     => HlsPixTh_Timestamp,
      s_mdata_PixProcFlgs     => HlsPixTh_PixProcFlgs,
      s_mdata_Status        => HlsPixTh_Status,
      m_axis_tvalid       => m_axis_tvalid,
      m_axis_tready       => m_axis_tready,
      m_axis_tdata        => m_axis_tdata,
      m_axis_tuser        => m_axis_tuser,
      m_mdata_StreamId      => m_mdata_StreamId,
      m_mdata_SourceTag     => m_mdata_SourceTag,
      m_mdata_Xsize       => m_mdata_Xsize,
      m_mdata_Xoffs       => m_mdata_Xoffs,
      m_mdata_Ysize       => m_mdata_Ysize,
      m_mdata_Yoffs       => m_mdata_Yoffs,
      m_mdata_DsizeL        => m_mdata_DsizeL,
      m_mdata_PixelF        => m_mdata_PixelF,
      m_mdata_TapG        => m_mdata_TapG,
      m_mdata_Flags       => m_mdata_Flags,
      m_mdata_Timestamp     => m_mdata_Timestamp,
      m_mdata_PixProcFlgs     => m_mdata_PixProcFlgs,
      m_mdata_Status        => m_mdata_Status
    );

  -- Generate CustomLogic events on Memento
  m_memento_event   <= MementoEvent_en or Wraparound_pls;
  m_memento_arg0    <= MementoEvent_arg0;
  m_memento_arg1    <= Wraparound_cnt;

end behav;
