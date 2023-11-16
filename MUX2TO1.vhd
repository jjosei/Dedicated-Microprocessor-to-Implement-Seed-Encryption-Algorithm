----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:17:08 10/13/2023 
-- Design Name: 
-- Module Name:    MUX2TO1 - Behavioral 
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


entity MUX2TO1 is PORT(
  A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : IN STD_LOGIC;
  Y : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
end MUX2TO1;

architecture Behavioral of MUX2TO1 is
begin
  Y <= A WHEN SEL = '0' ELSE B;

end Behavioral;

