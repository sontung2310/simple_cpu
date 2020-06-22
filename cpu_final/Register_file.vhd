library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Sys_Definition.all;

ENTITY register_file IS
	GENERIC (
		DATA_WIDTH : integer :=16;
		ADDR_WIDTH : integer :=16 );
	
	PORT (
	--Input
	reset : in STD_LOGIC;
	clk : in STD_LOGIC;
	RFin : in STD_LOGIC_VECTOR (DATA_WIDTH -1 downto 0);
	RFwa : in STD_LOGIC_VECTOR (3 downto 0);
	RFwe : in STD_LOGIC;
	OPr1a : in STD_LOGIC_VECTOR (3 downto 0);
	OPr1e : in STD_LOGIC;
	OPr2a : in STD_LOGIC_VECTOR (3 downto 0);
	OPr2e : in STD_LOGIC;
	--Output
	OPr1 : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	OPr2 : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
	);
END register_file;

ARCHITECTURE register_file of register_file IS
	--Doan nay chua hieu lammm
	type DATA_ARRAY is array (integer range<>) of STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	signal RF : DATA_ARRAY(0 to 15):=(others => (others => '0'));
	--La sao ta
begin
	RW_Proces: process(clk,reset)
	begin
		if reset = '1' then 
			OPr1 <= (others => '0');
			OPr2 <= (others => '0');
			RF <= (others => (others => '0'));
		
		elsif clk'event and clk = '1' then
			if OPr1e = '1' then
				OPr1 <= RF(conv_integer(OPr1a));
			end if;
			if OPr2e = '1' then
				OPr2 <= RF(conv_integer(OPr2a));
			end if;
			if RFwe = '1' then
				RF(conv_integer(RFwa)) <= RFin;
			end if;
		end if;
	end process RW_Proces;
END register_file;
	