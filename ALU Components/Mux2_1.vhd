library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------
ENTITY Mux2_1 IS
PORT(
	CLK: IN STD_LOGIC;
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F_switch: IN STD_LOGIC
);
END Mux2_1;
-----------------------------------------------------
ARCHITECTURE MAIN OF Mux2_1 IS
BEGIN
	Y_result<=B_operand when (F_switch = '1') else A_operand; 
END MAIN;