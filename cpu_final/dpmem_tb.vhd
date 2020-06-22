library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.sys_definition.all;
 
use std.textio.all;
 
entity dpmem_tb is

end dpmem_tb;

 
 
architecture behavior of dpmem_tb is

  Constant   CLKTIME   :       time      := 20 ns;
  
   
  
   
    
   
  signal clk :       std_logic := '0';
  signal nReset :      std_logic := '0';
  
  signal addr : std_logic_vector( ADDR_WIDTH-1 downto 0);
  signal  wen  :       std_logic;
  signal  datain :  std_logic_vector(DATA_WIDTH -1 downto 0);
  
  signal  ren :       std_logic;
 
  signal dataout :   std_logic_vector(DATA_WIDTH -1 downto 0);
 

   
   
   
begin
   

   
-- Clock generation
  
  clk <= not clk after CLKTIME/2;
   
-- UUT componenet
  dut:  dpmem
    generic map
    (
      DATA_WIDTH     => 16,
      ADDR_WIDTH => 16
      )
     
    port map (
       
      clk      => clk,
      nReset   => nReset,
      addr     => addr,
      Wen       => wen,
      Datain    => datain,
      
      Ren       => ren,
      
      Dataout   => dataout
      
      );
   
 
-- Read process

  stimuli_proc :  process
  Begin
      -- Reset generation
  
        nReset  <= '1'; REn <= '0'; WEn <= '0'; Addr <= (OTHERS => '0');
        wait for  50 ns;                                         
        nReset  <= '0';
        wait for  100 ns;
        
        Ren <= '1'; -- read enable at address 0
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        Addr <= X"0001";  Ren <= '1'; -- read enable at address 1
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        
        Addr <= X"0000";  Datain <= X"000E"; Wen <= '1'; -- write enable at address 0
        wait for  20 ns;  Wen <= '0';  wait for  10 ns;
        Addr <= X"0001";  Datain <= X"000F"; Wen <= '1'; -- write enable at address 1
        wait for  20 ns;  Wen <= '0';  wait for  10 ns;
        
        Addr <= X"0000"; Ren <= '1'; -- read enable at address 0
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        Addr <= X"0001";  Ren <= '1'; -- read enable at address 1
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;  
        Addr <= X"0002"; Ren <= '1'; -- read enable at address 2
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        Addr <= X"0003";  Ren <= '1'; -- read enable at address 3
        wait for  20 ns;  Ren <= '0';  wait for  10 ns; 
  end process stimuli_proc;
   
 

end behavior;