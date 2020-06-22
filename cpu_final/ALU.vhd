library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Sys_Definition.all;

ENTITY ALU IS
	GENERIC (
	DATA_WIDTH : integer :=16);
	
	PORT (
	OPr1 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	OPr2 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	ALUs : in STD_LOGIC_VECTOR (1 downto 0);
	ALUr : out STD_LOGIC_VECTOR  (DATA_WIDTH - 1 downto 0);
	ALUz : out STD_LOGIC
	);
	
END ALU;

ARCHITECTURE ALC of ALU IS
signal result: STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);

BEGIN
	process (ALUs, OPr1, OPr2)
	begin
		if (ALUs = "00") then -- ADD
			result <= OPr1 + OPr2;
		elsif (ALUs = "01") then --SUB
			result <= OPr1 - OPr2;
		elsif (ALUs = "10") then --OR
			result <= OPr1 OR OPr2;
		elsif (ALUs = "11") then --AND
			result <= OPr1 AND OPr2;
		else
			result <= (others => '1');
		end if;
	end process;
	
	ALUr <= result;
	ALUz <= '1' when OPr1 = x"0000" else '0';
END ALC;

			

