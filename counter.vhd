----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:17:40 10/18/2023 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity kg_counter is port(
   clock : in std_logic;
	countEN : in std_logic;
	reset : in std_logic;
	output : out std_logic_vector(4 downto 0));
end kg_counter;

--architecture Behavioral of icounter is
--   signal counting : std_logic_vector(4 downto 0);
--begin
--   process(clock,reset,preset)
--	  begin
--	   if (reset ='1') then 
--		   counting <= "00000";
--		elsif (preset = '1') then
--         counting <= "01111";		
--	   elsif(rising_edge(clock)) then
--		  if(countEN = '1' and EncDec = '1') then
--		    counting <= counting  + 1;
--		  elsif(EncDec = '0') then
--          counting <= counting - 1;
--        end if;
--      end if;		  
--		  
--		  		
--   end process;
--  output <= counting;	
--			  
--end Behavioral;

architecture Behavioral of kg_counter is
   signal counting : std_logic_vector(4 downto 0);
begin
   process(clock,reset)
	  begin
	   if (reset ='1') then 
		   counting <= "00000";	
	   elsif(rising_edge(clock)) then
		  if(countEN = '1') then
		    counting <= counting  + 1;
  		  end if;
      end if;		  
		  
		  		
   end process;
  output <= counting;	
			  
end Behavioral;
