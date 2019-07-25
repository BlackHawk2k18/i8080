library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY RAM IS
PORT(
	CLK: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromAdressBus: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END RAM;
-------------------------------------------------------
ARCHITECTURE MAIN OF RAM IS
-------------------------------------------------------
type Memory is array (65535 downto 0) of std_logic_vector (7 downto 0);
signal MemoryCell: Memory:=(
   0 => "00111010",	
   1 => "00000010",
	others => "00000000"
);
-------------------------------------------------------
BEGIN

	PROCESS(CLK, FromAdressBus, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(ControlBus='0') THEN
				MemoryCell(to_integer(unsigned(FromAdressBus)))<=InternalDataBus;
			ELSIF(ControlBus='1') THEN
				InternalDataBus<=MemoryCell(to_integer(unsigned(FromAdressBus)));
			ELSE
				InternalDataBus<= "ZZZZZZZZ";
			END IF;
		END IF;
	END PROCESS;
	
END MAIN;