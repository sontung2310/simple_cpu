library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Sys_Definition.all;

entity mux3to1 IS
GENERIC (
	DATA_WIDTH : integer :=16);
	
	PORT (
	data_in0, data_in2 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	data_in1: in STD_LOGIC_VECTOR (7 downto 0);
	sel : in STD_LOGIC_VECTOR (1 downto 0);
	data_out : out STD_LOGIC_VECTOR  (DATA_WIDTH - 1 downto 0)
	);
	
END mux3to1;

ARCHITECTURE mux3to1 of mux3to1 IS
signal temp: std_logic_vector (15 downto 0);
begin
	temp <= X"00" & data_in1;
	with sel select
	data_out <= data_in0 when "00",
				temp when "01",
				data_in2 when others;
end mux3to1;
	