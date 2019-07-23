library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY FlagFlipFlops IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	ToALUFromFlags: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromALUtoFlags: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END FlagFlipFlops;
-------------------------------------------------------
ARCHITECTURE MAIN OF FlagFlipFlops IS
signal FlipFlopReg: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	PROCESS(CLK, FlipFlopReg, RESET, InternalDataBus, ControlBus, FromALUtoFlags)
		BEGIN
			IF (rising_edge(CLK)) THEN
				IF(RESET='1') THEN
					FlipFlopReg<="00000010";
					InternalDataBus<="ZZZZZZZZ";
				ELSE
					case ControlBus(5 downto 4) IS
						when "00" => InternalDataBus <= FlipFlopReg;
						when "01" => FlipFlopReg <= InternalDataBus;
						when "10" => FlipFlopReg <= FromALUtoFlags;
						when "11" => ToALUFromFlags <= FlipFlopReg;
						when others => InternalDataBus<="ZZZZZZZZ";
											ToALUFromFlags<="ZZZZZZZZ";
					end case;
				END IF;
			END IF;
		END PROCESS;
		
END MAIN;