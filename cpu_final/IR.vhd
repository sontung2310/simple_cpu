library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity IR is
port (
	clk: IN std_logic;
	IRld: IN std_logic;
	IRin: IN std_logic_vector (15 downto 0);
	IRout: OUT std_logic_vector (15 downto 0)
);
end IR;
architecture arc_IR of IR is
begin
process (clk)
begin
	if (rising_edge(clk)) then
		if IRld = '1' then IRout <= IRin; 
		end if;
	end if;
end process; 
end arc_IR;
