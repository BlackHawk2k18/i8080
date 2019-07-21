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
signal AccumulatorOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);

COMPONENT Accumulator
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	AccumulatorOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT Accumulator;

BEGIN

	U1: Accumulator PORT MAP (CLK, RESET, InternalDataBus, AccumulatorOutput, ControlBus);	
	
	process begin
	RESET<='0'; wait for 10 ns;
	RESET<='1'; wait for 10 ns;
	RESET<='0'; wait for 20 ns;
	
	InternalDataBus<="11100111";
	ControlBus<="------1111------00";wait for 20 ns;
	
	InternalDataBus<="ZZZZZZZZ";
	ControlBus<="--000000--------01";wait for 20 ns;
	
	ControlBus<="UUUUUUUU--------10"; wait for 20 ns;
	ControlBus<="-XXX------------ZZ";
	wait;
	end process;
	
	process begin
	CLK<='1'; wait for 10 ns;
	CLK<='0'; wait for 10 ns;
	end process;
	
END MAIN;