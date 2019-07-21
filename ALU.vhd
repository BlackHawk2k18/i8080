library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY ALU IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
   ToFlags: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromFlags: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToDecimalAdjust: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromDecimalAdjust: IN STD_LOGIC_VECTOR(7 DOWNTO 0);		
	F1_command: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: IN STD_LOGIC;
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END ALU;
-------------------------------------------------------
ARCHITECTURE MAIN OF ALU IS
----------------------------------
signal Sub_Sum_result:   STD_LOGIC_VECTOR (7 DOWNTO 0);
signal Or_result:        STD_LOGIC_VECTOR (7 DOWNTO 0);
signal And_result:       STD_LOGIC_VECTOR (7 DOWNTO 0);
signal Not_result:       STD_LOGIC_VECTOR (7 DOWNTO 0);
signal Mux2_1_result:    STD_LOGIC_VECTOR (7 DOWNTO 0);
signal Mux4_1_result:    STD_LOGIC_VECTOR (7 DOWNTO 0);
signal Carry_flag:       STD_LOGIC;
----------------------------------
COMPONENT Sub_Sum
PORT(
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Carry_flag: OUT STD_LOGIC;
	F2_command: IN STD_LOGIC 
);
END COMPONENT Sub_Sum;
----------------------------------
COMPONENT OR_Gate
PORT(
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) 
);
END COMPONENT OR_Gate;
----------------------------------
COMPONENT And_Gate
PORT(
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) 
);
END COMPONENT And_Gate;
----------------------------------
COMPONENT Not_Gate
PORT(
	Input: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Output: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) 
);
END COMPONENT Not_Gate;
----------------------------------
COMPONENT Mux2_1
PORT(
	CLK: IN STD_LOGIC;
	A_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_operand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F_switch: in STD_LOGIC
);
END COMPONENT Mux2_1;
----------------------------------
COMPONENT Mux4_1
PORT(
	CLK: IN STD_LOGIC;
	Summ: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Or_r: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	And_r: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_Mux4_1: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F1_command: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR (17 DOWNTO 0)
);
END COMPONENT Mux4_1;
----------------------------------
BEGIN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	U0: Sub_Sum   PORT MAP (A_operand, Mux2_1_result, Sub_Sum_result, Carry_flag, F2_command);                                         --Суммирование и вычитание
	U1: OR_Gate   PORT MAP (A_operand, Mux2_1_result, Or_result);                                                                      --Логическое сложение
	U2: And_Gate  PORT MAP (A_operand, Mux2_1_result, And_result);                                                                     --Логическое умножение
	U3: Not_Gate  PORT MAP (B_operand, Not_result);                                                                                 	  --Инверсия для B-операнда
	U4: Mux2_1    PORT MAP (CLK, B_operand, Not_result, Mux2_1_result, F2_command);                                              		  --Мультиплексор для выбора значения В-операнда
	U5: Mux4_1    PORT MAP (CLK, Sub_Sum_result, Or_result, And_result, Y_result, F1_command, ControlBus);                             --Мультиплексор для выбора Результата АЛУ
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
END MAIN;