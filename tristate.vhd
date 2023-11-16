----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:55:15 10/27/2023 
-- Design Name: 
-- Module Name:    tristate - Behavioral 
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


entity tristate is
    Port (
        a    : in  STD_LOGIC_vector(127 downto 0);
        s    : in  STD_LOGIC;   
        b    : out STD_LOGIC_vector(127 downto 0)
    );
end tristate;

architecture Behavioral of tristate is
   
begin
    process (s,a)
    begin
        if s ='1' then 
            b <= a;   
        else
            b <= (OTHERS => 'Z');
        end if;
    end process;
	 
  
end Behavioral;

