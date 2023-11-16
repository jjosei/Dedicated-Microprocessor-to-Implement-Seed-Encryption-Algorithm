----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:48:00 10/16/2023 
-- Design Name: 
-- Module Name:    circshift_right8 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circshift_right8 is port(
  input1 : in std_logic_vector(31 downto 0);
  input2 : in std_logic_vector(31 downto 0);
  output : out std_logic_vector(63 downto 0));
end circshift_right8;

architecture Behavioral of circshift_right8 is
   signal keykey1, keykey2  : std_logic_vector(63 downto 0);
begin

  keykey1 <= input1 & input2;
  keykey2 <= keykey1(7 downto 0) & keykey1(63 downto 8);
  
  output <= keykey2;


end Behavioral;

