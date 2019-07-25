library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY Mux6_1 IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: OUT STD_LOGIC_VECTOR (5 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END Mux6_1;
-------------------------------------------------------
ARCHITECTURE MAIN OF Mux6_1 IS
--------------------------------------------
BEGIN

	Selector(5)<='1' when ControlBus="101" else '0';
	Selector(4)<='1' when ControlBus="100" else '0';
	Selector(3)<='1' when ControlBus="011" else '0';
	Selector(2)<='1' when ControlBus="010" else '0';
	Selector(1)<='1' when ControlBus="001" else '0';
	Selector(0)<='1' when ControlBus="000" else '0';
	
END MAIN;