library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY WZ_Register IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END WZ_Register;
-------------------------------------------------------
ARCHITECTURE MAIN OF WZ_Register IS
signal W, Z: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	W<=(others=>'0') when RESET='1' else
		InternalDataBus when (ControlBus="000000") else W;
	Z<=(others=>'0') when RESET='1' else
		InternalDataBus when (ControlBus="010000") else Z;
	
	ToStack(15 downto 8)<=W when (ControlBus="101000") else (others =>'Z');
	ToStack(7 downto 0)<=Z when (ControlBus="101000") else (others =>'Z');
	
	ToAddressBus(15 downto 8)<=W when (ControlBus="100000") else (others =>'Z');
	ToAddressBus(7 downto 0)<=Z when (ControlBus="100000") else (others =>'Z');
	
	InternalDataBus<=W when (ControlBus="001000") else 
						  Z when (ControlBus="011000") else (others =>'Z');
							  
END MAIN;