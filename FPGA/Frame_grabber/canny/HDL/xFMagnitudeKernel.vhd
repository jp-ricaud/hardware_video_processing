-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xFMagnitudeKernel is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_src1_data_V_dout : IN STD_LOGIC_VECTOR (10 downto 0);
    p_src1_data_V_empty_n : IN STD_LOGIC;
    p_src1_data_V_read : OUT STD_LOGIC;
    p_src2_data_V_dout : IN STD_LOGIC_VECTOR (10 downto 0);
    p_src2_data_V_empty_n : IN STD_LOGIC;
    p_src2_data_V_read : OUT STD_LOGIC;
    p_dst_mat_data_V_din : OUT STD_LOGIC_VECTOR (13 downto 0);
    p_dst_mat_data_V_full_n : IN STD_LOGIC;
    p_dst_mat_data_V_write : OUT STD_LOGIC;
    imgheight_dout : IN STD_LOGIC_VECTOR (15 downto 0);
    imgheight_empty_n : IN STD_LOGIC;
    imgheight_read : OUT STD_LOGIC;
    imgwidth_dout : IN STD_LOGIC_VECTOR (15 downto 0);
    imgwidth_empty_n : IN STD_LOGIC;
    imgwidth_read : OUT STD_LOGIC );
end;


architecture behav of xFMagnitudeKernel is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (5 downto 0) := "000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (5 downto 0) := "000100";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (5 downto 0) := "001000";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (5 downto 0) := "010000";
    constant ap_ST_fsm_state12 : STD_LOGIC_VECTOR (5 downto 0) := "100000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv16_1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000001";
    constant ap_const_lv32_A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001010";
    constant ap_const_lv12_0 : STD_LOGIC_VECTOR (11 downto 0) := "000000000000";

    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal p_src1_data_V_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal icmp_ln82_reg_218 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_src2_data_V_blk_n : STD_LOGIC;
    signal p_dst_mat_data_V_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal icmp_ln82_reg_218_pp0_iter3_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal imgheight_blk_n : STD_LOGIC;
    signal imgwidth_blk_n : STD_LOGIC;
    signal j_0_i_reg_105 : STD_LOGIC_VECTOR (15 downto 0);
    signal imgheight_read_reg_199 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal imgwidth_read_reg_204 : STD_LOGIC_VECTOR (15 downto 0);
    signal icmp_ln76_fu_117_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln76_reg_209 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal grp_fu_122_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal i_reg_213 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal icmp_ln82_fu_128_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_state4_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state8_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state10_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal icmp_ln82_reg_218_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln82_reg_218_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_fu_133_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal j_reg_222 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_state5_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_state7_pp0_stage1_iter1 : BOOLEAN;
    signal ap_block_state9_pp0_stage1_iter2 : BOOLEAN;
    signal ap_block_state11_pp0_stage1_iter3 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal p_src1_data_V_read_reg_227 : STD_LOGIC_VECTOR (10 downto 0);
    signal p_src2_data_V_read_reg_232 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_reg_237 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_reg_237_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_16_reg_242 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_16_reg_242_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal sext_ln421_fu_155_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal sext_ln421_reg_247 : STD_LOGIC_VECTOR (11 downto 0);
    signal sext_ln100_fu_158_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal sext_ln100_reg_253 : STD_LOGIC_VECTOR (11 downto 0);
    signal grp_fu_161_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal sub_ln100_reg_259 : STD_LOGIC_VECTOR (11 downto 0);
    signal grp_fu_167_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal sub_ln100_1_reg_264 : STD_LOGIC_VECTOR (11 downto 0);
    signal select_ln100_fu_173_p3 : STD_LOGIC_VECTOR (11 downto 0);
    signal select_ln100_reg_269 : STD_LOGIC_VECTOR (11 downto 0);
    signal select_ln100_1_fu_178_p3 : STD_LOGIC_VECTOR (11 downto 0);
    signal select_ln100_1_reg_274 : STD_LOGIC_VECTOR (11 downto 0);
    signal grp_fu_189_p2 : STD_LOGIC_VECTOR (12 downto 0);
    signal add_ln104_reg_289 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state5 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal i_0_i_reg_93 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_CS_fsm_state12 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state12 : signal is "none";
    signal ap_phi_mux_j_0_i_phi_fu_109_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_block_pp0_stage1_01001 : BOOLEAN;
    signal tmp_fu_139_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_16_fu_147_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal grp_fu_161_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal grp_fu_167_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal grp_fu_189_p0 : STD_LOGIC_VECTOR (12 downto 0);
    signal grp_fu_189_p1 : STD_LOGIC_VECTOR (12 downto 0);
    signal grp_fu_133_ce : STD_LOGIC;
    signal grp_fu_161_ce : STD_LOGIC;
    signal grp_fu_167_ce : STD_LOGIC;
    signal grp_fu_189_ce : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;

    component ip_accel_app_add_fYi IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component ip_accel_app_sub_xdS IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (11 downto 0);
        din1 : IN STD_LOGIC_VECTOR (11 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (11 downto 0) );
    end component;


    component ip_accel_app_add_yd2 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (12 downto 0);
        din1 : IN STD_LOGIC_VECTOR (12 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (12 downto 0) );
    end component;



begin
    ip_accel_app_add_fYi_U187 : component ip_accel_app_add_fYi
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => i_0_i_reg_93,
        din1 => ap_const_lv16_1,
        ce => ap_const_logic_1,
        dout => grp_fu_122_p2);

    ip_accel_app_add_fYi_U188 : component ip_accel_app_add_fYi
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => ap_phi_mux_j_0_i_phi_fu_109_p4,
        din1 => ap_const_lv16_1,
        ce => grp_fu_133_ce,
        dout => grp_fu_133_p2);

    ip_accel_app_sub_xdS_U189 : component ip_accel_app_sub_xdS
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 12,
        din1_WIDTH => 12,
        dout_WIDTH => 12)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => ap_const_lv12_0,
        din1 => grp_fu_161_p1,
        ce => grp_fu_161_ce,
        dout => grp_fu_161_p2);

    ip_accel_app_sub_xdS_U190 : component ip_accel_app_sub_xdS
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 12,
        din1_WIDTH => 12,
        dout_WIDTH => 12)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => ap_const_lv12_0,
        din1 => grp_fu_167_p1,
        ce => grp_fu_167_ce,
        dout => grp_fu_167_p2);

    ip_accel_app_add_yd2_U191 : component ip_accel_app_add_yd2
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 13,
        din1_WIDTH => 13,
        dout_WIDTH => 13)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_189_p0,
        din1 => grp_fu_189_p1,
        ce => grp_fu_189_ce,
        dout => grp_fu_189_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((icmp_ln76_reg_209 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state5) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif (((icmp_ln76_reg_209 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) then
                    if ((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state5)) then 
                        ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state5);
                    elsif ((ap_const_boolean_1 = ap_const_boolean_1)) then 
                        ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                    end if;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                elsif (((icmp_ln76_reg_209 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
                    ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_0_i_reg_93_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state12)) then 
                i_0_i_reg_93 <= i_reg_213;
            elsif ((not(((imgwidth_empty_n = ap_const_logic_0) or (imgheight_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_0_i_reg_93 <= ap_const_lv16_0;
            end if; 
        end if;
    end process;

    j_0_i_reg_105_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                j_0_i_reg_105 <= j_reg_222;
            elsif (((icmp_ln76_reg_209 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
                j_0_i_reg_105 <= ap_const_lv16_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218_pp0_iter2_reg = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                add_ln104_reg_289 <= grp_fu_189_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                i_reg_213 <= grp_fu_122_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                icmp_ln76_reg_209 <= icmp_ln76_fu_117_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                icmp_ln82_reg_218 <= icmp_ln82_fu_128_p2;
                icmp_ln82_reg_218_pp0_iter1_reg <= icmp_ln82_reg_218;
                icmp_ln82_reg_218_pp0_iter2_reg <= icmp_ln82_reg_218_pp0_iter1_reg;
                icmp_ln82_reg_218_pp0_iter3_reg <= icmp_ln82_reg_218_pp0_iter2_reg;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((imgwidth_empty_n = ap_const_logic_0) or (imgheight_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                imgheight_read_reg_199 <= imgheight_dout;
                imgwidth_read_reg_204 <= imgwidth_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then
                j_reg_222 <= grp_fu_133_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then
                p_src1_data_V_read_reg_227 <= p_src1_data_V_dout;
                p_src2_data_V_read_reg_232 <= p_src2_data_V_dout;
                tmp_16_reg_242 <= tmp_16_fu_147_p1(10 downto 10);
                tmp_reg_237 <= tmp_fu_139_p1(10 downto 10);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                select_ln100_1_reg_274 <= select_ln100_1_fu_178_p3;
                select_ln100_reg_269 <= select_ln100_fu_173_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                sext_ln100_reg_253 <= sext_ln100_fu_158_p1;
                sext_ln421_reg_247 <= sext_ln421_fu_155_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (tmp_16_reg_242 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then
                sub_ln100_1_reg_264 <= grp_fu_167_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln82_reg_218_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (tmp_reg_237 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then
                sub_ln100_reg_259 <= grp_fu_161_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then
                tmp_16_reg_242_pp0_iter1_reg <= tmp_16_reg_242;
                tmp_reg_237_pp0_iter1_reg <= tmp_reg_237;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, imgheight_empty_n, imgwidth_empty_n, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, icmp_ln82_reg_218, ap_enable_reg_pp0_iter3, icmp_ln76_reg_209, ap_CS_fsm_state3, ap_block_pp0_stage1_subdone, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((imgwidth_empty_n = ap_const_logic_0) or (imgheight_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                if (((icmp_ln76_reg_209 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((not(((icmp_ln82_reg_218 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) and not(((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((((icmp_ln82_reg_218 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone)))) then
                    ap_NS_fsm <= ap_ST_fsm_state12;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_state12 => 
                ap_NS_fsm <= ap_ST_fsm_state2;
            when others =>  
                ap_NS_fsm <= "XXXXXX";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(3);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(4);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state12 <= ap_CS_fsm(5);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage1_01001_assign_proc : process(p_src1_data_V_empty_n, p_src2_data_V_empty_n, p_dst_mat_data_V_full_n, ap_enable_reg_pp0_iter0, icmp_ln82_reg_218, ap_enable_reg_pp0_iter3, icmp_ln82_reg_218_pp0_iter3_reg)
    begin
                ap_block_pp0_stage1_01001 <= (((icmp_ln82_reg_218_pp0_iter3_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src2_data_V_empty_n = ap_const_logic_0)) or ((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src1_data_V_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage1_11001_assign_proc : process(p_src1_data_V_empty_n, p_src2_data_V_empty_n, p_dst_mat_data_V_full_n, ap_enable_reg_pp0_iter0, icmp_ln82_reg_218, ap_enable_reg_pp0_iter3, icmp_ln82_reg_218_pp0_iter3_reg)
    begin
                ap_block_pp0_stage1_11001 <= (((icmp_ln82_reg_218_pp0_iter3_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src2_data_V_empty_n = ap_const_logic_0)) or ((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src1_data_V_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage1_subdone_assign_proc : process(p_src1_data_V_empty_n, p_src2_data_V_empty_n, p_dst_mat_data_V_full_n, ap_enable_reg_pp0_iter0, icmp_ln82_reg_218, ap_enable_reg_pp0_iter3, icmp_ln82_reg_218_pp0_iter3_reg)
    begin
                ap_block_pp0_stage1_subdone <= (((icmp_ln82_reg_218_pp0_iter3_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src2_data_V_empty_n = ap_const_logic_0)) or ((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src1_data_V_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, imgheight_empty_n, imgwidth_empty_n)
    begin
                ap_block_state1 <= ((imgwidth_empty_n = ap_const_logic_0) or (imgheight_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;

        ap_block_state10_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state11_pp0_stage1_iter3_assign_proc : process(p_dst_mat_data_V_full_n, icmp_ln82_reg_218_pp0_iter3_reg)
    begin
                ap_block_state11_pp0_stage1_iter3 <= ((icmp_ln82_reg_218_pp0_iter3_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0));
    end process;

        ap_block_state4_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state5_pp0_stage1_iter0_assign_proc : process(p_src1_data_V_empty_n, p_src2_data_V_empty_n, icmp_ln82_reg_218)
    begin
                ap_block_state5_pp0_stage1_iter0 <= (((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src2_data_V_empty_n = ap_const_logic_0)) or ((icmp_ln82_reg_218 = ap_const_lv1_0) and (p_src1_data_V_empty_n = ap_const_logic_0)));
    end process;

        ap_block_state6_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state7_pp0_stage1_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state8_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state9_pp0_stage1_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_pp0_exit_iter0_state5_assign_proc : process(icmp_ln82_reg_218)
    begin
        if ((icmp_ln82_reg_218 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state5 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state5 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_done_reg, icmp_ln76_reg_209, ap_CS_fsm_state3)
    begin
        if (((icmp_ln76_reg_209 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_j_0_i_phi_fu_109_p4_assign_proc : process(icmp_ln82_reg_218, j_0_i_reg_105, ap_CS_fsm_pp0_stage0, j_reg_222, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0)
    begin
        if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_phi_mux_j_0_i_phi_fu_109_p4 <= j_reg_222;
        else 
            ap_phi_mux_j_0_i_phi_fu_109_p4 <= j_0_i_reg_105;
        end if; 
    end process;


    ap_ready_assign_proc : process(icmp_ln76_reg_209, ap_CS_fsm_state3)
    begin
        if (((icmp_ln76_reg_209 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_133_ce_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001)) or ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
            grp_fu_133_ce <= ap_const_logic_1;
        else 
            grp_fu_133_ce <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_161_ce_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001)) or ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
            grp_fu_161_ce <= ap_const_logic_1;
        else 
            grp_fu_161_ce <= ap_const_logic_0;
        end if; 
    end process;

        grp_fu_161_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_src1_data_V_read_reg_227),12));


    grp_fu_167_ce_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001)) or ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
            grp_fu_167_ce <= ap_const_logic_1;
        else 
            grp_fu_167_ce <= ap_const_logic_0;
        end if; 
    end process;

        grp_fu_167_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_src2_data_V_read_reg_232),12));


    grp_fu_189_ce_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001)) or ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
            grp_fu_189_ce <= ap_const_logic_1;
        else 
            grp_fu_189_ce <= ap_const_logic_0;
        end if; 
    end process;

        grp_fu_189_p0 <= std_logic_vector(IEEE.numeric_std.resize(signed(select_ln100_1_reg_274),13));

        grp_fu_189_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(select_ln100_reg_269),13));

    icmp_ln76_fu_117_p2 <= "1" when (i_0_i_reg_93 = imgheight_read_reg_199) else "0";
    icmp_ln82_fu_128_p2 <= "1" when (ap_phi_mux_j_0_i_phi_fu_109_p4 = imgwidth_read_reg_204) else "0";

    imgheight_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, imgheight_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            imgheight_blk_n <= imgheight_empty_n;
        else 
            imgheight_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    imgheight_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, imgheight_empty_n, imgwidth_empty_n)
    begin
        if ((not(((imgwidth_empty_n = ap_const_logic_0) or (imgheight_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            imgheight_read <= ap_const_logic_1;
        else 
            imgheight_read <= ap_const_logic_0;
        end if; 
    end process;


    imgwidth_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, imgwidth_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            imgwidth_blk_n <= imgwidth_empty_n;
        else 
            imgwidth_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    imgwidth_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, imgheight_empty_n, imgwidth_empty_n)
    begin
        if ((not(((imgwidth_empty_n = ap_const_logic_0) or (imgheight_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            imgwidth_read <= ap_const_logic_1;
        else 
            imgwidth_read <= ap_const_logic_0;
        end if; 
    end process;


    p_dst_mat_data_V_blk_n_assign_proc : process(p_dst_mat_data_V_full_n, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1, ap_enable_reg_pp0_iter3, icmp_ln82_reg_218_pp0_iter3_reg)
    begin
        if (((icmp_ln82_reg_218_pp0_iter3_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            p_dst_mat_data_V_blk_n <= p_dst_mat_data_V_full_n;
        else 
            p_dst_mat_data_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

        p_dst_mat_data_V_din <= std_logic_vector(IEEE.numeric_std.resize(signed(add_ln104_reg_289),14));


    p_dst_mat_data_V_write_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter3, icmp_ln82_reg_218_pp0_iter3_reg, ap_block_pp0_stage1_11001)
    begin
        if (((icmp_ln82_reg_218_pp0_iter3_reg = ap_const_lv1_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then 
            p_dst_mat_data_V_write <= ap_const_logic_1;
        else 
            p_dst_mat_data_V_write <= ap_const_logic_0;
        end if; 
    end process;


    p_src1_data_V_blk_n_assign_proc : process(p_src1_data_V_empty_n, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, ap_block_pp0_stage1, icmp_ln82_reg_218)
    begin
        if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            p_src1_data_V_blk_n <= p_src1_data_V_empty_n;
        else 
            p_src1_data_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    p_src1_data_V_read_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, icmp_ln82_reg_218, ap_block_pp0_stage1_11001)
    begin
        if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then 
            p_src1_data_V_read <= ap_const_logic_1;
        else 
            p_src1_data_V_read <= ap_const_logic_0;
        end if; 
    end process;


    p_src2_data_V_blk_n_assign_proc : process(p_src2_data_V_empty_n, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, ap_block_pp0_stage1, icmp_ln82_reg_218)
    begin
        if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            p_src2_data_V_blk_n <= p_src2_data_V_empty_n;
        else 
            p_src2_data_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    p_src2_data_V_read_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, icmp_ln82_reg_218, ap_block_pp0_stage1_11001)
    begin
        if (((icmp_ln82_reg_218 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001))) then 
            p_src2_data_V_read <= ap_const_logic_1;
        else 
            p_src2_data_V_read <= ap_const_logic_0;
        end if; 
    end process;

    select_ln100_1_fu_178_p3 <= 
        sub_ln100_1_reg_264 when (tmp_16_reg_242_pp0_iter1_reg(0) = '1') else 
        sext_ln100_reg_253;
    select_ln100_fu_173_p3 <= 
        sub_ln100_reg_259 when (tmp_reg_237_pp0_iter1_reg(0) = '1') else 
        sext_ln421_reg_247;
        sext_ln100_fu_158_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_src2_data_V_read_reg_232),12));

        sext_ln421_fu_155_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_src1_data_V_read_reg_227),12));

    tmp_16_fu_147_p1 <= p_src2_data_V_dout;
    tmp_fu_139_p1 <= p_src1_data_V_dout;
end behav;
