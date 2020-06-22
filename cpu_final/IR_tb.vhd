library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.sys_definition.all;

entity IR_tb is
end IR_tb;

architecture arc_IR_tb of IR_tb is
signal IRld: std_logic;
signal IRin: std_logic_vector (15 downto 0);
signal IRout: std_logic_vector (15 downto 0);
signal clk: std_logic:='0';
begin
test: IR
port map(
	clk => clk,
	IRld => IRld,
	IRin => IRin,
	IRout => IRout
);
clock: process
begin
	wait for 5 ns;
	clk <= not clk;
end process clock;

tb: process
begin
	wait for 6 ns; IRld <= '1'; IRin <= "0000000000001111";
	wait for 10 ns; IRld <= '0'; IRin <= "0000000000001111";
	wait for 10 ns; IRld <= '1'; IRin <= "0000000000001011";
	wait;
end process tb;
end arc_IR_tb;
