library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY InstructionRegister IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToDecoder: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END InstructionRegister;
-------------------------------------------------------
ARCHITECTURE MAIN OF InstructionRegister IS
signal InstrReg: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	InstrReg<=(others => '0') when RESET='1' else
				 InternalDataBus when (ControlBus='0') else InstrReg;
	ToDecoder<=InstrReg when (ControlBus='1') else (others =>'Z');

END MAIN;