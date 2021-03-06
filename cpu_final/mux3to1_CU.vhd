library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity mux3to1_CU is
port ( pcout, opr2: in std_logic_vector (15 downto 0);
	irout: in std_logic_vector (7 downto 0);
	ms: in std_logic_vector (1 downto 0);
	ADDR: out std_logic_vector (15 downto 0) 
);
end mux3to1_CU;
architecture acr_mux of mux3to1_CU is

begin 
process(ms,pcout,irout,opr2)
begin
	if (ms = "10") then ADDR <= pcout;
	elsif (ms = "01") then  ADDR <= X"00" & irout;
	elsif (ms = "00") then  ADDR <= opr2;
	end if;
end process;

			
end acr_mux;
