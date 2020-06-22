
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.sys_definition.all;
 
use std.textio.all;
 
entity cpu_tb is

end cpu_tb;

 
 
architecture behavior of cpu_tb is
component cpu
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( nReset   : in STD_LOGIC; -- low active reset signal
    	  --start : in STD_LOGIC;    -- high active Start: enable cpu
          clk   : in STD_LOGIC;    -- Clock
	       Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	       ALU_out : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	   
     	   -- control signals for accessing to memory
     	   Mre, Mwe : out std_logic
     	    -- add ports as required here
        );
end component;
Constant   CLKTIME   :       time      := 10 ns;
signal nReset: STD_LOGIC:='0';
signal clk: STD_LOGIC:='0';
signal Addr_out_s: STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
signal IR_in_s: STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
signal ALU_out_s: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal Mre_s: STD_LOGIC;
signal Mwe_s: STD_LOGIC;
Begin
Clk <= not clk after CLKTIME/2;  
test: cpu
port map (clk => clk,
	nReset => nReset,
	Addr_out => Addr_out_s,
	IR_in => IR_in_s,
	ALU_out => ALU_out_s,
	Mre => Mre_s,
	Mwe => Mwe_s
);
mem: dpmem
port map(
	clk => clk,
	nReset => nReset,
	addr => Addr_out_s,
	Wen => Mwe_s,
	Datain => AlU_out_s,
	Ren => Mre_s,
	Dataout => IR_in_s
);
  -- write your code here
--clock: process
--begin
--	wait for 5 ns;
--	clk <= not clk;
--end process clock;
-- 

  stimuli_proc :  process
  Begin
      -- Reset generation
  
        nReset  <= '1'; 
        wait for  10 ns;                                        
        nReset  <= '0';
        wait ;
        
        
  end process stimuli_proc;
End behavior;