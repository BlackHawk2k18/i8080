library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY HL_Register IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END HL_Register;
-------------------------------------------------------
ARCHITECTURE MAIN OF HL_Register IS
signal H, L: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	H<=InternalDataBus when (ControlBus="000011") else H;
	L<=InternalDataBus when (ControlBus="010011") else L;
	
	ToStack(15 downto 8)<=H when (ControlBus="101011") else (others =>'Z');
	ToStack(7 downto 0)<=L when (ControlBus="101011") else (others =>'Z');
	
	ToAddressBus(15 downto 8)<=H when (ControlBus="100011") else (others =>'Z');
	ToAddressBus(7 downto 0)<=L when (ControlBus="100011") else (others =>'Z');
	
	InternalDataBus<=H when (ControlBus="001011") else 
						  L when (ControlBus="011011") else (others =>'Z');
	
END MAIN;