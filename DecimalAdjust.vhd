library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY DecimalAdjust IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	ToALUFromDA: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromALUToDA: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(1 DOWNTO 0)
);
END DecimalAdjust;
-------------------------------------------------------
ARCHITECTURE MAIN OF DecimalAdjust IS
BEGIN

END MAIN;