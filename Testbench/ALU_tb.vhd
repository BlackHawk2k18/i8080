library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Testbench IS
END;
-------------------------------------------------------
ARCHITECTURE MAIN OF Testbench IS
----------------------------------
signal CLK: STD_LOGIC;
signal RESET: STD_LOGIC;
signal A_operand: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal B_operand: STD_LOGIC_VECTOR (7 DOWNTO 0); 
signal Y_result: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ToFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);--
signal ToDecimalAdjust: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromDecimalAdjust: STD_LOGIC_VECTOR(7 DOWNTO 0);--		
signal F1_command: STD_LOGIC_VECTOR (7 DOWNTO 0);--
signal F2_command: STD_LOGIC; --
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0); --
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
	process begin
		ControlBus<="ZZZZZZZZZZZZZZZZZZ";
--		Sub_Sum_result<="00000000";
--		Or_result<="00000000";
--		And_result<="00000000";
		F2_command<='Z';
		F1_command<="ZZZZZZZZ";
		A_operand<="00000010"; --Число 2
		B_operand<="11111110"; --Число -2
		
		RESET<='0'; wait for 10 ns;
		RESET<='1'; wait for 10 ns;
		RESET<='0'; wait for 20 ns;
		
		A_operand<="00000010"; --Число 2
		B_operand<="11111110"; --Число -2
		
		F2_command<='0';
		F1_command<="00000000";
		ControlBus<="----------00----00";wait for 40 ns;
		
		F2_command<='1';
		F1_command<="00000001";
		ControlBus<="----------01----00";wait for 20 ns;
	wait;
	end process;
	
	process begin
		CLK<='1'; wait for 10 ns;
		CLK<='0'; wait for 10 ns;
	end process;
END MAIN;