library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY StackPointer IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END StackPointer;
-------------------------------------------------------
ARCHITECTURE MAIN OF StackPointer IS
signal Stack_L, Stack_H: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
				
	Stack_L<=(others=>'0') when RESET='1' else
		InternalDataBus when (ControlBus="000100") else Stack_L;
	Stack_H<=(others=>'0') when RESET='1' else
		InternalDataBus when (ControlBus="010100") else Stack_H;
	
	ToAddressBus(15 downto 8)<=Stack_H when (ControlBus="100100") else (others =>'Z');
	ToAddressBus(7 downto 0)<=Stack_L when (ControlBus="100100") else (others =>'Z');
	
	InternalDataBus<=Stack_L when (ControlBus="001100") else 
						  Stack_H when (ControlBus="011100") else (others =>'Z');

END MAIN;