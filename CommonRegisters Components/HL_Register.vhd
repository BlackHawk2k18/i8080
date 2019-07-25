library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY HL_Register IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END HL_Register;
-------------------------------------------------------
ARCHITECTURE MAIN OF HL_Register IS
signal H, L: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	H<=InternalDataBus when (ControlBus="000" and Selector'EVENT and Selector='1') else H;
	L<=InternalDataBus when (ControlBus="010" and Selector='1') else L;
	
	ToStack(15 downto 8)<=H when (ControlBus="101" and Selector='1') else (others =>'Z');
	ToStack(7 downto 0)<=L when (ControlBus="101" and Selector='1') else (others =>'Z');
	
	ToAdressBus(15 downto 8)<=H when (ControlBus="100" and Selector='1') else (others =>'Z');
	ToAdressBus(7 downto 0)<=L when (ControlBus="100" and Selector='1') else (others =>'Z');
	
	InternalDataBus<=H when (ControlBus="001" and Selector='1') else 
						  L when (ControlBus="011" and Selector='1') else (others =>'Z');
	
END MAIN;