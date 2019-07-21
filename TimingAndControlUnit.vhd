library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY TimingAndControlUnit IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	GroupFromDecoder: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END TimingAndControlUnit;
-------------------------------------------------------
ARCHITECTURE MAIN OF TimingAndControlUnit IS
-------------------------------------------------------
signal Counter: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal CommandReset: STD_LOGIC;
-------------------------------------------------------
BEGIN
-------------------------------------------------------00 GROUP-------------------------------------------------------
	U0: NOP  PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U1: DAD  PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U2: LXI  PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U3: STAX PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U4: LDAX PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U5: SHLD PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U6: LHLD PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U7: STA  PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U8: LDA  PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U9: DCX  PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U10: INX PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);	
	U11: INR PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U12: DCR PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U13: MVI PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U14: RLC PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U15: RRC PORT MAP (CLK, Counter, CommandReset, ControlBus);	
	U16: RAL PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U17: RAR PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U18: DAA PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U19: CMA PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U20: STC PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U21: CMC PORT MAP (CLK, Counter, CommandReset, ControlBus);
-------------------------------------------------------00 GROUP-------------------------------------------------------

-------------------------------------------------------01 GROUP-------------------------------------------------------
	U22: MOV PORT MAP (CLK, Counter, CommandReset, DDD, SSS, ControlBus);
	U23: HLT PORT MAP (CLK, Counter, CommandReset, ControlBus);
-------------------------------------------------------01 GROUP-------------------------------------------------------	
	
-------------------------------------------------------10 GROUP-------------------------------------------------------
	U24: ADD PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U25: ADC PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U26: SUB PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U27: SBB PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U28: ANA PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U29: XRA PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U30: ORA PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
	U31: CMP PORT MAP (CLK, Counter, CommandReset, SSS, F1_command, F2_command, ControlBus);
-------------------------------------------------------10 GROUP-------------------------------------------------------	

-------------------------------------------------------11 GROUP-------------------------------------------------------	
	U32: RETIF   PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U33: POP     PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U34: RET     PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U35: PCHL    PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U36: SPHL    PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U37: JPM_IF  PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U38: JMP     PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U39: PortOUT PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U40: PortIN  PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U41: XTHL    PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U42: XCHG    PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U43: DI      PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U44: EI      PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U45: CALLIF  PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U46: PUSH    PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
	U47: CALL    PORT MAP (CLK, Counter, CommandReset, ControlBus);
	U48: ADI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U49: ACI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U50: SUI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U51: SBI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U52: ANI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U53: XRI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U54: ORI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U55: CPI     PORT MAP (CLK, Counter, CommandReset, F1_command, F2_command, ControlBus);
	U56: RST     PORT MAP (CLK, Counter, CommandReset, DDD, ControlBus);
-------------------------------------------------------11 GROUP-------------------------------------------------------	
	PROCESS(CLK, Counter, RESET, CommandReset)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(RESET='1' or CommandReset='1') THEN
				Counter<="00000000";
			ELSE
				Counter<=Counter+1;
			END IF;
		END IF;
	END PROCESS;
END MAIN;