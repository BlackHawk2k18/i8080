library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Accumulator IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	AccumulatorOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END Accumulator;
-------------------------------------------------------
ARCHITECTURE MAIN OF Accumulator IS
signal RegAcc: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	PROCESS(CLK, RegAcc, RESET, InternalDataBus, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(RESET='1') THEN
				RegAcc<="00000000";
			ELSE
				case ControlBus(1 downto 0) IS
					when "00" => RegAcc <= InternalDataBus;
					when "01" => InternalDataBus <= RegAcc;
					when others => InternalDataBus <= "ZZZZZZZZ";
				end case;
			END IF;
		END IF;
	END PROCESS;
	
	AccumulatorOutput<=RegAcc;

END MAIN;