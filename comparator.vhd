----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:43:26 10/27/2023 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is port(
  count : in std_logic_vector(4 downto 0);
  i0nteq0 : out std_logic;
  inteq16 : out std_logic);
end comparator;

architecture Behavioral of comparator is
  

begin
  process(count)
   begin

	 if(count = "10000")then
	   inteq16 <= '0';
	 else
      inteq16 <= '1';
    end if;	
	 

    if(count(0) = '1')then
	   i0nteq0 <= '1';
	 else
      i0nteq0 <= '0';
    end if;		 



  end process;
end Behavioral;
