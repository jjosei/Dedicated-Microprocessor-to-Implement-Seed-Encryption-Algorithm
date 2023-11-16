----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:41 10/31/2023 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is port(
  INPUT_TEXT : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
  INPUT_KEY : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
  ENC_DEC : IN STD_LOGIC;
  RESET : IN STD_LOGIC;
  CLOCK : IN STD_LOGIC;
  OUTPUT_TEXT : OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
end top_level;

architecture Behavioral of top_level is


	component datapath is PORT(
	  INPUT : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
	  RESET : IN STD_LOGIC;
	  loadT : IN STD_LOGIC;
	  CLOCK : IN STD_LOGIC;
	  ENC_DEC : IN STD_LOGIC;
	  muxsel1 : IN STD_LOGIC;
	  loadPP : IN STD_LOGIC;
	  outEN : IN STD_LOGIC;
	  OUTPUT : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
	------below are the control signals for the key expansion------  
	  KiIN : in std_logic_vector(127 downto 0);
	  muxsel2 :in std_logic;
	  loadK01, loadK23 :in std_logic;
	  write_in : in std_logic;
	  presetED :in std_logic;
	  rstED, rstKG : in std_logic;
	  countENED, countENKG : in std_logic;
	  inteq16 : out std_logic;
	  inteq15 : out std_logic;
	  inteq0ED : out std_logic;
	  i0nteq0 : out std_logic);
	end component datapath;


	component keygen_controlunit is port(
	  inteq16 : in std_logic;
	  i0nteq0 : in std_logic;
	  RESET , CLOCK : in std_logic;
	  muxsel2, loadK01, loadK23, write_in, countEN, rst, startENC : out std_logic);
	end component keygen_controlunit;


	component encryption_controlunit is port(	
	  inteq15 : in std_logic;
	  inteq0ED : in std_logic;
	  startENC : in std_logic;
	  ENC_DEC : in std_logic;
     RESET , CLOCK : in std_logic;
	  muxsel1, loadT, countEN, rst, preset, outEN, loadPP : out std_logic);  
	end component encryption_controlunit;



   SIGNAL muxsel2,loadK01,loadK23,write_in,countENED,rstED,presetED,countENKG,rstKG,startENC ,muxsel1,loadT,loadPP,outEN,inteq16,inteq15,inteq0ED,i0nteq0  : std_logic;
begin

   unit1 : datapath port map(
     INPUT => INPUT_TEXT,
	  RESET => RESET,
	  loadT => loadT,
	  CLOCK => CLOCK,
	  muxsel1 => muxsel1,
	  loadPP => loadPP,
	  outEN => outEN,
	  OUTPUT => OUTPUT_TEXT,
	  KiIN => INPUT_KEY,
	  muxsel2 => muxsel2,
	  loadK01 => loadK01, 
	  loadK23 => loadK23,
	  write_in => write_in,
	  presetED => presetED,
     ENC_DEC => ENC_DEC, 
	  rstED => rstED,
	  countENED => countENED,
	  rstKG => rstKG,
	  countENKG => countENKG,
	  inteq16 => inteq16,
	  inteq15 => inteq15,
	  inteq0ED => inteq0ED,
	  i0nteq0 => i0nteq0);
	  
	  
	unit2 : keygen_controlunit port map(    
	  inteq16 => inteq16,
	  i0nteq0 => i0nteq0,
	  RESET => RESET,
	  CLOCK => CLOCK,
	  muxsel2 => muxsel2,
	  loadK01 => loadK01,
	  loadK23 => loadK23,
	  write_in => write_in,
	  countEN => countENKG,
	  rst => rstKG,
	  startENC => startENC);

   unit3 : encryption_controlunit port map(
	  inteq15 => inteq15,
	  inteq0ED => inteq0ED,
	  startENC => startENC,
	  ENC_DEC => ENC_DEC,
	  RESET => RESET,
	  CLOCK => CLOCK,
	  muxsel1 => muxsel1,
	  loadT => loadT,
	  countEN => countENED, 
	  rst => rstED,
	  preset => presetED,
	  outEN => outEN,
	  loadPP => loadPP);
	


	  
end Behavioral;

