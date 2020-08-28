-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Threshold is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_src_mat_rows_read : IN STD_LOGIC_VECTOR (31 downto 0);
    p_src_mat_cols_read : IN STD_LOGIC_VECTOR (31 downto 0);
    p_src_mat_data_V_dout : IN STD_LOGIC_VECTOR (7 downto 0);
    p_src_mat_data_V_empty_n : IN STD_LOGIC;
    p_src_mat_data_V_read : OUT STD_LOGIC;
    p_dst_mat_data_V_din : OUT STD_LOGIC_VECTOR (7 downto 0);
    p_dst_mat_data_V_full_n : IN STD_LOGIC;
    p_dst_mat_data_V_write : OUT STD_LOGIC;
    thresh : IN STD_LOGIC_VECTOR (7 downto 0);
    maxval : IN STD_LOGIC_VECTOR (7 downto 0) );
end;


architecture behav of Threshold is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv13_0 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000000";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    constant ap_const_lv13_1 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    constant ap_const_lv16_1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000001";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal p_src_mat_data_V_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal icmp_ln71_reg_200 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_dst_mat_data_V_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal icmp_ln71_reg_200_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal t_V_reg_114 : STD_LOGIC_VECTOR (15 downto 0);
    signal width_fu_125_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal width_reg_181 : STD_LOGIC_VECTOR (15 downto 0);
    signal height_fu_129_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal height_reg_186 : STD_LOGIC_VECTOR (15 downto 0);
    signal icmp_ln887_fu_137_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal i_V_fu_142_p2 : STD_LOGIC_VECTOR (12 downto 0);
    signal i_V_reg_195 : STD_LOGIC_VECTOR (12 downto 0);
    signal icmp_ln71_fu_148_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state3_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal add_ln1597_fu_153_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal icmp_ln895_fu_159_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln895_reg_209 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state3 : STD_LOGIC;
    signal t_V_1_reg_103 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal zext_ln887_fu_133_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;


begin




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


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state3) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif (((icmp_ln887_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
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
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then
                    if ((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state3)) then 
                        ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state3);
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
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                elsif (((icmp_ln887_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    t_V_1_reg_103_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
                t_V_1_reg_103 <= i_V_reg_195;
            elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                t_V_1_reg_103 <= ap_const_lv13_0;
            end if; 
        end if;
    end process;

    t_V_reg_114_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln71_fu_148_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                t_V_reg_114 <= add_ln1597_fu_153_p2;
            elsif (((icmp_ln887_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                t_V_reg_114 <= ap_const_lv16_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                height_reg_186 <= height_fu_129_p1;
                width_reg_181 <= width_fu_125_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                i_V_reg_195 <= i_V_fu_142_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln71_reg_200 <= icmp_ln71_fu_148_p2;
                icmp_ln71_reg_200_pp0_iter1_reg <= icmp_ln71_reg_200;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln71_reg_200 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln895_reg_209 <= icmp_ln895_fu_159_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, icmp_ln887_fu_137_p2, ap_CS_fsm_state2, icmp_ln71_fu_148_p2, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln887_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((icmp_ln71_fu_148_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) and not(((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) or ((icmp_ln71_fu_148_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone)))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state2;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    add_ln1597_fu_153_p2 <= std_logic_vector(unsigned(t_V_reg_114) + unsigned(ap_const_lv16_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(2);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state6 <= ap_CS_fsm(3);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(p_src_mat_data_V_empty_n, p_dst_mat_data_V_full_n, ap_enable_reg_pp0_iter1, icmp_ln71_reg_200, ap_enable_reg_pp0_iter2, icmp_ln71_reg_200_pp0_iter1_reg)
    begin
                ap_block_pp0_stage0_01001 <= (((icmp_ln71_reg_200_pp0_iter1_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((icmp_ln71_reg_200 = ap_const_lv1_0) and (p_src_mat_data_V_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(p_src_mat_data_V_empty_n, p_dst_mat_data_V_full_n, ap_enable_reg_pp0_iter1, icmp_ln71_reg_200, ap_enable_reg_pp0_iter2, icmp_ln71_reg_200_pp0_iter1_reg)
    begin
                ap_block_pp0_stage0_11001 <= (((icmp_ln71_reg_200_pp0_iter1_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((icmp_ln71_reg_200 = ap_const_lv1_0) and (p_src_mat_data_V_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(p_src_mat_data_V_empty_n, p_dst_mat_data_V_full_n, ap_enable_reg_pp0_iter1, icmp_ln71_reg_200, ap_enable_reg_pp0_iter2, icmp_ln71_reg_200_pp0_iter1_reg)
    begin
                ap_block_pp0_stage0_subdone <= (((icmp_ln71_reg_200_pp0_iter1_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((icmp_ln71_reg_200 = ap_const_lv1_0) and (p_src_mat_data_V_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)));
    end process;

        ap_block_state3_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state4_pp0_stage0_iter1_assign_proc : process(p_src_mat_data_V_empty_n, icmp_ln71_reg_200)
    begin
                ap_block_state4_pp0_stage0_iter1 <= ((icmp_ln71_reg_200 = ap_const_lv1_0) and (p_src_mat_data_V_empty_n = ap_const_logic_0));
    end process;


    ap_block_state5_pp0_stage0_iter2_assign_proc : process(p_dst_mat_data_V_full_n, icmp_ln71_reg_200_pp0_iter1_reg)
    begin
                ap_block_state5_pp0_stage0_iter2 <= ((icmp_ln71_reg_200_pp0_iter1_reg = ap_const_lv1_0) and (p_dst_mat_data_V_full_n = ap_const_logic_0));
    end process;


    ap_condition_pp0_exit_iter0_state3_assign_proc : process(icmp_ln71_fu_148_p2)
    begin
        if ((icmp_ln71_fu_148_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state3 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state3 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, icmp_ln887_fu_137_p2, ap_CS_fsm_state2)
    begin
        if ((((icmp_ln887_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2)) or ((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
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


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter0)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(icmp_ln887_fu_137_p2, ap_CS_fsm_state2)
    begin
        if (((icmp_ln887_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    height_fu_129_p1 <= p_src_mat_rows_read(16 - 1 downto 0);
    i_V_fu_142_p2 <= std_logic_vector(unsigned(t_V_1_reg_103) + unsigned(ap_const_lv13_1));
    icmp_ln71_fu_148_p2 <= "1" when (t_V_reg_114 = width_reg_181) else "0";
    icmp_ln887_fu_137_p2 <= "1" when (unsigned(zext_ln887_fu_133_p1) < unsigned(height_reg_186)) else "0";
    icmp_ln895_fu_159_p2 <= "1" when (unsigned(p_src_mat_data_V_dout) > unsigned(thresh)) else "0";

    p_dst_mat_data_V_blk_n_assign_proc : process(p_dst_mat_data_V_full_n, ap_block_pp0_stage0, ap_enable_reg_pp0_iter2, icmp_ln71_reg_200_pp0_iter1_reg)
    begin
        if (((icmp_ln71_reg_200_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            p_dst_mat_data_V_blk_n <= p_dst_mat_data_V_full_n;
        else 
            p_dst_mat_data_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    p_dst_mat_data_V_din <= 
        maxval when (icmp_ln895_reg_209(0) = '1') else 
        ap_const_lv8_0;

    p_dst_mat_data_V_write_assign_proc : process(ap_enable_reg_pp0_iter2, icmp_ln71_reg_200_pp0_iter1_reg, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln71_reg_200_pp0_iter1_reg = ap_const_lv1_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            p_dst_mat_data_V_write <= ap_const_logic_1;
        else 
            p_dst_mat_data_V_write <= ap_const_logic_0;
        end if; 
    end process;


    p_src_mat_data_V_blk_n_assign_proc : process(p_src_mat_data_V_empty_n, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln71_reg_200)
    begin
        if (((icmp_ln71_reg_200 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            p_src_mat_data_V_blk_n <= p_src_mat_data_V_empty_n;
        else 
            p_src_mat_data_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    p_src_mat_data_V_read_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, icmp_ln71_reg_200, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln71_reg_200 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            p_src_mat_data_V_read <= ap_const_logic_1;
        else 
            p_src_mat_data_V_read <= ap_const_logic_0;
        end if; 
    end process;

    width_fu_125_p1 <= p_src_mat_cols_read(16 - 1 downto 0);
    zext_ln887_fu_133_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t_V_1_reg_103),16));
end behav;