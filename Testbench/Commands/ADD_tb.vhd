library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Testbench IS
END;
-------------------------------------------------------
ARCHITECTURE MAIN OF Testbench IS
----------------------------------
signal CLK: STD_LOGIC;
signal RESET: STD_LOGIC;
signal InternalDataBus: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal EnableCommand: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal SSS: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal F1_command: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal F2_command: STD_LOGIC;
signal ControlBus: STD_LOGIC_VECTOR(22 DOWNTO 0);
signal CommandReset: STD_LOGIC;
----------------------------------
COMPONENT ADD
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END COMPONENT ADD;
----------------------------------

BEGIN

	U0: ADD PORT MAP (CLK, EnableCommand, CommandReset, SSS, F1_command, F2_command, ControlBus);
	
	process begin
		EnableCommand<=(others => 'Z');
		CommandReset<='Z';
		
		F1_command<=(others => 'Z');
		F2_command<='Z';
		ControlBus<=(others => 'Z');
		
		InternalDataBus<=(others => 'Z');

		RESET<='0'; wait for 10 ns;
		RESET<='1'; wait for 10 ns;
		RESET<='0'; wait for 20 ns;
		
		EnableCommand<="10000000"; wait for 20 ns;
		SSS<=(others => '0');
		
		wait;
	end process;
	
	process begin
		CLK<='1'; wait for 10 ns;
		CLK<='0'; wait for 10 ns;
	end process;
	
END MAIN;