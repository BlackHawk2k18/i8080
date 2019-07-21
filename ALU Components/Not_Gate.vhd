library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------
ENTITY Not_Gate IS
PORT(
	Input: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Output: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) 
);
END Not_Gate;
-----------------------------------------------------
ARCHITECTURE MAIN OF Not_Gate IS
BEGIN
	Output<= not Input;
END MAIN;