-------------------------------------------------------------------------------
-- Dr. Kaputa
-- negation led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity negation is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    val_in          : in  std_logic_vector(31 downto 0);
    val_out         : out std_logic_vector(31 downto 0)
  );  
end negation;  

architecture beh of negation  is

begin
process(clk,reset)
  begin
    if (reset = '1') then 
      val_out <= (others => '0');
    elsif (clk'event and clk = '1') then
      val_out <= not val_in;
    end if;
  end process;
  end beh;