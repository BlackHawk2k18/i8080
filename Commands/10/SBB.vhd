library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY SBB IS
PORT(
	CLK: IN STD_LOGIC;
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	Memory_RW: OUT STD_LOGIC
);
END SBB;
-------------------------------------------------------
ARCHITECTURE MAIN OF SBB IS
-------------------------------------------------------
signal Counter: unsigned(7 downto 0);
-------------------------------------------------------
BEGIN
	PROCESS(CLK, Counter, EnableCommand, SSS)
	BEGIN
		IF (rising_edge(CLK)) THEN
			case EnableCommand(7 downto 3) is
				when "10011" =>
					Counter<=Counter+1;
					CommandReset<='1';
					case Counter is
						when "00000000" =>
							case SSS is
							-------------------------------------------------------
								when "000" => ControlBus(9 downto 8)<="00"; ControlBus(17 downto 17)<="0";  --ШД<-Рег. B
							-------------------------------------------------------
								when "001" => ControlBus(11 downto 10)<="00"; ControlBus(17 downto 17)<="0"; --ШД<-Рег. C
							-------------------------------------------------------
								when "010" => ControlBus(9 downto 8)<="10"; ControlBus(17 downto 17)<="0";   --ШД<-Рег. D
							-------------------------------------------------------
								when "011" => ControlBus(11 downto 10)<="10"; ControlBus(17 downto 17)<="0"; --ШД<-Рег. E
							-------------------------------------------------------
								when "100" => ControlBus(13 downto 12)<="00"; ControlBus(17 downto 17)<="0"; --ШД<-Рег. H
							-------------------------------------------------------
								when "101" => ControlBus(15 downto 14)<="00"; ControlBus(17 downto 17)<="0"; --ШД<-Рег. L
							-------------------------------------------------------
								when "110" => ControlBus(15 downto 12)<="0000"; ControlBus(1 downto 0)<="10"; --ШД<-M(HL)
												  Memory_RW<='1';
							-------------------------------------------------------
								when "111" => ControlBus(1 downto 0)<="01";   --ШД<-РА
							-------------------------------------------------------
								when others => null;
							end case;
						when "00000001" =>  
							ControlBus(3 downto 2)<="00"; --РЗА<-РА | БР<-ШД
							ControlBus(15 downto 8)<="ZZZZZZZZ";
							Memory_RW<='Z';
						when "00000010" =>
							ControlBus(3 downto 0)<="1100"; --АЛУ(А, B)<-(РЗА, БР)
							ControlBus(5 downto 4)<="11";
							F1_command<="00000011";
							F2_command<='1';
						when "00000011" =>
							ControlBus(17 downto 17)<="1";  --ШД<-АЛУ
						when "00000100" => null;
						when others =>
							ControlBus<=(others => 'Z');
							F1_command<=(others => 'Z');
							F2_command<='Z';
							CommandReset<='Z';
							Counter<=(others => '0');
							Memory_RW<='Z';
					end case;
				when others => 
					ControlBus<=(others => 'Z');
					F1_command<=(others => 'Z');
					F2_command<='Z';
					CommandReset<='Z';
					Counter<=(others => '0');
					Memory_RW<='Z';
			end case;
		END IF;		
	END PROCESS;
END MAIN;