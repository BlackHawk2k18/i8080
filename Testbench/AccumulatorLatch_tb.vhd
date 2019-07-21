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
signal FromAccumulator: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal LatchOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);

COMPONENT AccumulatorLatch
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   FromAccumulator: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	LatchOutput: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: In STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT AccumulatorLatch;

BEGIN

	U1: AccumulatorLatch PORT MAP (CLK, RESET, FromAccumulator, LatchOutput, ControlBus);	
	
	process begin
	FromAccumulator<="10101010";
	ControlBus<="ZZZZZZZZZZZZZZZZZZ";
	
	RESET<='0'; wait for 10 ns;
	RESET<='1'; wait for 10 ns;
	RESET<='0'; wait for 20 ns;
		
	ControlBus<="----------------10"; wait for 20 ns; --В регистр
	ControlBus<="----------------11"; wait for 20 ns; --В АЛУ
	ControlBus<="----------------00";
	wait;
	end process;
	
	process begin
	CLK<='1'; wait for 10 ns;
	CLK<='0'; wait for 10 ns;
	end process;
	
END MAIN;

--					when "00000100" => RegAccLatch <= FromAccumulator;
--					when "00010000" => LatchOutput <= RegAccLatch;