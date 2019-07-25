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
BEGIN
	InternalDataBus<=(others =>'Z');
	ToAdressBus<=(others =>'Z');
	ToStack<=(others =>'Z');
END MAIN;