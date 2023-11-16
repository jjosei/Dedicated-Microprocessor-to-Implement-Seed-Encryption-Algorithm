----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:27:02 10/19/2023 
-- Design Name: 
-- Module Name:    controlunit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity keygen_controlunit is port(
  inteq16 : in std_logic;
  i0nteq0 : in std_logic;
  RESET , CLOCK : in std_logic;
  muxsel2, loadK01, loadK23, write_in, countEN, rst, startENC: out std_logic);
end keygen_controlunit;

architecture Behavioral of keygen_controlunit is
   type state is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7);
	signal PS, NS : state;
	signal control : std_logic_vector(6 downto 0);

begin
   muxsel2 <= control(6);
	loadK01 <= control(5);
   loadK23 <= control(4);
	rst <= control(3);
	countEN <= control(2);
	write_in <= control(1);
	startENC <= control(0);
	
	sync : process(CLOCK,RESET,NS)
	 BEGIN
	  IF (RESET = '1') THEN
	    PS <= ST0;
	  ELSIF(RISING_EDGE(CLOCK))THEN
       PS <= NS;	  
	  END IF;
   END PROCESS;


   combinatorial : process(PS, i0nteq0, inteq16)	
	  begin
	   case(PS)is
		  when ST0 =>
	       control <= "0001010";
			 NS <= ST1;
			
        when ST1 =>
          control <= "0110010";
          NS <= ST2;

        when ST2 =>
		    control <= "0000000";
          if(inteq16 = '1') then
             NS <= ST3;
          else
             NS <= ST7;
          end if;

        when ST3 =>
          control <= "0000010";		  
	       NS <= ST4;
	 
	     when ST4 =>
		    control <= "0000000";
          if(i0nteq0 = '1') then
             NS <= ST6;
          else
             NS <= ST5;
          end if;  

        when ST5 =>          
          control <= "1100110";
			 NS <= ST2;
			 
		  when ST6 =>
          control <= "1010110";   
          NS <= ST2;
			 
		  when ST7 =>
          control <= "0000001";
          NS <= ST7;
			 

        when OTHERS =>
			 control <= "0000000";
					NS <= ST0;			 
		end case; 
    end process;		 
end Behavioral;


