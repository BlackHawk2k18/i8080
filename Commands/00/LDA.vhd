library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY LDA IS
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	Memory_RW: OUT STD_LOGIC
);
END LDA;
-------------------------------------------------------
ARCHITECTURE MAIN OF LDA IS
-------------------------------------------------------
signal Counter: unsigned(7 downto 0);
-------------------------------------------------------
BEGIN
	PROCESS(CLK, Counter, EnableCommand)
	BEGIN
		IF (rising_edge(CLK)) THEN
			case EnableCommand(7 downto 0) is
				when "00111010" =>
					Counter<=Counter+1;
					CommandReset<='1';
					ControlBus(1 downto 0)<="10";
					case Counter is
						when "00000000" => null;
						when "00000001" =>
							ControlBus(7 downto 6)<="10";  --AddrReg<=InstructionsCounter
							Memory_RW<='1';
						when "00000010" =>
							ControlBus(1 downto 0)<="00";  --Accumulator<=InternalDataBus
							ControlBus(7 downto 6)<="00";  --InstructionsCounter<=InstructionsCounter+1
						when others => 
							ControlBus<=(others => 'Z');
							CommandReset<='Z';
							Counter<=(others => '0');
							Memory_RW<='Z';
					end case;
				when others => 
					ControlBus<=(others => 'Z');
					CommandReset<='Z';
					Counter<=(others => '0');
					Memory_RW<='Z';
			end case;
		END IF;		
	END PROCESS;
END MAIN;