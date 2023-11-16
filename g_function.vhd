----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:40:27 10/12/2023 
-- Design Name: 
-- Module Name:    g_function - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity g_function is port(
  input : in std_logic_vector(31 downto 0);
  output : out std_logic_vector(31 downto 0));
end g_function;

architecture Behavioral of g_function is

  COMPONENT s1ROM is PORT (
	  address : in std_logic_vector (7 downto 0) ;
	  data_out : out std_logic_vector (7 downto 0))  ;
  end COMPONENT s1ROM;
  
  COMPONENT s2ROM is PORT (
	  address : in std_logic_vector (7 downto 0) ;
	  data_out : out std_logic_vector (7 downto 0))  ;
  end COMPONENT s2ROM;
  
  signal X1, X2, X3, X4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal Y1, Y2, Y3, Y4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal Z1, Z2, Z3, Z4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  
  constant c1 : std_logic_vector(7 downto 0) := x"FC";
  constant c2 : std_logic_vector(7 downto 0) := x"F3";
  constant c3 : std_logic_vector(7 downto 0) := x"CF";
  constant c4 : std_logic_vector(7 downto 0) := x"3F";

begin
	
	
	S1a : s1ROM PORT MAP(address=>X1,
	                     data_out=>Z1);
								
	S2a : s2ROM PORT MAP(address=>X2,
							   data_out=>Z2);
								
   S1b : s1ROM PORT MAP(address=>X3,
	                     data_out=>Z3);	

   S2b : s2ROM PORT MAP(address=>X4,
	                     data_out=>Z4);		
								

   X4 <= input(31 downto 24);
   X3 <= input(23 downto 16);
   X2 <= input(15 downto 8);
   X1 <= input(7 downto 0);
	 
   Y1 <= (Z1 AND c1) XOR (Z2 AND c2) XOR (Z3 AND c3) XOR (Z4 AND c4);   Y2 <= (Z1 AND c2) XOR (Z2 AND c3) XOR (Z3 AND c4) XOR (Z4 AND c1);   Y3 <= (Z1 AND c3) XOR (Z2 AND c4) XOR (Z3 AND c1) XOR (Z4 AND c2);   Y4 <= (Z1 AND c4) XOR (Z2 AND c1) XOR (Z3 AND c2) XOR (Z4 AND c3);
									

   output <= Y4 & Y3 & Y2 & Y1;								

end Behavioral;

