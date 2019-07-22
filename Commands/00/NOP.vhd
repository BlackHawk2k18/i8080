library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY NOP IS
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END NOP;
-------------------------------------------------------
ARCHITECTURE MAIN OF NOP IS
-------------------------------------------------------

-------------------------------------------------------
BEGIN
	PROCESS(CLK, EnableCommand)
	BEGIN
		IF (rising_edge(CLK)) THEN
			ControlBus<="ZZZZZZZZZZZZZZZZZZ";
		END IF;		
	END PROCESS;
END MAIN;