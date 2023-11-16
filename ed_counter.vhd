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

entity ed_counter is port(
   clock : in std_logic;
	countEN : in std_logic;
	ENC_DEC : IN STD_LOGIC;
	reset : in std_logic;
	preset : in std_logic;
	output : out std_logic_vector(4 downto 0));
end ed_counter;

--architecture Behavioral of ed_counter is
--   signal counting : std_logic_vector(4 downto 0);
--begin
--   process(clock,reset,preset,ENC_DEC)
--	  begin
--	   if (reset ='1') then 
--		   counting <= "00000";
--		elsif (preset = '1') then
--         counting <= "01111";		
--	   elsif(rising_edge(clock)) then
--		 if(ENC_DEC = '1') then
--		  if(countEN = '1' and EncDec = '1') then
--		    counting <= counting  + 1;
--		  end if;	 
--		 elsif(ENC_DEC = '0') then	 
--		  if(countEN = '1' and EncDec = '0') then
--          counting <= counting - 1;
--        end if;
--		 end if; 
--      end if;		  
--		  
--		  		
--   end process;
--  output <= counting;	
--			  
--end Behavioral;


architecture Behavioral of ed_counter is
   signal counting : std_logic_vector(4 downto 0);
begin
   process(clock,reset,ENC_DEC,preset)
	  begin
	   if (reset ='1') then 
		   counting <= "00000"; 
 		elsif (preset = '1') then
         counting <= "01111";        	
	   elsif(rising_edge(clock)) then
		 if(ENC_DEC = '1' and countEN = '1') then
		    counting <= counting  + 1;		  	 
		 elsif(ENC_DEC = '0' and countEN = '1') then
          counting <= counting - 1;
       end if;
	
      end if;		  
		  
		  		
   end process;
  output <= counting;	
			  
end Behavioral;


