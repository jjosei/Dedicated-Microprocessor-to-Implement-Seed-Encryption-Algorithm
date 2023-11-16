----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:03:44 10/13/2023 
-- Design Name: 
-- Module Name:    regL - Behavioral 
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
use IEEE.std_logic_1164.all;

entity reg is
  port ( D : in std_logic_vector(63 downto 0);
         reset : in std_logic;
         load : in std_logic;
         clk : in std_logic; 
         Q : out std_logic_vector(63 downto 0));
end reg;


architecture my_reg of reg is
 begin
  dff: process(clk, load,reset)
   begin
	if (reset = '1')then
	   Q <= (others => '0');
    elsif (rising_edge(clk)) then
	  if(load = '1') then
      Q <= D;
	  end if;
   end if;
  end process dff;
end my_reg;