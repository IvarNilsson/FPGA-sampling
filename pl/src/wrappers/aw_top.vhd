library ieee;
use ieee.std_logic_1164.all;

entity aw_top is
   port (
      sys_clock : in std_logic;
      reset_rtl : in std_logic;
      reset     : in std_logic;

      full         : out std_logic;
      empty        : out std_logic;
      almost_full  : out std_logic;
      almost_empty : out std_logic
   );
end entity;
architecture structual of aw_top is
   signal rst_axi        : std_logic_vector (0 to 0);
   signal clk            : std_logic;
   signal sck_clk        : std_logic;
   signal clk_axi        : std_logic;
   signal data           : std_logic_vector(31 downto 0);
   signal pulse_rd_en    : std_logic;

   signal wr_en : std_logic;
   signal rd_en : std_logic_vector(69 downto 0);
   signal din_0 : std_logic_vector (31 downto 0);
begin
   demo_count : entity work.demo_counter
      port map(
         clk         => clk,
         reset       => reset,
         data        => din_0,
         almost_full => almost_full,
         wr_en       => wr_en
      );

   fifo_gen : entity work.fifo_bd_wrapper
      port map(
         FIFO_WRITE_full        => full,
         FIFO_READ_empty        => empty,
         FIFO_WRITE_almost_full => almost_full,
         FIFO_READ_almost_empty => almost_empty,
         FIFO_WRITE_wr_data     => din_0, --data in
         FIFO_WRITE_wr_en       => wr_en,
         FIFO_READ_rd_en        => pulse_rd_en, --- from pulse
         FIFO_READ_rd_data      => data,        --data out
         rd_clk                 => clk_axi,
         wr_clk                 => clk,
         reset                  => reset
      );
   axi_zynq_wrapper : entity work.zynq_bd_wrapper
      port map(
         clk_125   => clk,
         clk_25    => sck_clk,
         clk_axi   => clk_axi,
         reset_rtl => reset_rtl,
         rst_axi   => rst_axi,
         sys_clock => sys_clock,

         reg_mic_0_0 => data,
         reg_mic_1_0 => (others => '0'),
         reg_mic_2_0 => (others => '0'),
         reg_mic_3_0 => (others => '0'),
         reg_mic_4_0 => (others => '0'),
         reg_mic_5_0 => (others => '0'),
         reg_mic_6_0 => (others => '0'),
         reg_mic_7_0 => (others => '0'),
         reg_mic_8_0 => (others => '0'),
         reg_mic_9_0 => (others => '0'),
         reg_mic_10_0 => (others => '0'),
         reg_mic_11_0 => (others => '0'),
         reg_mic_12_0 => (others => '0'),
         reg_mic_13_0 => (others => '0'),
         reg_mic_14_0 => (others => '0'),
         reg_mic_15_0 => (others => '0'),
         reg_mic_16_0 => (others => '0'),
         reg_mic_17_0 => (others => '0'),
         reg_mic_18_0 => (others => '0'),
         reg_mic_19_0 => (others => '0'),
         reg_mic_20_0 => (others => '0'),
         reg_mic_21_0 => (others => '0'),
         reg_mic_22_0 => (others => '0'),
         reg_mic_23_0 => (others => '0'),
         reg_mic_24_0 => (others => '0'),
         reg_mic_25_0 => (others => '0'),
         reg_mic_26_0 => (others => '0'),
         reg_mic_27_0 => (others => '0'),
         reg_mic_28_0 => (others => '0'),
         reg_mic_29_0 => (others => '0'),
         reg_mic_30_0 => (others => '0'),
         reg_mic_31_0 => (others => '0'),
         reg_mic_32_0 => (others => '0'),
         reg_mic_33_0 => (others => '0'),
         reg_mic_34_0 => (others => '0'),
         reg_mic_35_0 => (others => '0'),
         reg_mic_36_0 => (others => '0'),
         reg_mic_37_0 => (others => '0'),
         reg_mic_38_0 => (others => '0'),
         reg_mic_39_0 => (others => '0'),
         reg_mic_40_0 => (others => '0'),
         reg_mic_41_0 => (others => '0'),
         reg_mic_42_0 => (others => '0'),
         reg_mic_43_0 => (others => '0'),
         reg_mic_44_0 => (others => '0'),
         reg_mic_45_0 => (others => '0'),
         reg_mic_46_0 => (others => '0'),
         reg_mic_47_0 => (others => '0'),
         reg_mic_48_0 => (others => '0'),
         reg_mic_49_0 => (others => '0'),
         reg_mic_50_0 => (others => '0'),
         reg_mic_51_0 => (others => '0'),
         reg_mic_52_0 => (others => '0'),
         reg_mic_53_0 => (others => '0'),
         reg_mic_54_0 => (others => '0'),
         reg_mic_55_0 => (others => '0'),
         reg_mic_56_0 => (others => '0'),
         reg_mic_57_0 => (others => '0'),
         reg_mic_58_0 => (others => '0'),
         reg_mic_59_0 => (others => '0'),
         reg_mic_60_0 => (others => '0'),
         reg_mic_61_0 => (others => '0'),
         reg_mic_62_0 => (others => '0'),
         reg_mic_63_0 => (others => '0'),
         reg_64_0 => (others => '0'),
         reg_65_0 => (others => '0'),
         reg_66_0 => (others => '0'),
         reg_67_0 => (others => '0'),
         reg_68_0 => (others => '0'),
         reg_69_0 => (others => '0'),
         rd_en => rd_en

      );

   pulse_gen : entity work.rd_en_pulse
      port map(
         clk_axi         => clk_axi,
         reset           => reset,
         rd_en_in  => rd_en(0),
         rd_en_out => pulse_rd_en
      );

end structual;