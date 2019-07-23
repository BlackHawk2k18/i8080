library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY Sub_Sum IS
PORT(
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Carry_flag: OUT STD_LOGIC;
	FromFlags: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	F1_command: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: IN STD_LOGIC 
);
END Sub_Sum;
-------------------------------------------------------
ARCHITECTURE MAIN OF Sub_Sum IS
----------------------------------
signal result: STD_LOGIC_VECTOR(8 DOWNTO 0);
signal withCarry: STD_LOGIC_VECTOR(8 DOWNTO 0);
signal withoutCarry: STD_LOGIC_VECTOR(8 DOWNTO 0);
signal summWithCarry: STD_LOGIC_VECTOR(8 DOWNTO 0);
signal subWithCarry: STD_LOGIC_VECTOR(8 DOWNTO 0);
----------------------------------
BEGIN
	
	withCarry<=("0" & A_operand) + ("0" & B_operand) + F2_command + FromFlags(0);
	withoutCarry<=("0" & A_operand) + ("0" & B_operand) + F2_command;
	
	result<= withCarry when (F1_command="00000010" or F1_command="00000011") else withoutCarry;
	Y_result<=result(7 DOWNTO 0);
	Carry_flag<=result(8);

END MAIN;