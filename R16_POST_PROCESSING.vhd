----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:08 10/27/2023 
-- Design Name: 
-- Module Name:    R16_POST_PROCESSING - Behavioral 
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

entity R16_POST_PROCESSING is port(
  loadPP, reset : in std_logic;
  L, R, K15 : in std_logic_vector(63 downto 0);
  clock : in std_logic;
  output : out std_logic_vector(127 downto 0));
end R16_POST_PROCESSING;



architecture Behavioral of R16_POST_PROCESSING is

component f_function is port(
  input : in std_logic_vector(63 downto 0);
  Ki : in std_logic_vector(63 downto 0);
  output : out std_logic_vector(63 downto 0));
end component f_function;


component reg is
  port ( D : in std_logic_vector(63 downto 0);
         reset : in std_logic;
         load : in std_logic;
         clk : in std_logic; 
         Q : out std_logic_vector(63 downto 0));
end component reg;

signal function_out, xor_calc, lastL, lastR : std_logic_vector(63 downto 0);

begin


   f : f_function port map(input => R,
	                        Ki => K15,
									output => function_out);
									
   registerL : reg port map(D => xor_calc,
                            reset => reset,
                            load => loadPP,
                            clk => clock,
                            Q => lastL);	
									 
   registerR : reg port map(D => R,
                            reset => reset,
                            load => loadPP,
                            clk => clock,
                            Q => lastR);										 

   xor_calc <= L xor function_out;
	
	output <= lastL & lastR;
end Behavioral;

