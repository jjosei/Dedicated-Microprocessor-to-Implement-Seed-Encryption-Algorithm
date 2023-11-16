----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:11 10/12/2023 
-- Design Name: 
-- Module Name:    s1ROM - Behavioral 
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
-- any  Xilin X primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity s1ROM is PORT (
  address : in std_logic_vector (7 downto 0) ;
  data_out : out std_logic_vector (7 downto 0))  ;
end s1ROM;

architecture Behavioral of s1ROM is
   type ROMTYPE is array (0 to 255)  of std_logic_vector (7 downto 0 );
	constant ROM_CONTENTS: ROMTYPE := ( 
    X"A9" ,  X"85" ,  X"D6" ,  X"D3" ,  X"54" ,  X"1D" ,  X"AC" ,  X"25" ,  X"5D" ,  X"43" ,
	 X"18" ,  X"1E" ,  X"51" ,  X"FC" ,  X"CA" ,  X"63" ,  X"28" ,  X"44" ,  X"20" ,  X"9D" ,
	 X"E0" ,  X"E2" ,  X"C8" ,  X"17" ,  X"A5" ,  X"8F" ,  X"03" ,  X"7B" ,  X"BB" ,  X"13" ,
	 X"D2" ,  X"EE" ,  X"70" ,  X"8C" ,  X"3F" ,  X"A8" ,  X"32" ,  X"DD" ,  X"F6" ,  X"74" ,
  	 X"EC" ,  X"95" ,  X"0B" ,  X"57" ,  X"5C" ,  X"5B" ,  X"BD" ,  X"01" ,  X"24" ,  X"1C" ,
	 X"73" ,  X"98" ,  X"10" ,  X"CC" ,  X"F2" ,  X"D9" ,  X"2C" ,  X"E7" ,  X"72" ,  X"83" ,
	 X"9B" ,  X"D1" ,  X"86" ,  X"C9" ,  X"60" ,  X"50" ,  X"A3" ,  X"EB" ,  X"0D" ,  X"B6" ,
	 X"9E" ,  X"4F" ,  X"B7" ,  X"5A" ,  X"C6" ,  X"78" ,  X"A6" ,  X"12" ,  X"AF" ,  X"D5" ,
	 X"61" ,  X"C3" ,  X"B4" ,  X"41" ,  X"52" ,  X"7D" ,  X"8D" ,  X"08" ,  X"1F" ,  X"99" ,
	 X"00" ,  X"19" ,  X"04" ,  X"53" ,  X"F7" ,  X"E1" ,  X"FD" ,  X"76" ,  X"2F" ,  X"27" ,
	 X"B0" ,  X"8B" ,  X"0E" ,  X"AB" ,  X"A2" ,  X"6E" ,  X"93" ,  X"4D" ,  X"69" ,  X"7C" ,
	 X"09" ,  X"0A" ,  X"BF" ,  X"EF" ,  X"F3" ,  X"C5" ,  X"87" ,  X"14" ,  X"FE" ,  X"64" ,
	 X"DE" ,  X"2E" ,  X"4B" ,  X"1A" ,  X"06" ,  X"21" ,  X"6B" ,  X"66" ,  X"02" ,  X"F5" ,
	 X"92" ,  X"8A" ,  X"0C" ,  X"B3" ,  X"7E" ,  X"D0" ,  X"7A" ,  X"47" ,  X"96" ,  X"E5" ,
	 X"26" ,  X"80" ,  X"AD" ,  X"DF" ,  X"A1" ,  X"30" ,  X"37" ,  X"AE" ,  X"36" ,  X"15" ,
	 X"22" ,  X"38" ,  X"F4" ,  X"A7" ,  X"45" ,  X"4C" ,  X"81" ,  X"E9" ,  X"84" ,  X"97" ,
	 X"35" ,  X"CB" ,  X"CE" ,  X"3C" ,  X"71" ,  X"11" ,  X"C7" ,  X"89" ,  X"75" ,  X"FB" ,
	 X"DA" ,  X"F8" ,  X"94" ,  X"59" ,  X"82" ,  X"C4" ,  X"FF" ,  X"49" ,  X"39" ,  X"67" ,
	 X"C0" ,  X"CF" ,  X"D7" ,  X"B8" ,  X"0F" ,  X"8E" ,  X"42" ,  X"23" ,  X"91" ,  X"6C" ,
	 X"DB" ,  X"A4" ,  X"34" ,  X"F1" ,  X"48" ,  X"C2" ,  X"6F" ,  X"3D" ,  X"2D" ,  X"40" ,
	 X"BE" ,  X"3E" ,  X"BC" ,  X"C1" ,  X"AA" ,  X"BA" ,  X"4E" ,  X"55" ,  X"3B" ,  X"DC" ,
	 X"68" ,  X"7F" ,  X"9C" ,  X"D8" ,  X"4A" ,  X"56" ,  X"77" ,  X"A0" ,  X"ED" ,  X"46" ,
	 X"B5" ,  X"2B" ,  X"65" ,  X"FA" ,  X"E3" ,  X"B9" ,  X"B1" ,  X"9F" ,  X"5E" ,  X"F9" ,
	 X"E6" ,  X"B2" ,  X"31" ,  X"EA" ,  X"6D" ,  X"5F" ,  X"E4" ,  X"F0" ,  X"CD" ,  X"88" ,
	 X"16" ,  X"3A" ,  X"58" ,  X"D4" ,  X"62" ,  X"29" ,  X"07" ,  X"33" ,  X"E8" ,  X"1B" ,
	 X"05" ,  X"79" ,  X"90" ,  X"6A" ,  X"2A" ,  X"9A" 
     );
begin

 process (address )
    begin
        data_out <= ROM_CONTENTS (conv_integer (unsigned (address))  ) ;
    end process;

end Behavioral;

