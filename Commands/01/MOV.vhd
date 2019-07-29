library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY MOV IS
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	DDD: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	ControlBus: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
);
END MOV;
-------------------------------------------------------
ARCHITECTURE MAIN OF MOV IS
-------------------------------------------------------
signal Counter: unsigned(7 downto 0);
-------------------------------------------------------
BEGIN

PROCESS(CLK, Counter, EnableCommand, SSS, DDD)
	BEGIN
		IF (rising_edge(CLK)) THEN
			case EnableCommand(7 downto 6) is
				when "01" =>
					Counter<=Counter+1;
					CommandReset<='1';
					case Counter is
						when "00000000" =>
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
						when "00000001" => ControlBus(0 downto 0)<="0";         --РА<-SSS
						when "00000010" =>
							case DDD is
							-------------------------------------------------------
								when "000" => ControlBus(19 downto 14)<="000001"; --Рег. B<-ШД
							-------------------------------------------------------
								when "001" => ControlBus(19 downto 14)<="010001"; --Рег. C<-ШД
							-------------------------------------------------------
								when "010" => ControlBus(19 downto 14)<="000010"; --Рег. D<-ШД
							-------------------------------------------------------
								when "011" => ControlBus(19 downto 14)<="010010"; --Рег. E<-ШД
							-------------------------------------------------------
								when "100" => ControlBus(19 downto 14)<="000011"; --Рег. H<-ШД
							-------------------------------------------------------
								when "101" => ControlBus(19 downto 14)<="010011"; --Рег. L<-ШД
							-------------------------------------------------------
								when "110" => ControlBus(19 downto 14)<="100011"; --M(HL)<-ШД
												  ControlBus(5 downto 5)<="0";        --Memory READ from InternalBus
							-------------------------------------------------------
								when "111" => ControlBus(0 downto 0)<="0";        --РА<-ШД
							-------------------------------------------------------
								when others => null;
							
						when "00000011" => ControlBus(0 downto 0)<="1";         --ШД<-РА
						when others =>
							ControlBus<=(others => 'Z');
							CommandReset<='0'; 
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