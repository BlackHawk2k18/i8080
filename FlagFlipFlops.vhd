library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY FlagFlipFlops IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	ToALUFromFlags: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromALUtoFlags: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(1 DOWNTO 0)
);
END FlagFlipFlops;
-------------------------------------------------------
ARCHITECTURE MAIN OF FlagFlipFlops IS
signal FlipFlopReg: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	FlipFlopReg<="00000010"      when RESET='1'         else
					 InternalDataBus when (ControlBus="00") else
					 FromALUtoFlags  when (ControlBus="10") else FlipFlopReg;
	
	ToALUFromFlags<=FlipFlopReg  when (ControlBus="11") else (others => 'Z');
	
	InternalDataBus<=FlipFlopReg when (ControlBus="01") else (others => 'Z');

END MAIN;
