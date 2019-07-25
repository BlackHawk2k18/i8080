library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY DE_Register IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END DE_Register;
-------------------------------------------------------
ARCHITECTURE MAIN OF DE_Register IS
signal D, E: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	D<=InternalDataBus when (ControlBus="000" and Selector'EVENT and Selector='1') else D;
	E<=InternalDataBus when (ControlBus="010" and Selector='1') else E;
	
	ToStack(15 downto 8)<=D when (ControlBus="101" and Selector='1') else (others =>'Z');
	ToStack(7 downto 0)<=E when (ControlBus="101" and Selector='1') else (others =>'Z');
	
	ToAdressBus(15 downto 8)<=D when (ControlBus="100" and Selector='1') else (others =>'Z');
	ToAdressBus(7 downto 0)<=E when (ControlBus="100" and Selector='1') else (others =>'Z');
	
	InternalDataBus<=D when (ControlBus="001" and Selector='1') else 
						  E when (ControlBus="011" and Selector='1') else (others =>'Z');
		
END MAIN;