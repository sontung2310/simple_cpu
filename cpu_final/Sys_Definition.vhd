--This confidential and proprietary software may be used
--only as authorized by a licensing agreement from
--Laboratory for Smart Integrated Systems (SIS), VNU University of Engineering and Technology (VNU-UET).
-- (C) COPYRIGHT 2015
-- ALL RIGHTS RESERVED
-- The entire notice above must be reproduced on all authorized copies.
--
-- Filename : RCA_define.v
-- Author : Hung Nguyen
-- Date : 
-- Version : 0.1
-- Description Package declares all constants, types, 
-- and components for project.               
-- Modification History:
-- Date By Version Change Description
-- ========================================================
-- 05/08.2014  0.1 Original
-- ========================================================
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
use std.textio.all;

package Sys_Definition is

-- Constant for datapath
  Constant   DATA_WIDTH  :     integer   := 16;     -- Word Width
  Constant   ADDR_WIDTH  :     integer   := 16 ;     -- Address width
--constant PORT_NUM : integer := 5;

-- Type Definition
   -- type ADDR_ARRAY_TYPE is array (VC_NUM-1 DOWNTO 0) of std_logic_vector (ADDR_WIDTH-1 downto 0);
   

-- **************************************************************
--COMPONENTs
-- CPU
COMPONENT cpu
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( nReset   : in STD_LOGIC; -- low active reset signal
    	    start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
	       Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	       ALU_out : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	   
     	   -- control signals for accessing to memory
     	   Mre, Mwe : out std_logic
     	    -- add ports as required here
        );
END COMPONENT;
-- Controller
--component controller 
--  Generic (
--    DATA_WIDTH : integer   := 16;     -- Data Width
--    ADDR_WIDTH : integer   := 16      -- Address width
--    );
--   port (nReset   : in STD_LOGIC; -- low active reset signal
--    	    start : in STD_LOGIC;    -- high active Start: enable cpu
--         clk   : in STD_LOGIC;    -- Clock
--         Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
--	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
--	       ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
--         imm   : out std_logic_vector(3 downto 0);
--         -- status signals from ALU
--     	   ALUz  : in std_logic; 
--     	    -- add ports as required here
--     	   -- control signals
--     	   RFs    : out std_logic_vector(1 downto 0);
--     	   Mre, Mwe : out std_logic
--     	   
--     	    -- add ports as required here
--          
--        );
--end component;
-----------------------------
-- Datapath
--component datapath
--   Generic (
--    DATA_WIDTH : integer   := 16;     -- Data Width
--    ADDR_WIDTH : integer   := 16      -- Address width
--    );
--   port ( nReset     : in STD_LOGIC;
--          clk     : in STD_LOGIC;
--	        imm     : in std_logic_vector(7 downto 0);
--	        Data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
--          Data_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
--          -- add ports as required
--        );
--end component;
-------------------------------------
component dpmem 
   generic (
     DATA_WIDTH        :     integer   := 16;     -- Word Width
     ADDR_WIDTH        :     integer   := 16      -- Address width
     );
 
   port (
     -- Writing
     Clk              : in  std_logic;          -- clock
     nReset             : in  std_logic; -- Reset input
     addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);   --  Address
     -- Writing Port
     Wen               : in  std_logic;          -- Write Enable
     Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
     -- Reading Port
     
     Ren               : in  std_logic;          -- Read Enable
     Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
     
     );
  
  end component;


------------------------------------------------------
Component mux4to1 
   Generic ( 
		    DATA_WIDTH : integer := 8);
   PORT (A, B, C, D: IN  	std_logic_vector (DATA_WIDTH-1 downto 0);
        SEL : IN 	 std_logic_vector (1 downto 0);
        Z: OUT 	std_logic_vector (DATA_WIDTH-1 downto 0)
               );
END Component;
component pc
port (
	clk: IN std_logic;
	PCclr: IN std_logic;
	PCinc: IN std_logic;
	PCld: IN std_logic;
	D: IN std_logic_vector  (7 downto 0);
	PCout: OUT std_logic_vector  (15 downto 0)
);
end component;
component IR
port (
	clk: IN std_logic;
	IRld: IN std_logic;
	IRin: IN std_logic_vector (15 downto 0);
	IRout: OUT std_logic_vector (15 downto 0)
);
end component;
component mux3to1_CU
port ( pcout, opr2: in std_logic_vector (15 downto 0);
	irout: in std_logic_vector(7 downto 0);
	ms: in std_logic_vector (1 downto 0);
	ADDR: out std_logic_vector (15 downto 0) 
);
end component;
component controller
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port (-- you will need to add more ports here as design grows
         nReset   : in STD_LOGIC; -- low active reset signal
    	 --start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
	 IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

         -- status signals from ALU
     	 ALUz  : in std_logic; 
	 ALUs: out STD_LOGIC_VECTOR(1 downto 0);
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

        );                              
 
end component;
component mux3to1
GENERIC (
	DATA_WIDTH : integer :=16);
	
	PORT (
	data_in0, data_in2 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	data_in1: in STD_LOGIC_VECTOR (7 downto 0);
	sel : in STD_LOGIC_VECTOR (1 downto 0);
	data_out : out STD_LOGIC_VECTOR  (DATA_WIDTH - 1 downto 0)
	);
end component;
component ALU
	GENERIC (
	DATA_WIDTH : integer :=16);
	
	PORT (
	OPr1 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	OPr2 : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	ALUs : in STD_LOGIC_VECTOR (1 downto 0);
	ALUr : out STD_LOGIC_VECTOR  (DATA_WIDTH - 1 downto 0);
	ALUz : out STD_LOGIC
	);
end component;
component register_file 
	GENERIC (
		DATA_WIDTH : integer :=16;
		ADDR_WIDTH : integer :=16 );
	
	PORT (
	--Input
	reset : in STD_LOGIC;
	clk : in STD_LOGIC;
	RFin : in STD_LOGIC_VECTOR (1 downto 0);
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
end component;
component datapath
Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( -- you will need to add more ports here as design grows
		-- INPUT
          reset     : in STD_LOGIC;
          clk     : in STD_LOGIC;
	      --imm     : in std_logic_vector(7 downto 0);
	      data_in1 : in std_logic_vector(7 downto 0);
		  data_in2 : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		  RFs : in STD_LOGIC_VECTOR (1 downto 0);
		  RFwa, OPr1a, OPr2a : in STD_LOGIC_VECTOR(3 downto 0);
		  RFwe, OPr1e, OPr2e : in STD_LOGIC;
		  ALUs : in STD_LOGIC_VECTOR (1 downto 0);
		-- OUTPUT
		  ALUz : out STD_LOGIC;
          data_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
		  addr_out : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
          -- add ports as required
        );
end component;
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
	
	IR_out: out std_logic_vector (7 downto 0);
	Mre, Mwe: OUT std_logic;
	addr_out: OUT std_logic_vector (15 downto 0)
);
end component;
-----------------
-- You need to add the other components here......
-----------------
end Sys_Definition;

PACKAGE BODY Sys_Definition IS
	-- package body declarations

END PACKAGE BODY Sys_Definition;