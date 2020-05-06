


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package general_pkg is

  function f_ceil_log2(x   : natural) return natural;

end package;

package body general_pkg is
  
  function f_ceil_log2(x : natural) return natural is
  begin
    if x <= 1
    then return 0;
    else return f_ceil_log2((x+1)/2) +1;
    end if;
  end f_ceil_log2;
  
end general_pkg;
