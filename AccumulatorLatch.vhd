library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY AccumulatorLatch IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   FromAccumulator: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	LatchOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END AccumulatorLatch;
-------------------------------------------------------
ARCHITECTURE MAIN OF AccumulatorLatch IS
signal RegAccLatch: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	RegAccLatch<=(others=>'0') when RESET='1' else
					 FromAccumulator when (ControlBus='0') else 
					 RegAccLatch;
	LatchOutput<=RegAccLatch when (ControlBus='1') else (others=>'Z');	

END MAIN;