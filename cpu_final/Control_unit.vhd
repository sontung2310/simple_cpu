library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.sys_definition.all;

entity Control_unit is
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
	
	IR_out: out std_logic_vector (7 downto 0);
	Mre, Mwe: OUT std_logic;
	addr_out: OUT std_logic_vector (15 downto 0)
);
end Control_unit;
architecture arc_cu of Control_unit is
signal clk_s: std_logic;
signal IRld_s: std_logic;
signal IRin_s: std_logic_vector (15 downto 0);
signal IRout_s: std_logic_vector (15 downto 0);
signal PCclr_s: std_logic;
signal PCinc_s: std_logic;
signal PCld_s: std_logic;
signal PCout_s: std_logic_vector  (15 downto 0);
signal ms_s: std_logic_vector (1 downto 0);
signal OPr1a_s: STD_LOGIC_VECTOR(3 downto 0);
signal OPr1e_s: STD_LOGIC;
signal OPr2a_s: STD_LOGIC_VECTOR(3 downto 0);
signal OPr2e_s: STD_LOGIC;
signal Mre_s: std_logic;
signal Mwe_s: std_logic;
signal addr_out_s: std_logic_vector (15 downto 0);
begin

IR_out <= IRout_s (7 downto 0);

connect_IR: IR
port map(
	clk => clk,
	IRld => IRld_s,
	IRin => data_out_mem,
	IRout => IRout_s
);
connect_pc: pc
port map(
	clk => clk,
	PCclr => PCclr_s,
	PCinc => PCinc_s,
	PCld => PCld_s,    
	D => IRout_s (7 downto 0),
	PCout => PCout_s
);
connect_mux: mux3to1_CU
port map(
	pcout => PCout_s,
	irout => IRout_s( 7 downto 0),
	opr2 => OP2,
	ms => ms_s,
	ADDR => addr_out
);
connect_controller: controller
port map(
	nReset => nReset,
	clk => clk,
	IR_in => IRout_s,
	
	ALUz => ALUz,
	ALUs => ALUs,
	
	IRld => IRld_s,
	PCincr => PCinc_s,
	PCclr => PCclr_s,
	PCld => PCld_s,

	OPr1a => OPr1a,
	OPr1e => OPr1e,
	OPr2a => OPr2a,
	OPr2e => OPr2e,
	
	RFs => RFs,
	RFwa => RFwa,
	RFwe => RFwe,
	Mre => Mre,
	Mwe => Mwe,
	Ms => ms_s
);


-- add ports as required here 
end arc_cu;
