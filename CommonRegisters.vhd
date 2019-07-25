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
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT WZ_Register;
---------------------------------------------------------
COMPONENT BC_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT BC_Register;
---------------------------------------------------------
COMPONENT DE_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT DE_Register;
---------------------------------------------------------
COMPONENT HL_Register
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT HL_Register;
---------------------------------------------------------
COMPONENT StackPointer
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	ToStack: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT StackPointer;
---------------------------------------------------------
COMPONENT InstructionCounter
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	ToAdressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT InstructionCounter;
---------------------------------------------------------
BEGIN

	U0: WZ_Register        PORT MAP (CLK, RESET, InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 0));
	U1: BC_Register        PORT MAP (CLK, RESET, InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 0));
	U2: DE_Register        PORT MAP (CLK, RESET, InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 0));
	U3: HL_Register        PORT MAP (CLK, RESET, InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 0));
	U4: StackPointer       PORT MAP (CLK, RESET, InternalDataBus, AdressReg, ToStack, ControlBus(5 downto 0));
	U5: InstructionCounter PORT MAP (CLK, RESET, AdressReg, ControlBus(5 downto 0));

	ToAdressBus<=AdressReg when (ControlBus(5 downto 3)="100") else (others =>'Z');

END MAIN;