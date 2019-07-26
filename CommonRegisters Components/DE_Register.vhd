library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY DE_Register IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END DE_Register;
-------------------------------------------------------
ARCHITECTURE MAIN OF DE_Register IS
signal D, E: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	D<=InternalDataBus when (ControlBus="000010") else D;
	E<=InternalDataBus when (ControlBus="010010") else E;
	
	ToStack(15 downto 8)<=D when (ControlBus="101010") else (others =>'Z');
	ToStack(7 downto 0)<=E when (ControlBus="101010") else (others =>'Z');
	
	ToAddressBus(15 downto 8)<=D when (ControlBus="100010") else (others =>'Z');
	ToAddressBus(7 downto 0)<=E when (ControlBus="100010") else (others =>'Z');
	
	InternalDataBus<=D when (ControlBus="001010") else 
						  E when (ControlBus="011010") else (others =>'Z');
		
END MAIN;