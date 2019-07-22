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
	ControlBus: IN STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END CommonRegisters;
-------------------------------------------------------
ARCHITECTURE MAIN OF CommonRegisters IS
signal W, Z, B, C, D, E, H, L: STD_LOGIC_VECTOR(7 downto 0);
signal StaclPointer, AddrReg, InstructionsCounter: STD_LOGIC_VECTOR(15 downto 0);
BEGIN

	PROCESS(CLK, W, Z, B, C, D, E, H, L, StaclPointer, AddrReg, InstructionsCounter, RESET, ControlBus)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF (RESET='1') THEN
				StaclPointer <= (others => '0');
				AddrReg <= (others => '0');
				InstructionsCounter <= (others => '0');
				InternalDataBus <= (others => 'Z');
				W <= (others => '0');
				Z <= (others => '0');
				B <= (others => '0');
				C <= (others => '0');
				D <= (others => '0');
				E <= (others => '0');
				H <= (others => '0');
				L <= (others => '0');
			ELSE
				IF (ControlBus(9 downto 8)="00") THEN
					InternalDataBus<=B;
				ELSIF (ControlBus(9 downto 8)="01") THEN
					B<=InternalDataBus;
				ELSIF (ControlBus(9 downto 8)="10") THEN
					InternalDataBus<=C;
				ELSIF (ControlBus(9 downto 8)="11") THEN
					C<=InternalDataBus;
				END IF;
				
				IF (ControlBus(11 downto 10)="00") THEN
					InternalDataBus<=D;
				ELSIF (ControlBus(11 downto 10)="01") THEN
					D<=InternalDataBus;
				ELSIF (ControlBus(11 downto 10)="10") THEN
					InternalDataBus<=E;
				ELSIF (ControlBus(11 downto 10)="11") THEN
					E<=InternalDataBus;
				END IF;
				
				IF (ControlBus(13 downto 12)="00") THEN
					InternalDataBus<=H;
				ELSIF (ControlBus(13 downto 12)="01") THEN
					H<=InternalDataBus;
				ELSIF (ControlBus(13 downto 12)="10") THEN
					InternalDataBus<=L;
				ELSIF (ControlBus(13 downto 12)="11") THEN
					L<=InternalDataBus;
				END IF;
				
				IF (ControlBus(15 downto 14)="00") THEN
					InternalDataBus<=W;
				ELSIF (ControlBus(15 downto 14)="01") THEN
					W<=InternalDataBus;
				ELSIF (ControlBus(15 downto 14)="10") THEN
					InternalDataBus<=Z;
				ELSIF (ControlBus(15 downto 14)="11") THEN
					Z<=InternalDataBus;
				END IF;
				
				IF (ControlBus(7 downto 6)="00") THEN
					IF(InstructionsCounter)="1111111111111111" THEN
						InstructionsCounter<=(others=>'0');
					ELSE
						InstructionsCounter<=InstructionsCounter+1;
					END IF;
				ELSIF (ControlBus(7 downto 6)="10") THEN
					AddrReg<=InstructionsCounter;
				END IF;
			END IF;
			
			ToAdressBus<=AddrReg;
			
		END IF;
	END PROCESS;
END MAIN;

--Add StackPointer Logic