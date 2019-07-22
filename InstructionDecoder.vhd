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
	ControlBus: IN STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END InstructionDecoder;
-------------------------------------------------------
ARCHITECTURE MAIN OF InstructionDecoder IS
signal DecoderReg: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	PROCESS(CLK, DecoderReg, RESET, FromInstructionRegister, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(RESET='1') THEN
				DecoderReg<="00000000";
				EnableCommand<="ZZZZZZZZ";
				DDD<="ZZZ";
				SSS<="ZZZ";
			ELSE
				DDD <= DecoderReg(5 downto 3);
				SSS <= DecoderReg(2 downto 0);
				EnableCommand<=FromInstructionRegister;
			END IF;
			
			IF(ControlBus(16 downto 16)="0") THEN
				DecoderReg<=FromInstructionRegister;
			END IF;
		END IF;
	END PROCESS;
END MAIN;


--				case FromInstructionRegister(7 downto 6) IS
--				   -------------------------------------------------------
--					when "00" => GroupToControlUnit<="00";
--									 IF(DecoderReg(2 downto 0)="000")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--									 ELSIF(DecoderReg(2 downto 0)="001")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--										DDD <="00000" & DecoderReg(5 downto 3);
--									 ELSIF(DecoderReg(2 downto 0)="010")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--										DDD <="00000" & DecoderReg(5 downto 3);
--									 ELSIF(DecoderReg(2 downto 0)="011")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--										DDD <="00000" & DecoderReg(5 downto 3);
--									 ELSIF(DecoderReg(2 downto 0)="100")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--										DDD <="00000" & DecoderReg(5 downto 3);
--									 ELSIF(DecoderReg(2 downto 0)="101")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--										DDD <="00000" & DecoderReg(5 downto 3);
--									 ELSIF(DecoderReg(2 downto 0)="110")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--										DDD <="00000" & DecoderReg(5 downto 3);
--									 ELSIF(DecoderReg(2 downto 0)="111")THEN
--										CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--									 END IF;
--					-------------------------------------------------------
--					when "01" => GroupToControlUnit<="01";
--									 IF(DecoderReg(5 downto 0)="110110") THEN	--HLT
--										 DDD <="ZZZZZZZZ";
--										 SSS <="ZZZZZZZZ";
--										 CommandToControlUnit<="00000000";
--									 ELSE                                     --MOV DDD,SSS
--										DDD <="00000" & DecoderReg(5 downto 3);
--										SSS <="00000" & DecoderReg(2 downto 0);
--										CommandToControlUnit<="00000001";
--									END IF;
--					-------------------------------------------------------
--					when "10" => GroupToControlUnit<="10";
--									 CommandToControlUnit<="00" & DecoderReg(5 downto 3) & "000";
--									 DDD <="ZZZZZZZZ";
--									 SSS <="00000" & DecoderReg(2 downto 0);
--               -------------------------------------------------------					
--					when "11" => GroupToControlUnit<="11";
--					-------------------------------------------------------
--				end case;