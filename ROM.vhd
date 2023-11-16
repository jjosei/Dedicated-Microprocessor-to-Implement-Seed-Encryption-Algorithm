----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:33 10/12/2023 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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

entity constantROM is
    Port ( 
        address : in STD_LOGIC_VECTOR (4 downto 0);
        data_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end constantROM;

architecture Behavioral of constantROM is
    type ROM_ARRAY is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    constant ROM_CONTENTS: ROM_ARRAY := (
        0 => x"9E3779B9",  -- Address 0
        1 => x"3C6EF373",  -- Address 1
        2 => x"78DDE6E6",  -- Address 2
        3 => x"F1BBCDCC",  -- Address 3
        4 => x"E3779B99",  -- Address 4
        5 => x"C6EF3733",  -- Address 5
        6 => x"8DDE6E67",  -- Address 6
        7 => x"1BBCDCCF",  -- Address 7
        8 => x"3779B99E",  -- Address 8
        9 => x"6EF3733C",  -- Address 9
        10=> x"DDE6E678",  -- Address 10
        11=> x"BBCDCCF1",  -- Address 11
        12=> x"779B99E3",  -- Address 12
        13=> x"EF3733C6",  -- Address 13
        14=>x"DE6E678D",  -- Address 14
        15=>x"BCDCCF1B",   -- Address 15
		  OTHERS => x"00000000"
    );
begin
    process(address)
    begin
        data_out <= ROM_CONTENTS(conv_integer(unsigned(address)));
    end process;
end Behavioral;
