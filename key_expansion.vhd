----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:05 10/15/2023 
-- Design Name: 
-- Module Name:    key_expansion - Behavioral 
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

entity key_expansion is PORT(
  KiIN : in std_logic_vector(127 downto 0);
  muxsel2 :in std_logic;
  loadK01, loadK23 :in std_logic;
  clock :in std_logic; 
  reset :in std_logic;
  rst : in std_logic;
  countEN : in std_logic;
  rom_constant : in std_logic_vector(31 downto 0);
  count : OUT std_logic_vector(4 downto 0);
  KiOUT : out std_logic_vector(63 downto 0);
  inteq16 : out std_logic;
  i0nteq0 : out std_logic);
end key_expansion;

architecture Behavioral of key_expansion is


		component muxx2to1 is PORT(
		  A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		  B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		  sel : IN STD_LOGIC;
		  Y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
		end component muxx2to1;
		
----------------------------------------------------------------------------------

		component g_function is port(
		  input : in std_logic_vector(31 downto 0);
		  output : out std_logic_vector(31 downto 0));
		end component g_function;

----------------------------------------------------------------------------------

		component adder32bit is
			 Port ( A : in std_logic_vector(31 downto 0);  
					  B : in std_logic_vector(31 downto 0);  
					  Y : out std_logic_vector(31 downto 0)  
					 );
		end component adder32bit;

----------------------------------------------------------------------------------

		component subtractor32bit is
			 Port ( A : in std_logic_vector(31 downto 0);  
					  B : in std_logic_vector(31 downto 0);  
					  Y : out std_logic_vector(31 downto 0)  
					 );
		end component subtractor32bit;
		
----------------------------------------------------------------------------------
		
		component reg32 is
            port (D : in std_logic_vector(31 downto 0);
						reset : in std_logic;
						load : in std_logic;
						clk : in std_logic; 
						Q : out std_logic_vector(31 downto 0));
      end component reg32;

----------------------------------------------------------------------------------		

		component kg_counter is port(
			clock : in std_logic;
			countEN : in std_logic;
			reset : in std_logic;
			output : out std_logic_vector(4 downto 0));
		end component kg_counter;
			
---------------------------------------------------------------------------------------
		
		component circshift_left8 is port(
		  input1 : in std_logic_vector(31 downto 0);
		  input2 : in std_logic_vector(31 downto 0);
		  output : out std_logic_vector(63 downto 0));
		end component circshift_left8;

----------------------------------------------------------------------------------
		
		component circshift_right8 is port(
		  input1 : in std_logic_vector(31 downto 0);
		  input2 : in std_logic_vector(31 downto 0);
		  output : out std_logic_vector(63 downto 0));
		end component circshift_right8;
		
----------------------------------------------------------------------------------
		
		component comparator is port(
		  count : in std_logic_vector(4 downto 0);
		  inteq16 : out std_logic;
		  i0nteq0 : out std_logic);
      end component comparator;
		
----------------------------------------------------------------------------------
		
		signal Key0, Key1, Key2, Key3 : std_logic_vector(31 downto 0);
		signal mux1out, mux2out, mux3out, mux4out : std_logic_vector(31 downto 0);
		signal regKey0out, regKey1out, regKey2out, regKey3out : std_logic_vector(31 downto 0);
		signal adder1out, adder2out, sub1out, sub2out : std_logic_vector(31 downto 0);
		signal g1out, g2out : std_logic_vector(31 downto 0);
		signal clsout, crsout : std_logic_vector(63 downto 0);
		signal Key0n, Key1n, Key2n, Key3n : std_logic_vector(31 downto 0);
      signal address : std_logic_vector(4 downto 0);

begin

   Key0 <= KiIN(127 downto 96);
   Key1 <= KiIN(95 downto 64);
   Key2 <= KiIN(63 downto 32);
   Key3 <= KiIN(31 downto 0);

   Key0n <= crsout(63 downto 32);
	Key1n <= crsout(31 downto 0);
	Key2n <= clsout(63 downto 32);
	Key3n <= clsout(31 downto 0);
	
	count <= address;
	KiOUT  <= g1out & g2out;
	
   muxx1 : muxx2to1 port map(A => Key0,
	                        B => Key0n,
                           sel => muxsel2,
                           Y => mux1out);	

   muxx2 : muxx2to1 port map(A => Key1,
	                        B => Key1n,
                           sel => muxsel2,
                           Y => mux2out);

   muxx3 : muxx2to1 port map(A => Key2,
	                        B => Key2n,
                           sel => muxsel2,
                           Y => mux3out);	

   muxx4 : muxx2to1 port map(A => Key3,
	                        B => Key3n,
                           sel => muxsel2,
                           Y => mux4out);
									
   regK0 : reg32 port map(D => mux1out,
             	        reset => reset,
							  load => loadK01,
							  clk => clock,
							  Q => regKey0out);

	regK1 : reg32 port map(D => mux2out,
							  reset => reset,
							  load => loadK01,
							  clk => clock,
							  Q => regKey1out);
 
   regK2 : reg32 port map(D => mux3out,
             	        reset => reset,
							  load => loadK23,
							  clk => clock,
							  Q => regKey2out);

	regK3 : reg32 port map(D => mux4out,
							  reset => reset,
							  load => loadK23,
							  clk => clock,
							  Q => regKey3out);
							  
							  
							  
    a1 : adder32bit port map(A =>regKey0out,
                           B => regKey2out,
                           Y => adder1out);
									
    s1 : subtractor32bit port map(A =>adder1out,
                           B => rom_constant,
                           Y => sub1out);	
									
    s2 : subtractor32bit port map(A =>regKey1out,
                           B => regKey3out,
                           Y => sub2out);
									
    a2 : adder32bit port map(A =>sub2out,
                           B => rom_constant,
                           Y => adder2out);	
									
    g1 : g_function port map(input => sub1out,
	                          output => g1out);

    g2 : g_function port map(input => adder2out,
	                          output => g2out);									  
									  
    cls8 : 	circshift_left8 port map(input1 => regKey2out,
	                                  input2 => regKey3out,
												 output => clsout);
												 
    crs8 : 	circshift_right8 port map(input1 => regKey0out,
	                                  input2 => regKey1out,
												 output => crsout);

   	

    kg_coun : kg_counter	port map(clock => clock,
						               countEN => countEN,
					                	reset => rst, 
						               output => address); 

    compara : comparator port map( count => address,
											  inteq16 => inteq16,
		                             i0nteq0 => i0nteq0); 											
												 
 

   	 
end Behavioral;

