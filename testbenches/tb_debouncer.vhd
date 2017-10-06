--author     :broquet.antonin@gmail.com
--date       :06/10/2017
--file       :tb_debouncer.vhd
--description:testbench of debouncer

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.m4x4_mult_pkg.all;
use work.general_pkg.all;

entity tb_debouncer is
end entity;

architecture Behavorial of tb_debouncer is

  constant clk_period : time := 4 ns;

  signal clk_i : std_logic;
  signal rst_i : std_logic;
  signal button_i : std_logic;
  signal button_o : std_logic;

begin

  -- stability time calcul: clk_i is 250MHz
  -- consider button stable within 10ms
  -- we look for counter width giving counter_max * 1/clk_i = 10ms
  -- so counter_max = 0.01 * clk_i = 2500000
  -- and counter_width = ceil[ln(2500000)/ln2] = 22 bits
  -- SIMULATION
  -- consider button stable within 1000ns
  -- ==> counter_max = 0.000001 * clk_i = 250
  uut:debouncer
    generic map (
      g_stability_counter_max => 250,
      g_stability_counter_width => f_ceil_log2(250)
      )
    port map (
      clk_i => clk_i,
      rst_i => rst_i,
      button_i => button_i,
      button_o => button_o
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
    button_i <= '1';
    wait for 13 ns;
    rst_i <= '1';
    wait for 52 ns;
    rst_i <= '0';
    wait for 237 ns;
    button_i <= '0';
    wait for 124 ns;
    button_i <= '1';
    wait for 55 ns;
    button_i <= '0';
    wait for 202 ns;
    button_i <= '1';
    wait for 2 ns;
    button_i <= '0';
    wait for 129 ns;
    button_i <= '1';
    wait for 179 ns;
    button_i <= '0';

    wait for 3 us;
    button_i <= '1';
    wait for 124 ns;
    button_i <= '0';
    wait for 55 ns;
    button_i <= '1';
    wait for 202 ns;
    button_i <= '0';
    wait for 2 ns;
    button_i <= '1';
    wait for 129 ns;
    button_i <= '0';
    wait for 179 ns;
    button_i <= '1';


    wait;
  end process;

end architecture;
