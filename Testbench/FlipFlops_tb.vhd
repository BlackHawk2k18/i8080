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
signal ToALUFromFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FromALUtoFlags: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(17 DOWNTO 0);

COMPONENT FlagFlipFlops
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
   InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
	ToALUFromFlags: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FromALUtoFlags: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END COMPONENT FlagFlipFlops;

BEGIN

	U1: FlagFlipFlops PORT MAP (CLK, RESET, InternalDataBus, ToALUFromFlags, FromALUtoFlags, ControlBus);	
	
	process begin
	InternalDataBus<="ZZZZZZZZ";
	FromALUtoFlags<="10101010";
	ControlBus<="ZZZZZZZZZZZZZZZZZZ";
	
	RESET<='0'; wait for 10 ns;
	RESET<='1'; wait for 10 ns;
	RESET<='0'; wait for 20 ns;
	
	InternalDataBus<="11100111";
	
	ControlBus<="------------011111"; wait for 20 ns; --В регистры
	ControlBus<="------------100000"; InternalDataBus<="ZZZZZZZZ"; wait for 20 ns; --Из АЛУ
	ControlBus<="------------001111"; wait for 20 ns; --В шину
	ControlBus<="------------111111"; wait for 20 ns;-- В АЛУ
	ControlBus<="ZZZZZZZZZZZZZZZZZZ";
	wait;
	end process;
	
	process begin
	CLK<='1'; wait for 10 ns;
	CLK<='0'; wait for 10 ns;
	end process;
	
END MAIN;						
						
--						when "00000000" => InternalDataBus <= FlipFlopReg;
--						when "00001110" => FlipFlopReg <= InternalDataBus;
--						when "00001111" => ToALUFromFlags <= FlipFlopReg;
--						when "00000101" => FlipFlopReg <= FromALUtoFlags;