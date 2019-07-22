library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY ADD IS
PORT(
	CLK: IN STD_LOGIC;
	Counter: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EnableCommand: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
	CommandReset: OUT STD_LOGIC;
	SSS: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	F1_command: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	F2_command: OUT STD_LOGIC;
	ControlBus: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END ADD;
-------------------------------------------------------
ARCHITECTURE MAIN OF ADD IS
-------------------------------------------------------
BEGIN
	PROCESS(CLK, Counter, EnableCommand)
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF(EnableCommand(7 downto 3)="10000") THEN
				IF(Counter="00000000") THEN 
					case SSS is
						when "000" => ControlBus(9 downto 8)<="00"; --ШД<-Рег. B
						when "001" => ControlBus(9 downto 8)<="10"; --ШД<-Рег. C
						when "010" => ControlBus(11 downto 10)<="00"; --ШД<-Рег. D
						when "011" => ControlBus(11 downto 10)<="10"; --ШД<-Рег. E
						when "100" => ControlBus(13 downto 12)<="00"; --ШД<-Рег. H
						when "101" => ControlBus(13 downto 12)<="10"; --ШД<-Рег. L
--						when "110" => ControlBus(13 downto 12)<="00"; --M(HL)
--						when "111" => ControlBus(13 downto 12)<="00"; --A
						when others => null;
					end case;		
				ELSIF(Counter="00000001") THEN
					ControlBus(3 downto 2)<="00"; --РЗА<-РА | БР<-ШД
			   ELSIF(Counter="00000010") THEN
					ControlBus(1 downto 0)<="00"; --РА<-ШД
					ControlBus(3 downto 2)<="11"; --АЛУ(А, B)<РЗА, БР
					ControlBus(17 downto 17)<="1"; --ШД<-АЛУ
					F1_command<="00000000";
					F2_command<='0';
			   ELSIF(Counter="00000101") THEN
					ControlBus<=(others => 'Z');
					F1_command<="ZZZZZZZZ";
					F2_command<='Z';
					CommandReset<='1';
				END IF;
			ELSE
				ControlBus<="ZZZZZZZZZZZZZZZZZZ";
				F1_command<="ZZZZZZZZ";
				F2_command<='Z';
				CommandReset<='Z';
			END IF;
		END IF;		
	END PROCESS;
END MAIN;