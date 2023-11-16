----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:45:04 10/16/2023 
-- Design Name: 
-- Module Name:    keyRAM - Behavioral 
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

--LIBRARY IEEE;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all; -- Imports the standard textio package.
--use IEEE.STD_LOGIC_ARITH.ALL;
----  Defines a design entity, without any ports.
--entity keyRAM is PORT(
--	 input : in std_logic_vector(63 downto 0);
--	 address : in std_logic_vector(4 downto 0);
--	 write_in : in std_logic;
--	 clock : in std_logic;
--	 output : out std_logic_vector(63 downto 0));
--end keyRAM;
--
--architecture behaviour of keyRAM is
--   type ram is array(0 to 31) of std_logic_vector(63 downto 0);
--   signal RAM1 : ram;
--   
--begin
--    process(clock)
--    begin
--    if (rising_edge(clock)) then
--      if(write_in = '0') then
--        output <= RAM1(conv_integer(unsigned(address)));
--          elsif(write_in = '1') then
--        RAM1(conv_integer(unsigned(address))) <= input;
--      end if;
--    end if;    
--    end process;
--end behaviour;
--
--


LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- Imports the standard textio package.
use IEEE.STD_LOGIC_ARITH.ALL;
--  Defines a design entity, without any ports.
entity keyRAM is PORT(
	 input : in std_logic_vector(63 downto 0);
	 read_address : in std_logic_vector(4 downto 0);
	 write_address : in std_logic_vector(4 downto 0);
	 write_in : in std_logic;
	 clock : in std_logic;
	 read_data : out std_logic_vector(63 downto 0));
end keyRAM;

architecture behaviour of keyRAM is
   type ram is array(0 to 31) of std_logic_vector(63 downto 0);
   signal RAM1 : ram;
   
begin
    process(clock)
    begin
	 
	 
	 	 
    if (rising_edge(clock)) then   
      if(write_in = '1') then
        RAM1(conv_integer(unsigned(write_address))) <= input;
      end if;
		
    end if;    
    end process;
	 
	 read_data <= RAM1(conv_integer(unsigned(read_address)));
end behaviour;
