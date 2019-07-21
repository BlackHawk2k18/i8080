library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY AccumulatorLatch IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   FromAccumulator: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	LatchOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END AccumulatorLatch;
-------------------------------------------------------
ARCHITECTURE MAIN OF AccumulatorLatch IS
signal RegAccLatch: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	PROCESS(CLK, RegAccLatch, RESET, FromAccumulator, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(RESET='1') THEN
				RegAccLatch<="00000000";
			ELSE
				case ControlBus(3 downto 2) IS
					when "00" => RegAccLatch <= FromAccumulator;
					when "11" => LatchOutput <= RegAccLatch;
					when others => LatchOutput<="ZZZZZZZZ"; 
				end case;
			END IF;
		END IF;
	END PROCESS;

END MAIN;