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
		case ControlBus(17 downto 17) IS
			when "1" =>
				IF(F1_command="00000100") THEN
					Y_Mux4_1 <= Or_r;
				ELSIF(F1_command="00000101") THEN
					Y_Mux4_1 <= And_r;
				ELSE
					Y_Mux4_1 <= Summ;
				END IF;
			when others => Y_Mux4_1 <= "ZZZZZZZZ";
			end case;
		END IF;
	END PROCESS;
END MAIN;										