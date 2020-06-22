	-- Nguyen Kiem Hung
-- cpu : the top level entity

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

-- 
entity cpu is
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
end cpu;


architecture struc of cpu is

-- declare internal signals here
signal OPr1a_s: std_logic_vector (3 downto 0);
signal OPr1e_s: std_logic;
signal OPr2a_s: std_logic_vector (3 downto 0);
signal OPr2e_s:std_logic;

signal RFs_s: std_logic_vector (1 downto 0);
signal RFwa_s: std_logic_vector (3 downto 0);
signal RFwe_s: std_logic;

signal ALUs_s: std_logic_vector (1 downto 0);
signal ALUz_s: std_logic;

signal OP2_s: std_logic_vector (15 downto 0);

signal IR_out_s: std_logic_vector (7 downto 0);
signal data_out_mem_s: std_logic_vector (15 downto 0);
signal ALU_out_s: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

begin
data_out_mem_s <= IR_in;
ALU_out <= ALU_out_s;
-- write your code here
control_u: control_unit
port map(
	clk => clk,
	nReset => nReset,
	
	OP2 => OP2_s,
	data_out_mem => data_out_mem_s,
	
	ALUs =>ALUs_s,
	ALUz => ALUz_s,

	OPr1a => OPr1a_s,
	OPr1e => OPr1e_s,
	OPr2a => OPr2a_s,
	OPr2e => OPr2e_s,
	
	RFs => RFs_s,
	RFwa => RFwa_s,
	RFwe => RFwe_s,
	
	IR_out => IR_out_s,
	Mre => Mre,
 	Mwe => Mwe,
	addr_out => Addr_out
		
);
datapath_u: datapath
port map(
	reset => nReset,
	clk => clk,
	data_in1 => IR_out_s,
	data_in2 => IR_in,
	
	RFs => RFs_s,
	RFwa => RFwa_s,
	RFwe => RFwe_s,

	OPr1a => OPr1a_s,
	OPr1e => OPr1e_s,
	OPr2a => OPr2a_s,
	OPr2e => OPr2e_s,

	ALUs =>ALUs_s,
	ALUz => ALUz_s,
	addr_out => OP2_s,
	data_out => ALU_out_s
);

  --ctrl_U: controller port map(?);
  --Dp_U: datapath port map(?);
  --Mem_U: dpmem port map (?);

							

end struc;




