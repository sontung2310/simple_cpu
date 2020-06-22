library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity pc_tb is
end pc_tb;

architecture arc_pc_tb of pc_tb is

component pc
port (
	clk: IN std_logic;
	PCclr: IN std_logic;
	PCinc: IN std_logic;
	PCld: IN std_logic;
	D: IN std_logic_vector  (7 downto 0);
	PCout: OUT std_logic_vector  (15 downto 0)
);
end component;

signal clk: std_logic :='0';
signal PCclr: std_logic:='0';
signal PCinc: std_logic:='0';
signal PCld: std_logic:='0';
signal D: std_logic_vector (7 downto 0);
signal PCout: std_logic_vector (15 downto 0);

begin
test: pc
port map (clk => clk, 
	PCclr => PCclr, 
	PCinc => PCinc,
	PCld => PCld, 
	D => D, 
	PCout => PCout);
clock: process
begin
	wait for 5 ns;
	clk <= not clk;
end process clock;
tb: process
begin
	wait for 10 ns; PCld <= '1'; PCinc <= '0'; D <= "00000000";
	wait for 20 ns; PCld <= '1'; PCinc <= '1'; 
	wait for 20 ns; PCld <= '1'; PCinc <= '1'; D <= "00000011";
	wait for 10 ns; PCld <= '0'; PCinc <= '1';
	wait for 40 ns; PCclr <= '1'; 
	wait;
end process tb;
end arc_pc_tb;