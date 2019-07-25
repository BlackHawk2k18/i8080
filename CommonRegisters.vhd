library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------
ENTITY CommonRegisters IS
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END CommonRegisters;
-------------------------------------------------------
ARCHITECTURE MAIN OF CommonRegisters IS
--------------------------------------------
signal ToStack: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal AdressReg: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal Selector: STD_LOGIC_VECTOR(5 DOWNTO 0);
--------------------------------------------
COMPONENT WZ_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT WZ_Register;
---------------------------------------------------------
COMPONENT BC_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT BC_Register;
---------------------------------------------------------
COMPONENT DE_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT DE_Register;
---------------------------------------------------------
COMPONENT HL_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT HL_Register;
---------------------------------------------------------
COMPONENT StackPointer
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT StackPointer;
---------------------------------------------------------
COMPONENT InstructionCounter
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: IN STD_LOGIC;
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT InstructionCounter;
---------------------------------------------------------
COMPONENT Mux6_1
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Selector: OUT STD_LOGIC_VECTOR (5 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END COMPONENT Mux6_1;
---------------------------------------------------------
BEGIN

	U0: WZ_Register        PORT MAP (CLK, RESET, Selector(0), InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 3));
	U1: BC_Register        PORT MAP (CLK, RESET, Selector(1), InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 3));
	U2: DE_Register        PORT MAP (CLK, RESET, Selector(2), InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 3));
	U3: HL_Register        PORT MAP (CLK, RESET, Selector(3), InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 3));
	U4: StackPointer       PORT MAP (CLK, RESET, Selector(4), InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 3));
	U5: InstructionCounter PORT MAP (CLK, RESET, Selector(5), AdressReg, ControlBus(5 downto 3));
	U6: Mux6_1             PORT MAP (CLK, RESET, Selector, ControlBus(2 downto 0));

	ToAdressBus<=AdressReg when (ControlBus(5 downto 3)="100") else (others =>'Z');

END MAIN;

--PROCESS(CLK, W, Z, B, C, D, E, H, L, StackPointer, AddrReg, InstructionsCounter, RESET, ControlBus, InternalDataBus)
--	BEGIN
--		IF (rising_edge(CLK)) THEN
--			IF (RESET='1') THEN
--				StackPointer <= (others => '0');
--				AddrReg <= (others => '0');
--				InstructionsCounter <= (others => '0');
--				InternalDataBus <= (others => 'Z');
--				W <= (others => '0');
--				Z <= (others => '0');
--				B <= (others => '0');
--				C <= (others => '0');
--				D <= (others => '0');
--				E <= (others => '0');
--				H <= (others => '0');
--				L <= (others => '0');
--			ELSE
--				IF ControlBus(9 downto 8) = "00" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=B;--"00001010";-- 
--				ELSIF ControlBus(9 downto 8) = "01" and ControlBus(17 downto 17)="0" THEN 
--					B<=InternalDataBus;
--				ELSIF ControlBus(9 downto 8) = "10" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=D;
--				ELSIF ControlBus(9 downto 8) = "11" and ControlBus(17 downto 17)="0" THEN 
--					D<=InternalDataBus;
--				ELSIF ControlBus(11 downto 10) = "00" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=C; 
--				ELSIF ControlBus(11 downto 10) = "01" and ControlBus(17 downto 17)="0" THEN 
--					C<=InternalDataBus;
--				ELSIF ControlBus(11 downto 10) = "10" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=E;
--				ELSIF ControlBus(11 downto 10) = "11" and ControlBus(17 downto 17)="0" THEN 
--					E<=InternalDataBus;
--				ELSIF ControlBus(13 downto 12) = "00" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=H; 
--				ELSIF ControlBus(13 downto 12) = "01" and ControlBus(17 downto 17)="0" THEN 
--					H<=InternalDataBus;
--				ELSIF ControlBus(13 downto 12) = "10" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=W;
--				ELSIF ControlBus(13 downto 12) = "11" and ControlBus(17 downto 17)="0"  THEN 
--					W<=InternalDataBus;
--				ELSIF ControlBus(15 downto 14) = "00" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=L; 
--				ELSIF ControlBus(15 downto 14) = "01" and ControlBus(17 downto 17)="0" THEN 
--					L<=InternalDataBus;
--				ELSIF ControlBus(15 downto 14) = "10" and ControlBus(17 downto 17)="0" THEN 
--					InternalDataBus<=Z;
--				ELSIF ControlBus(15 downto 14) = "11" and ControlBus(17 downto 17)="0" THEN 
--					Z<=InternalDataBus;
--				ELSE
--					InternalDataBus <= (others => 'Z');
--				END IF;
--				
--				IF ControlBus(11 downto 8)="0000" and ControlBus(1 downto 0)="10" THEN
--					AddrReg(15 downto 8)<=B;
--					AddrReg(7 downto 0)<=C;
--				ELSIF ControlBus(11 downto 8)="1010" and ControlBus(1 downto 0)="10" THEN
--					AddrReg(15 downto 8)<=D;
--					AddrReg(7 downto 0)<=E;
--				ELSIF ControlBus(15 downto 12)="0000" and ControlBus(1 downto 0)="10" THEN
--					AddrReg(15 downto 8)<=H;
--					AddrReg(7 downto 0)<=L;
--				ELSIF ControlBus(7 downto 6)="10" and ControlBus(1 downto 0)="10" THEN
--					AddrReg<=InstructionsCounter;
--				ELSIF ControlBus(7 downto 6)="00" and ControlBus(1 downto 0)="10" THEN
--					InstructionsCounter<=InstructionsCounter+1;
--				ELSE
--					AddrReg <= (others => 'Z');
--				END IF;
--				
--				IF ControlBus(11 downto 8)="0000" and ControlBus(1 downto 0)="11" THEN
--					StackPointer(15 downto 8)<=B;
--					StackPointer(7 downto 0)<=C;
--				ELSIF ControlBus(11 downto 8)="1010" and ControlBus(1 downto 0)="11"  THEN
--					StackPointer(15 downto 8)<=D;
--					StackPointer(7 downto 0)<=E;
--				ELSIF ControlBus(15 downto 12)="0000" and ControlBus(1 downto 0)="11"  THEN
--					StackPointer(15 downto 8)<=H;
--					StackPointer(7 downto 0)<=L;
--				ELSE
--					StackPointer <= (others => 'Z');
--				END IF;
--				
--				IF(ControlBus(1 downto 0)="10") THEN
--					ToAdressBus<=AddrReg;
--				ELSIF(ControlBus(1 downto 0)="11") THEN
--					ToAdressBus<=StackPointer;
--				ELSE
--					ToAdressBus<=(others =>'Z');
--				END IF;
--			END IF;
--		END IF;	
--	END PROCESS;