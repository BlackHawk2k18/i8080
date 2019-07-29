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
	ControlBus: In STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END Mux4_1;
-----------------------------------------------------
ARCHITECTURE MAIN OF Mux4_1 IS
----------------------------------
signal MuxReg:   STD_LOGIC_VECTOR (7 DOWNTO 0);
----------------------------------
BEGIN
	
--	Y_Mux4_1<=Or_r when (ControlBus="001" and F1_command="00000100") else
--			   And_r when (ControlBus="001" and F1_command="00000101") else
--			   Summ  when (ControlBus="001" and (F1_command="00000000" or F1_command="00000001" or F1_command="00000010" or F1_command="00000011" or F1_command="00000111")) else (others => 'Z');
	PROCESS (CLK, F1_command, Summ, Or_r, And_r, ControlBus, MuxReg)
	BEGIN
		IF(rising_edge(CLK)) THEN
			case ControlBus(2 downto 0) IS
				when "001" =>
					IF(F1_command="00000100") THEN
						MuxReg <= Or_r;
					ELSIF(F1_command="00000101") THEN
						MuxReg <= And_r;
					ELSE
						MuxReg <= Summ;
					END IF;
				when others => MuxReg <= "ZZZZZZZZ";
			end case;
		END IF;

	END PROCESS;
	
	Y_Mux4_1<=MuxReg;	
		
END MAIN;					