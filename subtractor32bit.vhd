----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:49:12 10/15/2023 
-- Design Name: 
-- Module Name:    subtractor32bit - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity subtractor32bit is
    Port ( A : in std_logic_vector(31 downto 0);  
           B : in std_logic_vector(31 downto 0);  
           Y : out std_logic_vector(31 downto 0)  
          );
end subtractor32bit;

architecture Behavioral of subtractor32bit is
--  signal sub_out : std_logic_vector(31 downto 0);  
begin
    process (A, B)
    begin
--        sub_out <= A - B;
       Y <= A - B;
    end process;               
	 
--	 process(sub_out)
--	 begin
--	   if (sub_out(31) = '1') then
--		  Y <= sub_out + x"FFFFF";
--		else
--        Y <= sub_out;
--      end if;
--    end process;		
end Behavioral;


