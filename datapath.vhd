----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:50:16 10/13/2023 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is PORT(
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
  presetED:in std_logic;
  rstED, rstKG : in std_logic;
  countENED, countENKG : in std_logic;
  inteq16 : out std_logic;
  inteq15 : out std_logic;
  inteq0ED : out std_logic;
  i0nteq0 : out std_logic);
end datapath;



architecture Behavioral of datapath is

	COMPONENT MUX2TO1 is PORT(
	  A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  sel : IN STD_LOGIC;
	  Y : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
	END COMPONENT MUX2TO1;
	
----------------------------------------------------------------------------------
	
	component reg is port ( 
         D : in std_logic_vector(63 downto 0);
         reset : in std_logic;
         load : in std_logic;
         clk : in std_logic; 
         Q : out std_logic_vector(63 downto 0));
   end component reg;
	
----------------------------------------------------------------------------------
	
	component f_function is port(
		  input : in std_logic_vector(63 downto 0);
		  Ki : in std_logic_vector(63 downto 0);
		  output : out std_logic_vector(63 downto 0));
   end component f_function;
	
----------------------------------------------------------------------------------

		
		component constantROM is
			 Port ( 
				  address : in STD_LOGIC_VECTOR (4 downto 0);
				  data_out : out STD_LOGIC_VECTOR (31 downto 0)
			 );
      end component constantROM;

----------------------------------------------------------------------------------
		
		component keyRAM is PORT(
         input : in std_logic_vector(63 downto 0);
	      read_address : in std_logic_vector(4 downto 0);
	      write_address : in std_logic_vector(4 downto 0);
	      write_in : in std_logic;
	      clock : in std_logic;
	      read_data : out std_logic_vector(63 downto 0));
      end component keyRAM;

----------------------------------------------------------------------------------		
		
	
	component key_expansion is PORT(
		  KiIN : in std_logic_vector(127 downto 0);
		  muxsel2 :in std_logic;
		  loadK01, loadK23 :in std_logic;
		  clock :in std_logic; 
		  reset :in std_logic; 
        rst : in std_logic;
		  countEN : in std_logic;
		  rom_constant : in std_logic_vector(31 downto 0);
		  count : out std_logic_vector(4 downto 0);
		  KiOUT : out std_logic_vector(63 downto 0);
		  inteq16 : out std_logic;
        i0nteq0 : out std_logic);
   end component key_expansion;

---------------------------------------------------------------------------------------

	component R16_POST_PROCESSING is port(
	  loadPP, reset : in std_logic;
	  L, R, K15 : in std_logic_vector(63 downto 0);
	  clock : in std_logic;
	  output : out std_logic_vector(127 downto 0));
	end component R16_POST_PROCESSING;

---------------------------------------------------------------------------------------
	component tristate is
		 Port (
			  a    : in  STD_LOGIC_vector(127 downto 0);
			  s    : in  STD_LOGIC;   
			  b    : out STD_LOGIC_vector(127 downto 0)
		 );
	end component tristate;
---------------------------------------------------------------------------------------	

	component ed_counter is port(
		clock : in std_logic;
		countEN : in std_logic;
		ENC_DEC : IN STD_LOGIC;
		reset : in std_logic;
	   preset : in std_logic;		
		output : out std_logic_vector(4 downto 0));
	end component ed_counter;

---------------------------------------------------------------------------------------	

   component comparator2 is port(
	  count : in std_logic_vector(4 downto 0);
	  EncDec : in std_logic;
	  inteq15 : out std_logic;
	  inteq0ED : out std_logic);
   end component comparator2;

---------------------------------------------------------------------------------------	
	
   signal L, R : std_logic_vector(63 downto 0);
	signal mux1out, mux2out : std_logic_vector(63 downto 0);
	signal regLout, regRout : std_logic_vector(63 downto 0);
	signal function_out : std_logic_vector(63 downto 0);
	signal nextR : std_logic_vector(63 downto 0);
	signal K, Ki : std_logic_vector(63 downto 0);
	signal tri_in : std_logic_vector(127 downto 0);
   signal countt1, countt2: std_logic_vector(4 downto 0);	
	signal rom_output : std_logic_vector(31 downto 0);
	
begin
   L <= INPUT(127 DOWNTO 64);
	R <= INPUT(63 DOWNTO 0);
	

   mux1 : MUX2TO1 port map(A => L,
	                        B => regRout,
                           sel => muxsel1,
                           Y => mux1out);	

   mux2 : MUX2TO1 port map(A => R,
	                        B => nextR,
                           sel => muxsel1,
                           Y => mux2out);
									
										 
   regL : reg port map(D => mux1out,
             	        reset => RESET,
							  load => loadT,
							  clk => CLOCK,
							  Q => regLout);

	regR : reg port map(D => mux2out,
							  reset => RESET,
							  load => loadT,
							  clk => CLOCK,
							  Q => regRout);
							  
							  
   round_function : f_function port map(input => regRout,
	                                     Ki => Ki,
	                                     output => function_out);
													 
													 
	key_expa : key_expansion port map (KiIN => KiIN,												 
												  muxsel2 => muxsel2,												  
	                                   loadK01 => loadK01,
												  loadK23 => loadK23,												  
												  clock => CLOCK,
												  reset => RESET,
                                      rst => rstKG,
												  countEN => countENKG,
												  rom_constant => rom_output,
												  count => countt2,
												  KiOUT => K,
												  inteq16 => inteq16,
                                      i0nteq0 => i0nteq0);
												  
   PP : R16_POST_PROCESSING port map(loadPP => loadPP, 
	                                  reset => RESET, 
	                                  L => regLout, 
												 R => regRout, 
												 K15 => Ki,
	                                  clock => CLOCK, 
	                                  output => tri_in);	

  tri : tristate port map(a => tri_in,
                          s => outEN,
                          b => OUTPUT);								  
												  
  KROM : constantROM port map(address => countt2,
                                data_out => rom_output);	 
												 
  KRAM : keyRAM port map(--input => K,
--                         address => address,
--                         write_in => mux4out,
--                         clock => clock,
--                         output => Ki
								 
								 input => K,
								 read_address => countt1,
								 write_address => countt2,
								 write_in => write_in,
								 clock => clock,
								 read_data => Ki );	
								 
  encdec_counterr : ed_counter port map(
      clock => CLOCK,
		countEN => countENED,
		ENC_DEC => ENC_DEC,
		preset => presetED,
		reset => rstED,
		output => countt1);
		
  compara2 : comparator2 port map(
     count => countt1,
	  EncDec => ENC_DEC,
	  inteq15 => inteq15,
	  inteq0ED => inteq0ED);  
												  		 
													 
 nextR <= regLout XOR function_out;	


                                        	

end Behavioral;

