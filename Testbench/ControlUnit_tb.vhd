library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Testbench IS
END;
-------------------------------------------------------
ARCHITECTURE MAIN OF Testbench IS
signal CLK: STD_LOGIC;
signal RESET: STD_LOGIC;
signal InternalDataBus: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal EnableCommand: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DDD: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal SSS: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal F1_command: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal F2_command: STD_LOGIC;
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);
signal BufferOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal AccumulatorOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromAccumulator: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal LatchOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUToDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToALUFromDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToALUFromFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUtoFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToAdressBus: STD_LOGIC_VECTOR (15 DOWNTO 0);
----------------------------------
COMPONENT TimingAndControlUnit
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT TimingAndControlUnit;
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
COMPONENT CommonRegisters
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT CommonRegisters;
----------------------------------
BEGIN

	U0: TimingAndControlUnit PORT MAP (CLK, RESET, InternalDataBus, EnableCommand, DDD, SSS, F1_command, F2_command, ControlBus);
	U1: BufferRegister PORT MAP (CLK, RESET, InternalDataBus, BufferOutput, ControlBus);	
	U2: Accumulator PORT MAP (CLK, RESET, InternalDataBus, AccumulatorOutput, ControlBus);
	U3: AccumulatorLatch PORT MAP (CLK, RESET, AccumulatorOutput, LatchOutput, ControlBus);
	U4: ALU PORT MAP (CLK, RESET, LatchOutput, BufferOutput, InternalDataBus, FromALUtoFlags, ToALUFromFlags, FromALUToDA, ToALUFromDA, F1_command, F2_command, ControlBus);
	U5: CommonRegisters PORT MAP (CLK, RESET, InternalDataBus, ToAdressBus, ControlBus);
	process begin
		InternalDataBus<="ZZZZZZZZ";
		DDD<="000";
		SSS<="000";
		ControlBus<=(others => 'Z');
		EnableCommand<="ZZZZZZZZ";
		RESET<='0'; wait for 10 ns;
		RESET<='1'; wait for 10 ns;
		RESET<='0'; wait for 20 ns;
		
		InternalDataBus<="00000010";
		ControlBus(1 downto 0)<="00"; wait for 20 ns;
		ControlBus(1 downto 0)<="ZZ";
		InternalDataBus<="ZZZZZZZZ";
		EnableCommand<="10000000"; --КОП Сложение
		wait;
	end process;
	
	process begin
		CLK<='1'; wait for 10 ns;
		CLK<='0'; wait for 10 ns;
	end process;
END MAIN;