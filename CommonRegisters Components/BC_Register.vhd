library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY BC_Register IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END BC_Register;
-------------------------------------------------------
ARCHITECTURE MAIN OF BC_Register IS
signal B, C: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	B<=InternalDataBus when (ControlBus="000001") else B;
	C<=InternalDataBus when (ControlBus="010001") else C;
	
	ToStack(15 downto 8)<=B when (ControlBus="101001") else (others =>'Z');
	ToStack(7 downto 0)<=C when (ControlBus="101001") else (others =>'Z');
	
	ToAddressBus(15 downto 8)<=B when (ControlBus="100001") else (others =>'Z');
	ToAddressBus(7 downto 0)<=C when (ControlBus="100001") else (others =>'Z');
	
	InternalDataBus<=B when (ControlBus="001001") else 
						  C when (ControlBus="011001") else (others =>'Z');
						  
END MAIN;