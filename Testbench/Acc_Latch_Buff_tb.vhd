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
signal BufferOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal AccumulatorOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromAccumulator: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal LatchOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);

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
BEGIN

	U0: BufferRegister PORT MAP (CLK, RESET, InternalDataBus, BufferOutput, ControlBus);	
	U1: Accumulator PORT MAP (CLK, RESET, InternalDataBus, AccumulatorOutput, ControlBus);
	U2: AccumulatorLatch PORT MAP (CLK, RESET, AccumulatorOutput, LatchOutput, ControlBus);
	
	process begin
	InternalDataBus<="10000000";
	ControlBus<="ZZZZZZZZZZZZZZZZZZ";
	
	RESET<='0'; wait for 10 ns;
	RESET<='1'; wait for 10 ns;
	RESET<='0'; wait for 20 ns;
	
	ControlBus<="ZZZZZZZZZZZZZZZZ00"; wait for 20 ns; --ШД в РА
	InternalDataBus<="00000001";
	ControlBus<="ZZZZZZZZZZZZZZ00ZZ"; wait for 20 ns; --ШД в БР
	ControlBus<="ZZZZZZZZZZZZZZZZ10"; wait for 20 ns; --РА в РЗА
	ControlBus<="ZZZZZZZZZZZZZZZZ11"; wait for 20 ns; --РЗА и БР в АЛУ
	ControlBus<="ZZZZZZZZZZZZZZZZZZ";
	wait;
	end process;
	
	process begin
	CLK<='1'; wait for 10 ns;
	CLK<='0'; wait for 10 ns;
	end process;
	
END MAIN;