library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY PCHL IS
PORT(
	CLK: IN STD_LOGIC;
	Counter: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END PCHL;
-------------------------------------------------------
ARCHITECTURE MAIN OF PCHL IS
-------------------------------------------------------

-------------------------------------------------------
BEGIN
	PROCESS(CLK, Counter, EnableCommand)
	BEGIN
		IF (rising_edge(CLK)) THEN
			ControlBus<="ZZZZZZZZZZZZZZZZZZ";
		END IF;		
	END PROCESS;
END MAIN;