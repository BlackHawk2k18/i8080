library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY LDAX IS
PORT(
	CLK: IN STD_LOGIC;
	Counter: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END LDAX;
-------------------------------------------------------
ARCHITECTURE MAIN OF LDAX IS
-------------------------------------------------------

-------------------------------------------------------
BEGIN
END MAIN;