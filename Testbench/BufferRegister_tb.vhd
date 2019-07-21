library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Testbench IS
END;
-------------------------------------------------------
ARCHITECTURE MAIN OF Testbench IS

signal CLK: STD_LOGIC;
signal RESET: STD_LOGIC;
signal InternalDataBus: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal BufferOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);

COMPONENT BufferRegister
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	BufferOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT BufferRegister;

BEGIN

	U1: BufferRegister PORT MAP (CLK, RESET, InternalDataBus, BufferOutput, ControlBus);	
	
	process begin
	InternalDataBus<="10101010";
	ControlBus<="ZZZZZZZZZZZZZZZZZZ";
	
	RESET<='0'; wait for 10 ns;
	RESET<='1'; wait for 10 ns;
	RESET<='0'; wait for 20 ns;
		
	ControlBus<="--------------0000"; wait for 20 ns; --В регистр
	ControlBus<="----------------11"; wait for 20 ns; --В АЛУ
	ControlBus<="--------------01--";
	wait;
	end process;
	
	process begin
	CLK<='1'; wait for 10 ns;
	CLK<='0'; wait for 10 ns;
	end process;
	
END MAIN;