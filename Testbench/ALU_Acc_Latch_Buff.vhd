library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Testbench IS
END;
-------------------------------------------------------
ARCHITECTURE MAIN OF Testbench IS
----------------------------------
signal CLK: STD_LOGIC;
signal RESET: STD_LOGIC;
signal InternalDataBus: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal AccumulatorOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);
signal LatchOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal BufferOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToALUFromFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUtoFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToDecoder: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromInstructionRegister: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToControlUnit: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal F1_command: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal F2_command: STD_LOGIC;
signal ToALUFromFlagsFromDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUToDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToALUFromDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToAdressBus: STD_LOGIC_VECTOR(15 DOWNTO 0);
----------------------------------
COMPONENT ALU
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
   ToFlags: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromFlags: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToDecimalAdjust: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromDecimalAdjust: IN STD_LOGIC_VECTOR(7 DOWNTO 0);		
	F1_command: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: IN STD_LOGIC;
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT ALU;
----------------------------------
COMPONENT Accumulator
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	AccumulatorOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT Accumulator;
----------------------------------
COMPONENT AccumulatorLatch
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   FromAccumulator: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	LatchOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT AccumulatorLatch;
----------------------------------
COMPONENT BufferRegister
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	BufferOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT BufferRegister;
----------------------------------
BEGIN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	U0: ALU PORT MAP (CLK, RESET, LatchOutput, BufferOutput, InternalDataBus, FromALUtoFlags, ToALUFromFlags, FromALUToDA, ToALUFromDA, F1_command, F2_command, ControlBus);
	U1: Accumulator PORT MAP (CLK, RESET, InternalDataBus, AccumulatorOutput, ControlBus);
	U2: AccumulatorLatch PORT MAP (CLK, RESET, AccumulatorOutput, LatchOutput, ControlBus);
	U3: BufferRegister PORT MAP (CLK, RESET, InternalDataBus, BufferOutput, ControlBus);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	process begin
		ControlBus<="ZZZZZZZZZZZZZZZZZZ";
		InternalDataBus<="ZZZZZZZZ";
		F2_command<='Z';
		F1_command<="ZZZZZZZZ";
		
		RESET<='0'; wait for 10 ns;
		RESET<='1'; wait for 10 ns;
		RESET<='0'; wait for 20 ns;
		
		InternalDataBus<="00000010";
		ControlBus<="0---------------00"; wait for 20 ns; --ШД в РА
		InternalDataBus<="11111110";
		ControlBus<="0-------------00--"; wait for 20 ns; --РА в РЗА и ШД в БР
		InternalDataBus<="ZZZZZZZZ";
		F2_command<='1';
		F1_command<="00000001";
		ControlBus<="1-------------1100"; wait for 60 ns; --РЗА и БР в АЛУ, ШД в РА
		F2_command<='Z';
		F1_command<="ZZZZZZZZ";
		ControlBus<="------------------"; 
	wait;
	end process;
	
	process begin
		CLK<='1'; wait for 10 ns;
		CLK<='0'; wait for 10 ns;
	end process;
END MAIN;