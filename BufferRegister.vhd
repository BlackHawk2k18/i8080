library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY BufferRegister IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	BufferOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END BufferRegister;
-------------------------------------------------------
ARCHITECTURE MAIN OF BufferRegister IS
signal RegBuff: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	PROCESS(CLK, RegBuff, RESET, InternalDataBus, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(RESET='1') THEN
				RegBuff<="00000000";
			ELSE
				case ControlBus IS
					when '0' => RegBuff <= InternalDataBus;
					when '1' => BufferOutput <= RegBuff;
					when others => BufferOutput<="ZZZZZZZZ"; 
				end case;
			END IF;
		END IF;
	END PROCESS;

END MAIN;