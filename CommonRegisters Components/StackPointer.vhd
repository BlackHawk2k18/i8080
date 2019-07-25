library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY StackPointer IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END StackPointer;
-------------------------------------------------------
ARCHITECTURE MAIN OF StackPointer IS
signal Stack_L, Stack_H: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
				
	Stack_L<=InternalDataBus when (ControlBus="000" and Selector='1') else Stack_L;
	Stack_H<=InternalDataBus when (ControlBus="010" and Selector='1') else Stack_H;
	
	ToAdressBus(15 downto 8)<=Stack_H when (ControlBus="100" and Selector='1') else (others =>'Z');
	ToAdressBus(7 downto 0)<=Stack_L when (ControlBus="100" and Selector='1') else (others =>'Z');
	
	InternalDataBus<=Stack_L when (ControlBus="001" and Selector='1') else 
						  Stack_H when (ControlBus="011" and Selector='1') else (others =>'Z');

END MAIN;