----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:38 10/31/2023 
-- Design Name: 
-- Module Name:    comparator2 - Behavioral 
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


entity comparator2 is port(
  count : in std_logic_vector(4 downto 0);
  EncDec : in std_logic;
  inteq15 : out std_logic;
  inteq0ED : out std_logic);

end comparator2;

architecture Behavioral of comparator2 is

begin
 process(count, EncDec)
   begin
	 if(EncDec = '1' and count = "01111")then
	   inteq15 <= '0';
	 else
      inteq15 <= '1';
    end if;	 

    if(EncDec = '0' and count = "00000")then
	   inteq0ED <= '0';
	 else
      inteq0ED <= '1';
    end if;	
  end process;

end Behavioral;




