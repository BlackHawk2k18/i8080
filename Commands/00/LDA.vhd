library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY LDA IS
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
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
					case Counter is
						when "00000000" => 
							ControlBus(19 downto 14)<="110101"; --Increment counter
						when "00000001" =>
							ControlBus(5 downto 5)<="1";        --Memory WRITE to InternalBus
							ControlBus(19 downto 14)<="100101"; --Write counter to ADDRESS BUS
						when "00000010" =>
							ControlBus(19 downto 14)<="010011"; --Write InternalBUS to "L"
							ControlBus(5 downto 5)<="Z";        --Memory HOLD
							
							
						when "00000011" =>
							ControlBus(19 downto 14)<="110101"; --Increment counter
						when "00000100" => 
							ControlBus(5 downto 5)<="1";        --Memory WRITE to InternalBus
							ControlBus(19 downto 14)<="100101"; --Write counter to ADDRESS BUS	
						when "00000101" =>
							ControlBus(19 downto 14)<="000011"; --Write InternalBUS to "H"
							ControlBus(5 downto 5)<="Z";        --Memory HOLD
								
								
						when "00000110" =>
							ControlBus(5 downto 5)<="1";        --Memory WRITE to InternalBus
							ControlBus(19 downto 14)<="100011"; --Write "HL" to ADDRESS BUS
							ControlBus(0 downto 0)<="0";        --Accumulator READ from InternalBus
						
						when "00000111" =>	
							ControlBus(19 downto 14)<="110101"; --Increment counter
							ControlBus(5 downto 5)<="Z";        --Memory HOLD
						when "00001000" =>
							ControlBus(0 downto 0)<="Z";        --Accumulator READ from InternalBus 
						when others =>
							ControlBus<=(others => 'Z');
							CommandReset<='Z';
							Counter<=(others => 'Z');
					end case;
				when others => 
					ControlBus<=(others => 'Z');
					CommandReset<='Z';
					Counter<=(others => '0');
			end case;
		END IF;		
	END PROCESS;

END MAIN;