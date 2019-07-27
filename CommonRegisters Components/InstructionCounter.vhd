library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY InstructionCounter IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END InstructionCounter;
-------------------------------------------------------
ARCHITECTURE MAIN OF InstructionCounter IS
signal InstrCounterReg: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal Address: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	
	InstrCounterReg<=(others => '0') when RESET='1' else
						  InstrCounterReg+1 when (ControlBus="110101" and rising_edge(CLK)) else InstrCounterReg;
	ToAddressBus<=InstrCounterReg when ControlBus="100101" else (others => 'Z');
	
	
	
	
	
	
	
	
	
	
--	PROCESS(CLK, RESET, ControlBus)
--	BEGIN
--		IF(RESET='1') THEN
--			InstrCounterReg<=(others => '0');
--			ToAddressBus<=(others => 'Z');
--		ELSIF(ControlBus="110101") THEN
--			IF(rising_edge(CLK)) THEN
--				InstrCounterReg<=InstrCounterReg+1;
--			END IF;
--		ELSIF(ControlBus="100101") THEN
--			ToAddressBus<=InstrCounterReg;
--		END IF;	
--	END PROCESS;

END MAIN;