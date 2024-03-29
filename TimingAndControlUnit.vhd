library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY TimingAndControlUnit IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END TimingAndControlUnit;
-------------------------------------------------------
ARCHITECTURE MAIN OF TimingAndControlUnit IS
-------------------------------------------------------
signal Counter: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal CommandReset: STD_LOGIC;
-------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--COMPONENT NOP
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT NOP;
---------------------------------------------------------
--COMPONENT DAD
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT DAD;
---------------------------------------------------------
--COMPONENT LXI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT LXI;
---------------------------------------------------------
--COMPONENT STAX
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT STAX;
---------------------------------------------------------
--COMPONENT LDAX
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT LDAX;
---------------------------------------------------------
--COMPONENT SHLD
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT SHLD;
---------------------------------------------------------
--COMPONENT LHLD
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT LHLD;
---------------------------------------------------------
--COMPONENT STA
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT STA;
---------------------------------------------------------
COMPONENT LDA
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT LDA;
---------------------------------------------------------
--COMPONENT DCX
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT DCX;
---------------------------------------------------------
--COMPONENT INX
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT INX;
---------------------------------------------------------
--COMPONENT INR
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT INR;
---------------------------------------------------------
--COMPONENT DCR
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT DCR;
---------------------------------------------------------
--COMPONENT MVI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT MVI;
---------------------------------------------------------
--COMPONENT RLC
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RLC;
---------------------------------------------------------
--COMPONENT RRC
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RRC;
---------------------------------------------------------
--COMPONENT RAL
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RAL;
---------------------------------------------------------
--COMPONENT RAR
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RAR;
---------------------------------------------------------
--COMPONENT DAA
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT DAA;
---------------------------------------------------------
--COMPONENT CMA
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT CMA;
---------------------------------------------------------
--COMPONENT STC
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT STC;
---------------------------------------------------------
--COMPONENT CMC
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT CMC;
----------------------------------------------------------------------------------------------------------------
--COMPONENT MOV
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT MOV;
---------------------------------------------------------
--COMPONENT HLT
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT HLT;
----------------------------------------------------------------------------------------------------------------
COMPONENT ADD
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT ADD;
---------------------------------------------------------
COMPONENT ADC
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT ADC;
---------------------------------------------------------
COMPONENT SUB
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT SUB;
---------------------------------------------------------
COMPONENT SBB
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT SBB;
---------------------------------------------------------
COMPONENT ANA
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT ANA;
---------------------------------------------------------
--COMPONENT XRA
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
--	Memory_RW: OUT STD_LOGIC
--);
--END COMPONENT XRA;
---------------------------------------------------------
COMPONENT ORA
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT ORA;
---------------------------------------------------------
COMPONENT CMP
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT CMP;
----------------------------------------------------------------------------------------------------------------
--COMPONENT RETIF
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RETIF;
---------------------------------------------------------
--COMPONENT POP
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT POP;
---------------------------------------------------------
--COMPONENT JPM_IF
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT JPM_IF;
---------------------------------------------------------
--COMPONENT CALLIF
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT CALLIF;
---------------------------------------------------------
--COMPONENT PUSH
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT PUSH;
---------------------------------------------------------
--COMPONENT RST
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RST;
---------------------------------------------------------
--COMPONENT RET
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT RET;
---------------------------------------------------------
--COMPONENT PCHL
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT PCHL;
---------------------------------------------------------
--COMPONENT SPHL
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT SPHL;
---------------------------------------------------------
--COMPONENT JMP
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT JMP;
---------------------------------------------------------
--COMPONENT PortOUT
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT PortOUT;
---------------------------------------------------------
--COMPONENT PortIN
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT PortIN;
---------------------------------------------------------
--COMPONENT XTHL
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT XTHL;
---------------------------------------------------------
--COMPONENT XCHG
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT XCHG;
---------------------------------------------------------
--COMPONENT DI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT DI;
---------------------------------------------------------
--COMPONENT EI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT EI;
---------------------------------------------------------
--COMPONENT CALL
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT CALL;
---------------------------------------------------------
--COMPONENT ADI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT ADI;
---------------------------------------------------------
--COMPONENT ACI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT ACI;
---------------------------------------------------------
--COMPONENT SUI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT SUI;
---------------------------------------------------------
--COMPONENT SBI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT SBI;
---------------------------------------------------------
--COMPONENT ANI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT ANI;
---------------------------------------------------------
--COMPONENT XRI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT XRI;
---------------------------------------------------------
--COMPONENT ORI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT ORI;
---------------------------------------------------------
--COMPONENT CPI
--PORT(
--	CLK: IN STD_LOGIC;
--	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--	CommandReset: OUT STD_LOGIC;
--	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--	F2_command: OUT STD_LOGIC;
--	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
--);
--END COMPONENT CPI;
----------------------------------------------------------------------------------------------------------------
BEGIN
---------------------------------------------------------00 GROUP-------------------------------------------------------
--	U0: NOP  PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U1: DAD  PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U2: LXI  PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U3: STAX PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U4: LDAX PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U5: SHLD PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U6: LHLD PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U7: STA  PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
	U8: LDA  PORT MAP (CLK, EnableCommand, CommandReset, ControlBus);
--	U9: DCX  PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U10: INX PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);	
--	U11: INR PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U12: DCR PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U13: MVI PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U14: RLC PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U15: RRC PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);	
--	U16: RAL PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U17: RAR PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U18: DAA PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U19: CMA PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U20: STC PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U21: CMC PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
---------------------------------------------------------00 GROUP-------------------------------------------------------

---------------------------------------------------------01 GROUP-------------------------------------------------------
--	U22: MOV PORT MAP (CLK, EnableCommand, CommandReset, DDD, SSS, Buff_ControlBus);
--	U23: HLT PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
---------------------------------------------------------01 GROUP-------------------------------------------------------	

-------------------------------------------------------10 GROUP-------------------------------------------------------
	U24: ADD PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U25: ADC PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U26: SUB PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U27: SBB PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U28: ANA PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
--	U29: XRA PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U30: ORA PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U31: CMP PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
---------------------------------------------------------10 GROUP-------------------------------------------------------	

---------------------------------------------------------11 GROUP-------------------------------------------------------	
--	U32: RETIF   PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U33: POP     PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U34: RET     PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U35: PCHL    PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U36: SPHL    PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U37: JPM_IF  PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U38: JMP     PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U39: PortOUT PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U40: PortIN  PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U41: XTHL    PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U42: XCHG    PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U43: DI      PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U44: EI      PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U45: CALLIF  PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U46: PUSH    PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
--	U47: CALL    PORT MAP (CLK, EnableCommand, CommandReset, Buff_ControlBus);
--	U48: ADI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U49: ACI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U50: SUI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U51: SBI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U52: ANI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U53: XRI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U54: ORI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U55: CPI     PORT MAP (CLK, EnableCommand, CommandReset, SSS, Buff_F1, Buff_F2, Buff_ControlBus);
--	U56: RST     PORT MAP (CLK, EnableCommand, CommandReset, DDD, Buff_ControlBus);
-------------------------------------------------------11 GROUP-------------------------------------------------------
	
	Counter<=(others => '0') when RESET='1' else
				(others => '0') when CommandReset='0' and CommandReset'last_value='1' else
				Counter+1 when (rising_edge(CLK)) else Counter;

	ControlBus(19 downto 14)<="100101" when (Counter="00000010") else "ZZZZZZ"; --Write counter to BUS
	
	ControlBus(5 downto 5)<="1" when (Counter="00000010") else "Z";             --Memory WRITE to InternalBus
	
	ControlBus(3 downto 3)<="Z" when (Counter<"00000010") else
									"0" when (Counter="00000010") else  "1" ;           --InstReg ToDecoder

END MAIN;


--	Counter<=(others => '0') when RESET='1' else
--				(others => '0') when (CommandReset'EVENT and CommandReset='Z') else
--				Counter+1 when (rising_edge(CLK)) else Counter;