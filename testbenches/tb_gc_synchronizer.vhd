--author     :broquet.antonin@gmail.com
--date       :10/12/2017
--file       :tb_gc_synchronizer.vhd
--description:testbench of generic synchronizer

library ieee;
use ieee.std_logic_1164.all;

entity tb_gc_synchronizer is
end entity;

architecture Behavorial of tb_gc_synchronizer is

  constant clk_period : time := 4 ns;

  signal clk_i : std_logic;
  signal rst_i : std_logic;
  signal d_i : std_logic;
  signal q_o : std_logic;

  component gc_synchronizer is
    generic (
      g_reset_active_level : string := "high");
    port (
      clk_i : in  std_logic;
      rst_i : in  std_logic;
      d_i   : in  std_logic;
      q_o   : out std_logic);
  end component;
  
begin

  --default active reset high
  uut_high:gc_synchronizer
--    generic map (
--      g_reset_active_level => "low")
    port map (
      clk_i => clk_i,
      rst_i => rst_i,
      d_i => d_i,
      q_o => q_o
      );

  clock:process
  begin
    clk_i <= '0';
    wait for clk_period/2;
    clk_i <= '1';
    wait for clk_period/2;
  end process;

  stimuli:process
  begin
    d_i <= '1';
    --active high
    rst_i <= '0';
    wait for 13 ns;
    rst_i <= '1';
    wait for 52 ns;
    rst_i <= '0';
    --active low
--    rst_i <= '1';
--    wait for 13 ns;
--    rst_i <= '0';
--    wait for 52 ns;
--    rst_i <= '1';

    wait;
  end process;

end architecture;
