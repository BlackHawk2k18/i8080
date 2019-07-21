library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-----------------------------------------------------
ENTITY Mux4_1 IS
PORT(
	CLK: IN STD_LOGIC;
	Summ: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Or_r: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	And_r: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	Y_Mux4_1: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F1_command: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END Mux4_1;
-----------------------------------------------------
ARCHITECTURE MAIN OF Mux4_1 IS
----------------------------------
signal MuxReg:   STD_LOGIC_VECTOR (7 DOWNTO 0);
----------------------------------
BEGIN
	PROCESS (CLK, F1_command, Summ, Or_r, And_r, ControlBus, MuxReg)
	BEGIN
		IF(rising_edge(CLK)) THEN
			case F1_command is
				when "00000000" => MuxReg <= Summ; --Сложение
				when "00000001" => MuxReg <= Summ; --Вычитание
				when "00000100" => MuxReg <= Or_r;
				when "00000101" => MuxReg <= And_r;
				when "00000110" => MuxReg <= Summ; --Равно
				when "00000111" => MuxReg <= Summ; --Не равно
				when "00001000" => MuxReg <= Summ; --Меньше
				when "00001001" => MuxReg <= Summ; --Больше
				when others => MuxReg <= "ZZZZZZZZ";
			end case;
		END IF;
	END PROCESS;
	
	Y_Mux4_1<=MuxReg when (ControlBus(17 downto 17)="1") else "ZZZZZZZZ";
	
END MAIN;										