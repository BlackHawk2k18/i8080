library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Accumulator IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	AccumulatorOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END Accumulator;
-------------------------------------------------------
ARCHITECTURE MAIN OF Accumulator IS
signal RegAcc: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	RegAcc<=(others=>'0') when RESET='1' else
			  InternalDataBus when (ControlBus='0') else
			  RegAcc;
	InternalDataBus<=RegAcc when (ControlBus='1') else (others=>'Z');
				

	
	AccumulatorOutput<=RegAcc;	
	
END MAIN;