------ Nguyen Kiem Hung
------ controller
----
library IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity controller is             	
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port (-- you will need to add more ports here as design grows
         nReset   : in STD_LOGIC; -- low active reset signal
    	 --start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
	 IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

         --Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	 
	 --ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
         --imm   : out std_logic_vector(3 downto 0);
         -- status signals from ALU
     	 ALUz  : in std_logic; 
	 ALUs: out STD_LOGIC_VECTOR(1 downto 0);
     	    -- add ports as required here
     	   -- control signals
 	 IRld: out STD_LOGIC;
         PCincr: out STD_LOGIC;
         PCclr: out STD_LOGIC;
         PCld: out STD_LOGIC;

	 OPr1a: out STD_LOGIC_VECTOR(3 downto 0);
         OPr1e: out STD_LOGIC;
         OPr2a: out STD_LOGIC_VECTOR(3 downto 0);
         OPr2e: out STD_LOGIC;

     	 RFs: out std_logic_vector(1 downto 0);
	 RFwa: out std_logic_vector (3 downto 0);
	 RFwe: out std_logic;
     	 Mre, Mwe : out std_logic;
	 Ms: out std_logic_vector (1 downto 0)
     	 --OP2: out std_logic_vector (DATA_WIDTH - 1 downto 0)
     	    -- add ports as required here 
        );                              
 
end controller;

architecture fsm of controller is
-- types and signals are declared here  
type state_type is (RESET_S, FETCH, loadIR, incPC, DECODE, MOV1, MOV1a, MOV2, MOV2a,
                    MOV3, MOV3a, MOV4, MOV4a, ADD, ADDa, SUB, SUBa, AND_S,OR_S, AND_Sa, OR_Sa,
		    JZ, JZa, JMP, NOP);	

-- constants declared for ease of reading code
signal state: state_type;
signal rm: std_logic_vector (3 downto 0);
signal rn: std_logic_vector (3 downto 0);	
signal opcode: std_logic_vector (3 downto 0);	 
begin

rn <= IR_in (11 downto 8);
rm <= IR_in (7 downto 4);
opcode <= IR_in (15 downto 12);
	-- state transition
FSM_trans:process (opcode, nReset, clk)
	begin
	 if (nReset = '1') then 
		state <= RESET_S;
	 elsif (rising_edge(clk)) then
	 	case state is
			when RESET_S => state <= FETCH;
			when FETCH => state <= loadIR;
			when loadIR => state <= incPC;
			when incPC => state <= DECODE;
			when DECODE => 
				case OPCODE is
					when "0000" => state <= MOV1;
					when "0001" => state <= MOV2;
					when "0010" => state <= MOV3;
					when "0011" => state <= MOV4;
					when "0100" => state <= ADD;
					when "0101" => state <= SUB;
					when "0110" => state <= JZ;
					when "0111" => state <= OR_S;
					when "1000" => state <= AND_S;
					when "1001" => state <= JMP;
					when others => state <= NOP;
				end case;
			when MOV1 => state <= MOV1a;
			when MOV1a => state <= FETCH;
			when MOV2 => state <= MOV2a;
			when MOV2a => state <= FETCH;
			when MOV3 => state <= MOV3a;
			when MOV3a => state <= FETCH;
			when MOV4 => state <= FETCH;
			when ADD => state <= ADDa;
			when ADDa => state <= FETCH;
			when SUB => state <= SUBa;
			when SUBa => state <= FETCH;
			when JZ => state <= JZa;
			when JZa => state <= FETCH;
			when JMP => state <= FETCH;
			when OR_S => state <= OR_Sa;
			when OR_Sa => state <= FETCH;
			when AND_S => state <= AND_Sa;
			when AND_Sa => state <= FETCH;

			when others => state <= FETCH;
		end case;
	end if;
	end process;
  -- write codes to generate control signals 	
--PC: process (state)
--begin
--	if state = RESET_S then
--		PCclr <= '1'; 
--	else PCclr <= '0';
--	end if;
--	if state = incPC then
--		PCincr <= '1';
--	else PCincr <= '0';
--	end if;
--	if state = JZa then
--		PCld <= ALUz;
--	else  PCld <= '0';
--	end if;
--end process;
PCclr <= '1' when (state = RESET_S) else '0';
PCincr <= '1' when (state =incPC) else '0';
--PCld <= ALUz When (state = JZa) else '0';
with state select PCld <= ALUz when JZa,
			  '1' when JMP,
			  '0' when others;
----
IRld <= '1' when (state = loadIR) else '0';

--Add_sel

with state select Ms <= "10" when FETCH,
				"01" when MOV1|MOV2a,
				"00"when MOV3a,
				"11"when others;
with state select Mre <= '1' when FETCH|MOV1|MOV1a,
			'0' when others;
with state select Mwe <= '1' when MOV2a|MOV3a,
			'0' when others;


--RF

with state select  RFs <= "10" when MOV1a,
    			"01" when MOV4,
    			"00" when ADDa|SUBa|OR_Sa|AND_Sa,
    			"11" when others;
with state select RFwe <= '1' when MOV1a|MOV4|ADDa|SUBa|OR_Sa|AND_Sa,
			'0' when others;
with state select RFwa <= rn when MOV1a|MOV4|ADDa|SUBa|OR_Sa|AND_Sa,
  			"0000" when others;
with state select OPr1e <= '1' when MOV2|MOV3|ADD|SUB|JZ|AND_S|OR_S,
			'0' when others;
with state select OPr1a <= rn when MOV2|MOV3|ADD|SUB|JZ|AND_S|OR_S,
			"0000" when others;
with state select OPr2e <= '1' when MOV3|ADD|SUB|AND_S|OR_S,
			'0' when others;
with state select OPr2a <= rm when MOV3|ADD|SUB|AND_S|OR_S,
			"0000" when others;
with state select ALUs <="00" when ADD|ADDa,
			"01" when SUB|SUBa,
			"10" when OR_S,
			"11" when others;





end fsm;
----
----
----
----
----
----
----
----
----
----









