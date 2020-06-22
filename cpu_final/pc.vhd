library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity pc is

port (
	clk: IN std_logic;
	PCclr: IN std_logic;
	PCinc: IN std_logic;
	PCld: IN std_logic;
	D: IN std_logic_vector  (7 downto 0);
	PCout: OUT std_logic_vector  (15 downto 0)
	
);
end pc;
architecture arc_pc of pc is 

signal reg : std_logic_vector (7 downto 0);
signal temp: std_logic_vector  (15 downto 0);
begin
process(clk)
begin
	if (PCclr = '1') then
		reg <= "00000000";
	elsif (rising_edge(clk)) then
		if (PCld = '1') then
			reg <= D;
		elsif PCinc = '1' then
			reg <= reg + "00000001";
		end if;
	end if;
end process;
temp <= X"00" & reg;
PCout <= temp;
end arc_pc;