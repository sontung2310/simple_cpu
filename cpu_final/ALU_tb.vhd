library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.sys_definition.all;

entity ALU_tb IS
END entity;

ARCHITECTURE ALU_tb of ALU_tb IS

Component ALU
	GENERIC (
	DATA_WIDTH : integer :=16);
	
	PORT (
	OPr1 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	OPr2 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	ALUs : in STD_LOGIC_VECTOR (1 downto 0);
	ALUr : out STD_LOGIC_VECTOR  (DATA_WIDTH - 1 downto 0);
	ALUz : out STD_LOGIC
	);
END Component;

signal OPr1 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
signal OPr2 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
signal ALUs : STD_LOGIC_VECTOR (1 downto 0);
signal ALUr : STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
signal ALUz : STD_LOGIC;

begin
test: ALU
  port map( OPr1 => OPr1,
			OPr2 => OPr2,
			ALUs => ALUs,
			ALUr => ALUr,
			ALUz => ALUz
		);
	
tb: process
begin
	wait for 10ns;
	OPr1 <= "0000000000000001";
	OPr2 <= "0000000000000000";
	ALUs <= "00";
	wait for 30ns;
	OPr1 <= "0000000000000000";
	OPr2 <= "0000000000000001";
	ALUs <= "00";
end process tb;
end ALU_tb;