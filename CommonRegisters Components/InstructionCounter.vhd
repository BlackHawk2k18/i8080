library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY InstructionCounter IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END InstructionCounter;
-------------------------------------------------------
ARCHITECTURE MAIN OF InstructionCounter IS
signal InstrCounterReg: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	
	InstrCounterReg<=InstrCounterReg+1 when (ControlBus="110" and Selector='1') else InstrCounterReg;
	
	ToAdressBus<=InstrCounterReg when (ControlBus="111" and Selector='1') else (others =>'Z');
	
END MAIN;