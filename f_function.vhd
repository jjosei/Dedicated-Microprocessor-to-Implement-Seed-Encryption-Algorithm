----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:19 10/13/2023 
-- Design Name: 
-- Module Name:    f_function - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity f_function is port(
  input : in std_logic_vector(63 downto 0);
  Ki : in std_logic_vector(63 downto 0);
  output : out std_logic_vector(63 downto 0));
end f_function;

architecture Behavioral of f_function is

	 
	component g_function is port(
	  input : in std_logic_vector(31 downto 0);
	  output : out std_logic_vector(31 downto 0));
	end component g_function;
	
	
	component adder32bit is
    Port ( A : in std_logic_vector(31 downto 0);  
           B : in std_logic_vector(31 downto 0);  
           Y : out std_logic_vector(31 downto 0)  
          );
   end component adder32bit;
	

   signal C,D : std_logic_vector(31 downto 0);
	signal i1,i2,i3,i4,i5,i6,i7,i8,i9 : std_logic_vector(31 downto 0);
	signal Ki0 , Ki1 : std_logic_vector(31 downto 0);
begin

  G1 : g_function port map(input=> i3,
                           output => i4);
																		
  G2 : g_function port map(input=> i5,
                           output => i6);	

  G3 : g_function port map(input=> i7,
                           output => i9);	

  A1 : adder32bit port map(A =>i1,
                           B => i4,
                           Y => i5);
									
  A2 : adder32bit port map(A =>i4,
                           B => i6,
                           Y => i7);

  A3 : adder32bit port map(A =>i6,
                           B => i9,
                           Y => i8);									
									
  C <= input(63 downto 32);
  D <= input(31 downto 0);
  
  Ki0 <= Ki(63 downto 32);
  Ki1 <= Ki(31 downto 0);

  i1 <= C xor Ki0;
  i2 <= D xor Ki1;
  i3 <= i1 xor i2;


  output <= i8 & i9;
end Behavioral;

