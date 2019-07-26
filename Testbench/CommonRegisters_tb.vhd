library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Testbench IS
END;
-------------------------------------------------------
ARCHITECTURE MAIN OF Testbench IS
signal CLK: STD_LOGIC;
signal RESET: STD_LOGIC;
signal InternalDataBus: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ToAddressBus: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal ControlBus: STD_LOGIC_VECTOR(5 DOWNTO 0);
----------------------------------
COMPONENT CommonRegisters
PORT(
	CLK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	InternalDataBus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ToAddressBus: OUT STD_LOGIC_VECTOR (15 DOWNTO 0); 
	ControlBus: IN STD_LOGIC_VECTOR(5 DOWNTO 0)
);
END COMPONENT CommonRegisters;
----------------------------------
BEGIN
	
	U0: CommonRegisters PORT MAP (CLK, RESET, InternalDataBus, ToAddressBus, ControlBus);
	
	process begin
		InternalDataBus<=(others => 'Z');
		ControlBus<=(others => 'Z');
		ToAddressBus<=(others => 'Z');
		
		RESET<='0'; wait for 10 ns;
		RESET<='1'; wait for 10 ns;
		RESET<='0'; wait for 20 ns;
		
--		ControlBus(5 downto 0)<="110101"; wait for 20 ns; --Increment counter
--		ControlBus(5 downto 0)<="110101"; wait for 20 ns; --Increment counter
--		ControlBus(5 downto 0)<="110101"; wait for 20 ns; --Increment counter
--		ControlBus(5 downto 0)<="110101"; wait for 20 ns; --Increment counter
--		ControlBus(5 downto 0)<="111101"; wait for 20 ns; --Increment counter
--		ControlBus(5 downto 0)<="100101"; wait for 20 ns; --Write counter to BUS
--		InternalDataBus<="00000001";         
--		ControlBus(5 downto 0)<="000000"; wait for 20 ns; --WRITE TO W
--		InternalDataBus<="00000010";     
--		ControlBus(5 downto 0)<="010000"; wait for 20 ns; --WRITE TO Z	
--		InternalDataBus<="00000011";      
--		ControlBus(5 downto 0)<="000001"; wait for 20 ns; --WRITE TO B
--		InternalDataBus<="00000100";      
--		ControlBus(5 downto 0)<="010001"; wait for 20 ns; --WRITE TO C 
--		InternalDataBus<="00000101";      
--		ControlBus(5 downto 0)<="000010"; wait for 20 ns; --WRITE TO D
--		InternalDataBus<="00000111";     
--		ControlBus(5 downto 0)<="010010"; wait for 20 ns; --WRITE TO E
--		InternalDataBus<="00001000";      
--		ControlBus(5 downto 0)<="000011"; wait for 20 ns; --WRITE TO H
--		InternalDataBus<="00001001";     
--		ControlBus(5 downto 0)<="010011"; wait for 20 ns; --WRITE TO L
--		InternalDataBus<="00001010";    
--		ControlBus(5 downto 0)<="000100"; wait for 20 ns; --WRITE TO Stack_L 
--		InternalDataBus<="00001011";      
--		ControlBus(5 downto 0)<="010100"; wait for 20 ns; --WRITE TO Stack_H  		
--		InternalDataBus<=(others => 'Z');
		ControlBus<=(others => 'Z');
		wait;
	end process;
	
	process begin
		CLK<='1'; wait for 10 ns;
		CLK<='0'; wait for 10 ns;
	end process;
END MAIN;