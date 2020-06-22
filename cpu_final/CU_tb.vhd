library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity CU_tb is
end CU_tb;

architecture arc_CU_tb of CU_tb is
component Control_unit
port (clk: IN std_logic;
	nReset: IN std_logic;
	ALUz: IN std_logic;
	OP2: IN std_logic_vector (15 downto 0);
	data_out_mem: IN std_logic_vector (15 downto 0);

	ALUs: OUT std_logic_vector (1 downto 0);
		
	OPr1a: out STD_LOGIC_VECTOR(3 downto 0);
        OPr1e: out STD_LOGIC;
        OPr2a: out STD_LOGIC_VECTOR(3 downto 0);
        OPr2e: out STD_LOGIC;

     	RFs: out std_logic_vector(1 downto 0);
	RFwa: out std_logic_vector (3 downto 0);
	RFwe: out std_logic;
	
	IR_out:  out std_logic_vector (7 downto 0);
	Mre, Mwe: OUT std_logic;
	addr_out: OUT std_logic_vector (15 downto 0)
);
end component;

signal clk: std_logic:='0';
signal nReset: std_logic :='0';
signal ALUz: std_logic :='0';
signal OP2: std_logic_vector (15 downto 0);
signal data_out_mem: std_logic_vector (15 downto 0);
signal ALUs: std_logic_vector (1 downto 0);
signal OPr1a: STD_LOGIC_VECTOR(3 downto 0);
signal OPr1e: std_logic :='0';
signal OPr2a: STD_LOGIC_VECTOR(3 downto 0);
signal Opr2e: std_logic :='0';
signal RFs: std_logic_vector(1 downto 0);
signal RFwa: STD_LOGIC_VECTOR(3 downto 0);
signal RFwe: std_logic :='0';
signal Mre, Mwe: std_logic :='0';
signal addr_out: std_logic_vector (15 downto 0);
signal IR_out: std_logic_vector (7 downto 0);
begin
test: Control_unit
port map (
	clk => clk,
	nReset => nReset,
	ALUz => ALUz,
	OP2 => OP2,
	data_out_mem => data_out_mem,
	ALUs => ALUs,
	OPr1a => OPr1a,
	OPr1e => OPr1e,
	OPr2a => OPr2a,
	Opr2e => Opr2e,
	RFs => RFs,
	RFwa => RFwa,
	RFwe => RFwe,
	Mre => Mre,
	Mwe => Mwe,
	addr_out => addr_out,
	IR_out => IR_out
);
clock: process
begin
	wait for 5 ns;
	clk <= not clk;
end process clock;

tb: process
begin
	wait for 5 ns; nReset <= '1'; OP2 <= "0000000000000001"; ALUz <='0'; data_out_mem <= "0000000000000111";
	wait for 20 ns; nReset <= '1';OP2 <= "0000000000000111"; ALUz <='1'; data_out_mem <= "0111000000001111";
	wait for 20 ns; nReset <= '1';OP2 <= "0001000000000111"; ALUz <='1'; data_out_mem <= "0010000000001111";
	wait for 20 ns; nReset <= '0';OP2 <= "0001111111111111"; ALUz <='1'; data_out_mem <= "0010000000001111";
	
	wait;
end process;

end arc_CU_tb;
