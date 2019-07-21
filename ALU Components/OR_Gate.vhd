library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------
ENTITY OR_Gate IS
PORT(
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) 
);
END OR_Gate;
-----------------------------------------------------
ARCHITECTURE MAIN OF OR_Gate IS
BEGIN
	Y_result<= A_operand or B_operand;
END MAIN;