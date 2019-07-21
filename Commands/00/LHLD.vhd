library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY LHLD IS
PORT(
	CLK: IN STD_LOGIC;
	Counter: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	CommandReset: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END LHLD;
-------------------------------------------------------
ARCHITECTURE MAIN OF LHLD IS
-------------------------------------------------------

-------------------------------------------------------
BEGIN
END MAIN;