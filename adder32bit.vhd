----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:50:42 10/15/2023 
-- Design Name: 
-- Module Name:    adder32bit - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder32bit is
    Port ( A : in std_logic_vector(31 downto 0);  
           B : in std_logic_vector(31 downto 0);  
           Y : out std_logic_vector(31 downto 0)  
          );
end adder32bit;

architecture Behavioral of adder32bit is
begin
    process (A, B)
    begin
        Y <= A + B;
    end process;
end Behavioral;

