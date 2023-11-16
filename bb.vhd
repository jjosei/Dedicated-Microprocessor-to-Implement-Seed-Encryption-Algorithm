----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:52 10/30/2023 
-- Design Name: 
-- Module Name:    bb - Behavioral 
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
----------------------------------------------------------------------------------library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity encryption_controlunit is port(
  inteq16 : in std_logic;
  inteq15 : in std_logic;
  inteq0 : in std_logic;
  i0nteq0 : in std_logic;
  RESET , CLOCK : in std_logic;
  muxsel2, loadK01, loadK23, write_in, countEN, rst, preset, startENC, EncDec : out std_logic);
end encryption_controlunit;

architecture Behavioral of encryption_controlunit is
   type state is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7);
	signal PS, NS : state;
	signal control : std_logic_vector(8 downto 0);

begin
   muxsel2 <= control(8);
	loadK01 <= control(7);
   loadK23 <= control(6);
	rst <= control(5);
   preset <= control(4);
	countEN <= control(3);
	EncDec <= control(2);
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
	       control <= "000100110";
			 NS <= ST1;
			
        when ST1 =>
          control <= "011000110";
          NS <= ST2;

        when ST2 =>
		    control <= "000000100";
          if(inteq16 = '1') then
             NS <= ST3;
          else
             NS <= ST7;
          end if;

        when ST3 =>
          control <= "000000110";		  
	       NS <= ST4;
	 
	     when ST4 =>
		    control <= "000000100";
          if(i0nteq0 = '1') then
             NS <= ST6;
          else
             NS <= ST5;
          end if;  

        when ST5 =>          
          control <= "110001110";
			 NS <= ST2;
			 
		  when ST6 =>
          control <= "101001110";   
          NS <= ST2;
			 
		  when ST7 =>
          control <= "000100101";
          NS <= ST7;

        when OTHERS =>
			 control <= "000000000";
					NS <= ST0;			 
		end case; 
    end process;		 
end Behavioral;

