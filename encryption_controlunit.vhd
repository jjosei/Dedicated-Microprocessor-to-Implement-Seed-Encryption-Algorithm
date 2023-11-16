----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:10 10/31/2023 
-- Design Name: 
-- Module Name:    encryption_controlunit - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encryption_controlunit is port(	
  inteq15 : in std_logic;
  inteq0ED : in std_logic;
  startENC : in std_logic;
  ENC_DEC : in std_logic;
  RESET , CLOCK : in std_logic;
  muxsel1, loadT, countEN, rst, preset, outEN, loadPP : out std_logic);  
end encryption_controlunit;
  
architecture Behavioral of encryption_controlunit is
  type state is (ST0,ST1,ST2,ST3,ST4,ST5,ST6,ST7);
  signal PS,NS : state;
  signal control : std_logic_vector(6 downto 0);
begin
  muxsel1 <= control(6);
  loadT <= control(5);
  rst <= control(4);
  preset <= control(3);
  countEN <= control(2); 
  loadPP <= control(1);
  outEN <= control(0);
  
  
  seq : process(RESET, CLOCK,NS)
  begin
   if(RESET = '1') THEN
	  PS <= ST0;
	ELSIF(RISING_EDGE(CLOCK))THEN
     PS <= NS;
   END IF;
  END PROCESS;


  combina : process(inteq15, inteq0ED, startENC, ENC_DEC, PS)
  begin
  case PS is
    when ST0 =>
	   control <= "0110000";
	   if(startENC = '1' and ENC_DEC = '1') then
		  NS <= ST1;
		elsif(startENC = '1' and ENC_DEC = '0') then
		  NS <= ST7;
		else  
        NS <= ST0;
      end if;		  
  
    when ST1 =>
	   control <= "1000000";
		if(inteq15 = '1')then
		  NS <= ST2;
		else
        NS <= ST3;
      end if;

    when ST2 =>
      control <= "1100100";
      NS <= ST1;

    when ST3 =>
		control <= "1100110";
		NS <= ST4;
		
	 when ST4 =>	
		control <= "1000001";
		NS <= ST4;
		
	 when ST5 =>
      control <= "1000000";	 
		if(inteq0ED = '1')then
		  NS <= ST6;
		else
        NS <= ST3;
      end if;
		
    when ST6 =>
      control <= "1100100";
      NS <= ST5;		
		
	 when ST7 =>
      control <= "1001000";
      NS <= ST5;		
		
    when OTHERS =>
	   control <= "0000000";
		NS <= ST0;			 
		end case; 
    end process;		 	
	 
end Behavioral;

