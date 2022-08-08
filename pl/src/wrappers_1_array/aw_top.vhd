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
         reg_mic_0 => data,

         reg_mic_1 => (others => '0'),
         reg_mic_2 => (others => '0'),
         reg_mic_3 => (others => '0'),
         reg_mic_4 => (others => '0'),
         reg_mic_5 => (others => '0'),
         reg_mic_6 => (others => '0'),
         reg_mic_7 => (others => '0'),
         reg_mic_8 => (others => '0'),
         reg_mic_9 => (others => '0'),
         reg_mic_10 => (others => '0'),
         reg_mic_11 => (others => '0'),
         reg_mic_12 => (others => '0'),
         reg_mic_13 => (others => '0'),
         reg_mic_14 => (others => '0'),
         reg_mic_15 => (others => '0'),
         reg_mic_16 => (others => '0'),
         reg_mic_17 => (others => '0'),
         reg_mic_18 => (others => '0'),
         reg_mic_19 => (others => '0'),
         reg_mic_20 => (others => '0'),
         reg_mic_21 => (others => '0'),
         reg_mic_22 => (others => '0'),
         reg_mic_23 => (others => '0'),
         reg_mic_24 => (others => '0'),
         reg_mic_25 => (others => '0'),
         reg_mic_26 => (others => '0'),
         reg_mic_27 => (others => '0'),
         reg_mic_28 => (others => '0'),
         reg_mic_29 => (others => '0'),
         reg_mic_30 => (others => '0'),
         reg_mic_31 => (others => '0'),
         reg_mic_32 => (others => '0'),
         reg_mic_33 => (others => '0'),
         reg_mic_34 => (others => '0'),
         reg_mic_35 => (others => '0'),
         reg_mic_36 => (others => '0'),
         reg_mic_37 => (others => '0'),
         reg_mic_38 => (others => '0'),
         reg_mic_39 => (others => '0'),
         reg_mic_40 => (others => '0'),
         reg_mic_41 => (others => '0'),
         reg_mic_42 => (others => '0'),
         reg_mic_43 => (others => '0'),
         reg_mic_44 => (others => '0'),
         reg_mic_45 => (others => '0'),
         reg_mic_46 => (others => '0'),
         reg_mic_47 => (others => '0'),
         reg_mic_48 => (others => '0'),
         reg_mic_49 => (others => '0'),
         reg_mic_50 => (others => '0'),
         reg_mic_51 => (others => '0'),
         reg_mic_52 => (others => '0'),
         reg_mic_53 => (others => '0'),
         reg_mic_54 => (others => '0'),
         reg_mic_55 => (others => '0'),
         reg_mic_56 => (others => '0'),
         reg_mic_57 => (others => '0'),
         reg_mic_58 => (others => '0'),
         reg_mic_59 => (others => '0'),
         reg_mic_60 => (others => '0'),
         reg_mic_61 => (others => '0'),
         reg_mic_62 => (others => '0'),
         reg_mic_63 => (others => '0'),
         reg_64 => (others => '0'),
         reg_65 => (others => '0'),
         reg_66 => (others => '0'),
         reg_67 => (others => '0'),
         reg_68 => (others => '0'),
         reg_69 => (others => '0'),

         rd_en <= rd_en

      );

   pulse_gen : entity work.rd_en_pulse
      port map(
         clk_axi         => clk_axi,
         reset           => reset,
         rd_en_array_in  => rd_en(0),
         rd_en_array_out => pulse_rd_en
      );

end structual;