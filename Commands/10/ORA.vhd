library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY ORA IS
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END ORA;
-------------------------------------------------------
ARCHITECTURE MAIN OF ORA IS
-------------------------------------------------------
signal Counter: unsigned(7 downto 0);
-------------------------------------------------------
BEGIN

	PROCESS(CLK, Counter, EnableCommand, SSS)
	BEGIN
		IF (rising_edge(CLK)) THEN
			case EnableCommand(7 downto 3) is
				when "10110" =>
					Counter<=Counter+1;
					CommandReset<='1';
					case Counter is
						when "00000000" =>
							F1_command<="00000100";
							F2_command<='0';
							case SSS is
							-------------------------------------------------------
								when "000" => ControlBus(19 downto 14)<="001001"; --ШД<-Рег. B
							-------------------------------------------------------
								when "001" => ControlBus(19 downto 14)<="011001"; --ШД<-Рег. C
							-------------------------------------------------------
								when "010" => ControlBus(19 downto 14)<="001010"; --ШД<-Рег. D
							-------------------------------------------------------
								when "011" => ControlBus(19 downto 14)<="011010"; --ШД<-Рег. E
							-------------------------------------------------------
								when "100" => ControlBus(19 downto 14)<="001011"; --ШД<-Рег. H
							-------------------------------------------------------
								when "101" => ControlBus(19 downto 14)<="011011"; --ШД<-Рег. L
							-------------------------------------------------------
								when "110" => ControlBus(19 downto 14)<="100011"; --ШД<-M(HL)
												  ControlBus(5 downto 5)<="1";        --Memory WRITE to InternalBus
							-------------------------------------------------------
								when "111" => ControlBus(0 downto 0)<="1";        --ШД<-РА
							-------------------------------------------------------
								when others => null;
							end case;
						when "00000001" => 
							ControlBus(1 downto 1)<="0"; --РЗА<-РА
							ControlBus(2 downto 2)<="0"; --БР<-ШД
							ControlBus(5 downto 5)<="Z";
						when "00000010" =>
							ControlBus(1 downto 1)<="1";        --АЛУ(А)<-РЗА
							ControlBus(2 downto 2)<="1";        --АЛУ(В)<-БР
							ControlBus(22 downto 20)<="001";    --ШД<-АЛУ
						when "00000011" => 
							ControlBus(19 downto 14)<="110101"; --Increment counter
							ControlBus(0 downto 0)<="0";        --Accumulator READ from InternalBus
							ControlBus(22 downto 20)<="ZZZ";    --ШД<-АЛУ
						when others =>
							ControlBus<=(others => 'Z');
							F1_command<=(others => 'Z');
							F2_command<='Z';
							CommandReset<='0'; 
							Counter<=(others => 'Z');
					end case;
				when others => 
					ControlBus<=(others => 'Z');
					F1_command<=(others => 'Z');
					F2_command<='Z';
					CommandReset<='Z';
					Counter<=(others => '0');
			end case;
		END IF;
	END PROCESS;
	
END MAIN;