----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:24:39 10/12/2023 
-- Design Name: 
-- Module Name:    s2ROM - Behavioral 
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

entity s2ROM is PORT (
  address : in std_logic_vector (7 downto 0) ;
  data_out : out std_logic_vector (7 downto 0))  ;
end s2ROM;

architecture Behavioral of s2ROM is
   type ROMTYPE is array (0 to 255)  of std_logic_vector (7 downto 0 );
	constant ROM_CONTENTS: ROMTYPE := ( 
    x"38" ,  x"E8" ,  x"2D" ,  x"A6" ,  x"CF" ,  x"DE" ,  x"B3" ,  x"B8" ,  x"AF" ,  x"60" ,
	 x"55" ,  x"C7" ,  x"44" ,  x"6F" ,  x"6B" ,  x"5B" ,  x"C3" ,  x"62" ,  x"33" ,  x"B5" ,
	 x"29" ,  x"A0" ,  x"E2" ,  x"A7" ,  x"D3" ,  x"91" ,  x"11" ,  x"06" ,  x"1C" ,  x"BC" ,
	 x"36" ,  x"4B" ,  x"EF" ,  x"88" ,  x"6C" ,  x"A8" ,  x"17" ,  x"C4" ,  x"16" ,  x"F4" ,
  	 x"C2" ,  x"45" ,  x"E1" ,  x"D6" ,  x"3F" ,  x"3D" ,  x"8E" ,  x"98" ,  x"28" ,  x"4E" ,
	 x"F6" ,  x"3E" ,  x"A5" ,  x"F9" ,  x"0D" ,  x"DF" ,  x"D8" ,  x"2B" ,  x"66" ,  x"7A" ,
	 x"27" ,  x"2F" ,  x"F1" ,  x"72" ,  x"42" ,  x"D4" ,  x"41" ,  x"C0" ,  x"73" ,  x"67" ,
	 x"AC" ,  x"8B" ,  x"F7" ,  x"AD" ,  x"80" ,  x"1F" ,  x"CA" ,  x"2C" ,  x"AA" ,  x"34" ,
	 x"D2" ,  x"0B" ,  x"EE" ,  x"E9" ,  x"5D" ,  x"94" ,  x"18" ,  x"F8" ,  x"57" ,  x"AE" ,
	 x"08" ,  x"C5" ,  x"13" ,  x"CD" ,  x"86" ,  x"B9" ,  x"FF" ,  x"7D" ,  x"C1" ,  x"31" ,
	 x"F5" ,  x"8A" ,  x"6A" ,  x"B1" ,  x"D1" ,  x"20" ,  x"D7" ,  x"02" ,  x"22" ,  x"04" ,
	 x"68" ,  x"71" ,  x"07" ,  x"DB" ,  x"9D" ,  x"99" ,  x"61" ,  x"BE" ,  x"E6" ,  x"59" ,
	 x"DD" ,  x"51" ,  x"90" ,  x"DC" ,  x"9A" ,  x"A3" ,  x"AB" ,  x"D0" ,  x"81" ,  x"0F" ,
	 x"47" ,  x"1A" ,  x"E3" ,  x"EC" ,  x"8D" ,  x"BF" ,  x"96" ,  x"7B" ,  x"5C" ,  x"A2" ,
	 x"A1" ,  x"63" ,  x"23" ,  x"4D" ,  x"C8" ,  x"9E" ,  x"9C" ,  x"3A" ,  x"0C" ,  x"2E" , 
	 x"BA" ,  x"6E" ,  x"9F" ,  x"5A" ,  x"F2" ,  x"92" ,  x"F3" ,  x"49" ,  x"78" ,  x"CC" ,
	 x"15" ,  x"FB" ,  x"70" ,  x"75" ,  x"7F" ,  x"35" ,  x"10" ,  x"03" ,  x"64" ,  x"6D" ,
	 x"C6" ,  x"74" ,  x"D5" ,  x"B4" ,  x"EA" ,  x"09" ,  x"76" ,  x"19" ,  x"FE" ,  x"40" ,
	 x"12" ,  x"E0" ,  x"BD" ,  x"05" ,  x"FA" ,  x"01" ,  x"F0" ,  x"2A" ,  x"5E" ,  x"A9" ,
	 x"56" ,  x"43" ,  x"85" ,  x"14" ,  x"89" ,  x"9B" ,  x"B0" ,  x"E5" ,  x"48" ,  x"79" ,
	 x"97" ,  x"FC" ,  x"1E" ,  x"82" ,  x"21" ,  x"8C" ,  x"1B" ,  x"5F" ,  x"77" ,  x"54" ,
	 x"B2" ,  x"1D" ,  x"25" ,  x"4F" ,  x"00" ,  x"46" ,  x"ED" ,  x"58" ,  x"52" ,  x"EB" ,	 
	 x"7E" ,  x"DA" ,  x"C9" ,  x"FD" ,  x"30" ,  x"95" ,  x"65" ,  x"3C" ,  x"B6" ,  x"E4" ,
	 x"BB" ,  x"7C" ,  x"0E" ,  x"50" ,  x"39" ,  x"26" ,  x"32" ,  x"84" ,  x"69" ,  x"93" ,
	 x"37" ,  x"E7" ,  x"24" ,  x"A4" ,  x"CB" ,  x"53" ,  x"0A" ,  x"87" ,  x"D9" ,  x"4C" ,
	 X"83" ,  X"8F" ,  X"CE" ,  X"3B" ,  X"4A" ,  X"B7" 
     );
begin

 process (address )
    begin
        data_out <= ROM_CONTENTS (conv_integer (unsigned (address))  ) ;
    end process;

end Behavioral;

