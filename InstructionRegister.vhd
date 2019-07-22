library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY InstructionRegister IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToDecoder: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END InstructionRegister;
-------------------------------------------------------
ARCHITECTURE MAIN OF InstructionRegister IS
signal InstrReg: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	PROCESS(CLK, InstrReg, RESET, InternalDataBus, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(RESET='1') THEN
				InstrReg<="00000000";
			ELSE
				case ControlBus(16 downto 16) IS
					when "0" => InstrReg <= InternalDataBus;
					when "1" => ToDecoder <= InstrReg;
					when others => ToDecoder <= "ZZZZZZZZ";
				end case;
			END IF;
		END IF;
	END PROCESS;

END MAIN;