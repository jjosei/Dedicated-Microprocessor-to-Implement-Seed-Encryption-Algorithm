----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:25:10 10/16/2023 
-- Design Name: 
-- Module Name:    circshift_left8 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circshift_left8 is port(
  input1 : in std_logic_vector(31 downto 0);
  input2 : in std_logic_vector(31 downto 0);
  output : out std_logic_vector(63 downto 0));
end circshift_left8;

architecture Behavioral of circshift_left8 is
   signal keykey1, keykey2  : std_logic_vector(63 downto 0);
begin

  keykey1 <= input1 & input2;
  keykey2 <= keykey1(55 downto 0) & keykey1(63 downto 56);
  
  output <= keykey2;


end Behavioral;

