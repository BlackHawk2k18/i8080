library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY InstructionDecoder IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	FromInstructionRegister: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	DDD: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
	SSS: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
	ControlBus: IN STD_LOGIC
);
END InstructionDecoder;
-------------------------------------------------------
ARCHITECTURE MAIN OF InstructionDecoder IS
signal DecoderReg: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	DDD <= FromInstructionRegister(5 downto 3);
	SSS <= FromInstructionRegister(2 downto 0);
	EnableCommand<=FromInstructionRegister;

END MAIN;

--	PROCESS(CLK, DecoderReg, RESET, FromInstructionRegister, ControlBus)
--	BEGIN
--		IF (rising_edge(CLK)) THEN
--			IF(RESET='1') THEN
--				DecoderReg<="00000000";
--				EnableCommand<="ZZZZZZZZ";
--				DDD<="ZZZ";
--				SSS<="ZZZ";
--			ELSE
--				DDD <= FromInstructionRegister(5 downto 3);
--				SSS <= FromInstructionRegister(2 downto 0);
--				EnableCommand<=FromInstructionRegister;
--			END IF;
--		END IF;
--	END PROCESS;