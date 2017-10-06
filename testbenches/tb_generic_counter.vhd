--author     :broquet.antonin@gmail.com
--date       :06/10/2017
--file       :tb_generic_counter.vhd
--description:testbench of generic counter

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.m4x4_mult_pkg.all;

entity tb_generic_counter is
end entity;

architecture Behavorial of tb_generic_counter is

  constant clk_period : time := 4 ns;

  signal clk_i : std_logic;
  signal rst_i : std_logic;
  signal ena_i : std_logic;
  signal clr_i : std_logic;
  signal ofw_o : std_logic;
  signal cnt_o : std_logic_vector(3 downto 0);

begin

  uut:generic_counter
    generic map (
      g_width => 4
      )
    port map (
      clk_i => clk_i,
      rst_i => rst_i,
      ena_i => ena_i,
      clr_i => clr_i,
      ofw_o => ofw_o,
      cnt_o => cnt_o
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
    rst_i <= '0';
    ena_i <= '0';
    clr_i <= '0';
    wait for 13 ns;
    rst_i <= '1';
    wait for 52 ns;
    rst_i <= '0';
    wait for 72 ns;
    ena_i <= '1';
    wait for 157 ns;
    ena_i <= '0';
    wait for 122 ns;
    ena_i <= '1';
    wait for 253 ns;
    clr_i <= '1';
    wait for 162 ns;
    clr_i <= '0';
    wait for 157 ns;
    ena_i <= '0';


    wait;
  end process;

end architecture;
