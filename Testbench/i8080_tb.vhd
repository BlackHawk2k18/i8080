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
signal ControlBus: STD_LOGIC_VECTOR(22 DOWNTO 0);
signal BufferOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal AccumulatorOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromAccumulator: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal LatchOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUToDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToALUFromDA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToALUFromFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUtoFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal AddressBus: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal ToDecoder: STD_LOGIC_VECTOR(7 DOWNTO 0);
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
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT TimingAndControlUnit;
----------------------------------
COMPONENT BufferRegister
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	BufferOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END COMPONENT BufferRegister;
----------------------------------
COMPONENT Accumulator
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	AccumulatorOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END COMPONENT Accumulator;
----------------------------------
COMPONENT AccumulatorLatch
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   FromAccumulator: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	LatchOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
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
	ControlBus: In STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT ALU;
----------------------------------
COMPONENT CommonRegisters
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT CommonRegisters;
----------------------------------
COMPONENT InstructionRegister
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToDecoder: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END COMPONENT InstructionRegister;
----------------------------------
COMPONENT InstructionDecoder
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	FromInstructionRegister: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	DDD: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
	SSS: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END COMPONENT InstructionDecoder;
----------------------------------
COMPONENT RAM
PORT(
	CLK: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromAdressBus: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END COMPONENT RAM;
----------------------------------
BEGIN

	U0: ALU PORT MAP (CLK, RESET, LatchOutput, BufferOutput, InternalDataBus, FromALUtoFlags, ToALUFromFlags, FromALUToDA, ToALUFromDA, F1_command, F2_command, ControlBus(22 downto 20));
	U1: Accumulator PORT MAP (CLK, RESET, InternalDataBus, AccumulatorOutput, ControlBus(0));
	U2: AccumulatorLatch PORT MAP (CLK, RESET, AccumulatorOutput, LatchOutput, ControlBus(1));
	U3: BufferRegister PORT MAP (CLK, RESET, InternalDataBus, BufferOutput, ControlBus(2));
--	U4: FlagFlipFlops PORT MAP (CLK, RESET, InternalDataBus, ToALUFromFlags, FromALUtoFlags, ControlBus(9 downto 8));
--	U5: DecimalAdjust PORT MAP (CLK, RESET, ToALUFromDA, FromALUToDA, ControlBus(11 downto 10));
	U6: InstructionRegister PORT MAP (CLK, RESET, InternalDataBus, ToDecoder, ControlBus(3));
	U7: InstructionDecoder PORT MAP (CLK, RESET, ToDecoder, EnableCommand, DDD, SSS, ControlBus(4));
	U8: TimingAndControlUnit PORT MAP (CLK, RESET, InternalDataBus, EnableCommand, DDD, SSS, F1_command, F2_command, ControlBus);
	U9: CommonRegisters PORT MAP (CLK, RESET, InternalDataBus, AddressBus, ControlBus(19 downto 14));
	U10: RAM PORT MAP (CLK, InternalDataBus, AddressBus, ControlBus(5));
	
	process begin
		InternalDataBus<=(others => 'Z');
		ControlBus<=(others => 'Z');
		EnableCommand<=(others => 'Z');
		DDD<=(others => 'Z');
		SSS<=(others => 'Z');
		
		RESET<='0'; wait for 10 ns;
		RESET<='1'; wait for 10 ns;
		RESET<='0'; wait for 20 ns;
		
		ControlBus(19 downto 14)<="100101"; wait for 20 ns; --Write counter to BUS	
		ControlBus(5 downto 5)<="1";        wait for 20 ns; --Memory WRITE to InternalBus
		ControlBus(3 downto 3)<="0";        wait for 20 ns; --InstReg READ
		ControlBus(3 downto 3)<="1";        wait for 20 ns; --InstReg ToDecoder
		ControlBus(19 downto 14)<="110101"; wait for 20 ns; --Increment counter
--		ControlBus(19 downto 14)<="100101"; wait for 20 ns; --Write counter to BUS
--		ToALUFromFlags<="00000001";
--		
--		InternalDataBus<="00000010";
--		ControlBus(1 downto 0)<="00"; wait for 20 ns;
--		ControlBus(1 downto 0)<="ZZ"; 
--		InternalDataBus<="00111010"; --КОП "Сравнение"
--		ControlBus(16 downto 16)<="0"; wait for 20 ns; 	
--		ControlBus(16 downto 16)<="Z"; wait for 20 ns;
--		InternalDataBus<=(others => 'Z');
		wait;
	end process;
	
	process begin
		CLK<='1'; wait for 10 ns;
		CLK<='0'; wait for 10 ns;
	end process;
END MAIN;