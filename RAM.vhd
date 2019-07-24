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
	Memory_RW: IN STD_LOGIC
);
END RAM;
-------------------------------------------------------
ARCHITECTURE MAIN OF RAM IS
-------------------------------------------------------
type Memory is array (65535 downto 0) of std_logic_vector (7 downto 0);
signal MemoryCell: Memory:=(
   0 => "10000000",	
   1 => "00000010",	
   2 => "00000011",	
   3 => "00000100", 
   4 => "00000101",	
   5 => "00000110", 
   6 => "00000111",	
   7 => "00001000",
	others => "00000000"
);
-------------------------------------------------------
BEGIN

	PROCESS(CLK, FromAdressBus, Memory_RW)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(Memory_RW='0') THEN
				MemoryCell(to_integer(unsigned(FromAdressBus)))<=InternalDataBus;
			ELSIF(Memory_RW='1') THEN
				InternalDataBus<=MemoryCell(to_integer(unsigned(FromAdressBus)));
			ELSE
				InternalDataBus<= "ZZZZZZZZ";
			END IF;
		END IF;
	END PROCESS;
	
END MAIN;