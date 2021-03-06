-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dilate is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_src_rows_read : IN STD_LOGIC_VECTOR (31 downto 0);
    p_src_cols_read : IN STD_LOGIC_VECTOR (31 downto 0);
    p_src_data_V_dout : IN STD_LOGIC_VECTOR (7 downto 0);
    p_src_data_V_empty_n : IN STD_LOGIC;
    p_src_data_V_read : OUT STD_LOGIC;
    p_dst_data_V_din : OUT STD_LOGIC_VECTOR (7 downto 0);
    p_dst_data_V_full_n : IN STD_LOGIC;
    p_dst_data_V_write : OUT STD_LOGIC;
    p_kernel_address0 : OUT STD_LOGIC_VECTOR (3 downto 0);
    p_kernel_ce0 : OUT STD_LOGIC;
    p_kernel_q0 : IN STD_LOGIC_VECTOR (7 downto 0) );
end;


architecture behav of dilate is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv2_3 : STD_LOGIC_VECTOR (1 downto 0) := "11";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal imgheight_fu_174_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal imgheight_reg_381 : STD_LOGIC_VECTOR (15 downto 0);
    signal imgwidth_fu_178_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal imgwidth_reg_386 : STD_LOGIC_VECTOR (15 downto 0);
    signal i_fu_188_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal i_reg_394 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal sub_ln371_fu_210_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal sub_ln371_reg_399 : STD_LOGIC_VECTOR (4 downto 0);
    signal icmp_ln367_fu_182_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal j_fu_258_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal j_reg_452 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal icmp_ln369_fu_252_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_xfdilate_fu_155_ap_start : STD_LOGIC;
    signal grp_xfdilate_fu_155_ap_done : STD_LOGIC;
    signal grp_xfdilate_fu_155_ap_idle : STD_LOGIC;
    signal grp_xfdilate_fu_155_ap_ready : STD_LOGIC;
    signal grp_xfdilate_fu_155_p_src_data_V_read : STD_LOGIC;
    signal grp_xfdilate_fu_155_p_dst_data_V_din : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_xfdilate_fu_155_p_dst_data_V_write : STD_LOGIC;
    signal i_0_reg_131 : STD_LOGIC_VECTOR (1 downto 0);
    signal j_0_reg_143 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal grp_xfdilate_fu_155_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal zext_ln371_2_fu_277_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal kernel_2_2_fu_70 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_1_fu_74 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_2_fu_78 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_3_fu_82 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_4_fu_86 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_5_fu_90 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_6_fu_94 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_7_fu_98 : STD_LOGIC_VECTOR (7 downto 0);
    signal kernel_2_2_8_fu_102 : STD_LOGIC_VECTOR (7 downto 0);
    signal shl_ln_fu_198_p3 : STD_LOGIC_VECTOR (3 downto 0);
    signal zext_ln371_1_fu_206_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln371_fu_194_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln371_3_fu_264_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal add_ln371_fu_268_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal sext_ln371_fu_273_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);

    component xfdilate IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        p_src_data_V_dout : IN STD_LOGIC_VECTOR (7 downto 0);
        p_src_data_V_empty_n : IN STD_LOGIC;
        p_src_data_V_read : OUT STD_LOGIC;
        p_dst_data_V_din : OUT STD_LOGIC_VECTOR (7 downto 0);
        p_dst_data_V_full_n : IN STD_LOGIC;
        p_dst_data_V_write : OUT STD_LOGIC;
        img_height : IN STD_LOGIC_VECTOR (15 downto 0);
        img_width : IN STD_LOGIC_VECTOR (15 downto 0);
        kernel_0_0_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_0_1_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_0_2_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_1_0_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_1_1_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_1_2_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_2_0_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_2_1_read : IN STD_LOGIC_VECTOR (7 downto 0);
        kernel_2_2_read : IN STD_LOGIC_VECTOR (7 downto 0) );
    end component;



begin
    grp_xfdilate_fu_155 : component xfdilate
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_xfdilate_fu_155_ap_start,
        ap_done => grp_xfdilate_fu_155_ap_done,
        ap_idle => grp_xfdilate_fu_155_ap_idle,
        ap_ready => grp_xfdilate_fu_155_ap_ready,
        p_src_data_V_dout => p_src_data_V_dout,
        p_src_data_V_empty_n => p_src_data_V_empty_n,
        p_src_data_V_read => grp_xfdilate_fu_155_p_src_data_V_read,
        p_dst_data_V_din => grp_xfdilate_fu_155_p_dst_data_V_din,
        p_dst_data_V_full_n => p_dst_data_V_full_n,
        p_dst_data_V_write => grp_xfdilate_fu_155_p_dst_data_V_write,
        img_height => imgheight_reg_381,
        img_width => imgwidth_reg_386,
        kernel_0_0_read => kernel_2_2_fu_70,
        kernel_0_1_read => kernel_2_2_1_fu_74,
        kernel_0_2_read => kernel_2_2_2_fu_78,
        kernel_1_0_read => kernel_2_2_3_fu_82,
        kernel_1_1_read => kernel_2_2_4_fu_86,
        kernel_1_2_read => kernel_2_2_5_fu_90,
        kernel_2_0_read => kernel_2_2_6_fu_94,
        kernel_2_1_read => kernel_2_2_7_fu_98,
        kernel_2_2_read => kernel_2_2_8_fu_102);





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


    grp_xfdilate_fu_155_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_xfdilate_fu_155_ap_start_reg <= ap_const_logic_0;
            else
                if (((icmp_ln367_fu_182_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    grp_xfdilate_fu_155_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_xfdilate_fu_155_ap_ready = ap_const_logic_1)) then 
                    grp_xfdilate_fu_155_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_0_reg_131_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln369_fu_252_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
                i_0_reg_131 <= i_reg_394;
            elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                i_0_reg_131 <= ap_const_lv2_0;
            end if; 
        end if;
    end process;

    j_0_reg_143_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
                j_0_reg_143 <= j_reg_452;
            elsif (((icmp_ln367_fu_182_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                j_0_reg_143 <= ap_const_lv2_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                i_reg_394 <= i_fu_188_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                imgheight_reg_381 <= imgheight_fu_174_p1;
                imgwidth_reg_386 <= imgwidth_fu_178_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                j_reg_452 <= j_fu_258_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state4) and (j_0_reg_143 = ap_const_lv2_1) and (i_0_reg_131 = ap_const_lv2_0))) then
                kernel_2_2_1_fu_74 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not((j_0_reg_143 = ap_const_lv2_1)) and not((j_0_reg_143 = ap_const_lv2_0)) and (ap_const_logic_1 = ap_CS_fsm_state4) and (i_0_reg_131 = ap_const_lv2_0))) then
                kernel_2_2_2_fu_78 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state4) and (i_0_reg_131 = ap_const_lv2_1) and (j_0_reg_143 = ap_const_lv2_0))) then
                kernel_2_2_3_fu_82 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state4) and (j_0_reg_143 = ap_const_lv2_1) and (i_0_reg_131 = ap_const_lv2_1))) then
                kernel_2_2_4_fu_86 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not((j_0_reg_143 = ap_const_lv2_1)) and not((j_0_reg_143 = ap_const_lv2_0)) and (ap_const_logic_1 = ap_CS_fsm_state4) and (i_0_reg_131 = ap_const_lv2_1))) then
                kernel_2_2_5_fu_90 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not((i_0_reg_131 = ap_const_lv2_1)) and not((i_0_reg_131 = ap_const_lv2_0)) and (ap_const_logic_1 = ap_CS_fsm_state4) and (j_0_reg_143 = ap_const_lv2_0))) then
                kernel_2_2_6_fu_94 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not((i_0_reg_131 = ap_const_lv2_1)) and not((i_0_reg_131 = ap_const_lv2_0)) and (ap_const_logic_1 = ap_CS_fsm_state4) and (j_0_reg_143 = ap_const_lv2_1))) then
                kernel_2_2_7_fu_98 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not((i_0_reg_131 = ap_const_lv2_1)) and not((j_0_reg_143 = ap_const_lv2_1)) and not((j_0_reg_143 = ap_const_lv2_0)) and not((i_0_reg_131 = ap_const_lv2_0)) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                kernel_2_2_8_fu_102 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state4) and (j_0_reg_143 = ap_const_lv2_0) and (i_0_reg_131 = ap_const_lv2_0))) then
                kernel_2_2_fu_70 <= p_kernel_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln367_fu_182_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                sub_ln371_reg_399 <= sub_ln371_fu_210_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_state2, icmp_ln367_fu_182_p2, ap_CS_fsm_state3, icmp_ln369_fu_252_p2, grp_xfdilate_fu_155_ap_done, ap_CS_fsm_state5)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln367_fu_182_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when ap_ST_fsm_state3 => 
                if (((icmp_ln369_fu_252_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state5 => 
                if (((grp_xfdilate_fu_155_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state5))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    add_ln371_fu_268_p2 <= std_logic_vector(unsigned(sub_ln371_reg_399) + unsigned(zext_ln371_3_fu_264_p1));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, grp_xfdilate_fu_155_ap_done, ap_CS_fsm_state5)
    begin
        if ((((grp_xfdilate_fu_155_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state5)) or ((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(grp_xfdilate_fu_155_ap_done, ap_CS_fsm_state5)
    begin
        if (((grp_xfdilate_fu_155_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state5))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    grp_xfdilate_fu_155_ap_start <= grp_xfdilate_fu_155_ap_start_reg;
    i_fu_188_p2 <= std_logic_vector(unsigned(i_0_reg_131) + unsigned(ap_const_lv2_1));
    icmp_ln367_fu_182_p2 <= "1" when (i_0_reg_131 = ap_const_lv2_3) else "0";
    icmp_ln369_fu_252_p2 <= "1" when (j_0_reg_143 = ap_const_lv2_3) else "0";
    imgheight_fu_174_p1 <= p_src_rows_read(16 - 1 downto 0);
    imgwidth_fu_178_p1 <= p_src_cols_read(16 - 1 downto 0);
    j_fu_258_p2 <= std_logic_vector(unsigned(j_0_reg_143) + unsigned(ap_const_lv2_1));
    p_dst_data_V_din <= grp_xfdilate_fu_155_p_dst_data_V_din;

    p_dst_data_V_write_assign_proc : process(grp_xfdilate_fu_155_p_dst_data_V_write, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            p_dst_data_V_write <= grp_xfdilate_fu_155_p_dst_data_V_write;
        else 
            p_dst_data_V_write <= ap_const_logic_0;
        end if; 
    end process;

    p_kernel_address0 <= zext_ln371_2_fu_277_p1(4 - 1 downto 0);

    p_kernel_ce0_assign_proc : process(ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            p_kernel_ce0 <= ap_const_logic_1;
        else 
            p_kernel_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    p_src_data_V_read_assign_proc : process(grp_xfdilate_fu_155_p_src_data_V_read, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            p_src_data_V_read <= grp_xfdilate_fu_155_p_src_data_V_read;
        else 
            p_src_data_V_read <= ap_const_logic_0;
        end if; 
    end process;

        sext_ln371_fu_273_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(add_ln371_fu_268_p2),32));

    shl_ln_fu_198_p3 <= (i_0_reg_131 & ap_const_lv2_0);
    sub_ln371_fu_210_p2 <= std_logic_vector(unsigned(zext_ln371_1_fu_206_p1) - unsigned(zext_ln371_fu_194_p1));
    zext_ln371_1_fu_206_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(shl_ln_fu_198_p3),5));
    zext_ln371_2_fu_277_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(sext_ln371_fu_273_p1),64));
    zext_ln371_3_fu_264_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(j_0_reg_143),5));
    zext_ln371_fu_194_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_0_reg_131),5));
end behav;
