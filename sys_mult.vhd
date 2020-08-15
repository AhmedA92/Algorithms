library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sys_mult is Port (a_in : in signed(31 downto 0);
                         b_in : in signed(31 downto 0);
                         clk, rst : in std_logic;
                         c_out : out std_logic_vector (15 downto 0));
end sys_mult;

architecture Behavioral of sys_mult is

component PE is Port (a : in signed(7 downto 0);
                      b : in signed(7 downto 0); 
                      clk : in std_logic;
                      rst : in std_logic;
                      cell_val : out std_logic_vector (15 downto 0);
                      a_out : out signed(7 downto 0); 
                      b_out : out signed(7 downto 0));
end component;

--Internal Signals
signal C11_a, C11_b , C12_a, C12_b ,C13_a, C13_b ,C14_a, C14_b : signed(7 downto 0);
signal C21_a, C21_b , C22_a, C22_b ,C23_a, C23_b ,C24_a, C24_b : signed(7 downto 0);
signal C31_a, C31_b , C32_a, C32_b ,C33_a, C33_b ,C34_a, C34_b : signed(7 downto 0);
signal C41_a , C42_a ,C43_a ,C44_a : signed(7 downto 0); --no "b" as this is the last row.

-- block memory to save the final value of matrix multiplication.
type memory is array (0 to 15) of std_logic_vector (15 downto 0);    
signal comp_array : memory;

begin
---------------First Row-------------------------------
PE_C11: PE port map (a => a_in(7 downto 0),
                     b => b_in(7 downto 0),
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(0),
                     a_out => C11_a, 
                     b_out => C11_b);                    
PE_C12: PE port map (a => C11_a,
                     b => b_in(15 downto 8),
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(1),
                     a_out => C12_a, 
                     b_out => C12_b);                    
PE_C13: PE port map (a => C12_a,
                     b => b_in(23 downto 16),
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(2),
                     a_out => C13_a, 
                     b_out => C13_b);  
PE_C14: PE port map (a => C13_a,
                     b => b_in(31 downto 24),
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(3),
                     a_out => C14_a, 
                     b_out => C14_b);                      
---------------Second Row-------------------------------     
PE_C21: PE port map (a => a_in(15 downto 8),
                     b => C11_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(4),
                     a_out => C21_a, 
                     b_out => C21_b);  
PE_C22: PE port map (a => C21_a,
                     b => C12_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(5),
                     a_out => C22_a, 
                     b_out => C22_b);  
PE_C23: PE port map (a => C22_a,
                     b => C13_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(6),
                     a_out => C23_a, 
                     b_out => C23_b);  
PE_C24: PE port map (a => C23_a,
                     b => C14_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(7),
                     a_out => C24_a, 
                     b_out => C24_b);    
---------------Third Row-------------------------------   
PE_C31: PE port map (a => a_in(23 downto 16),
                     b => C21_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(8),
                     a_out => C31_a, 
                     b_out => C31_b);   
PE_C32: PE port map (a => C31_a,
                     b => C22_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(9),
                     a_out => C32_a, 
                     b_out => C32_b);   
PE_C33: PE port map (a => C32_a,
                     b => C23_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(10),
                     a_out => C33_a, 
                     b_out => C33_b); 
PE_C34: PE port map (a => C33_a,
                     b => C24_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(11),
                     a_out => C34_a, 
                     b_out => C34_b); 
---------------Fourth Row------------------------------- 
PE_C41: PE port map (a => a_in(31 downto 24),
                     b => C31_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(12),
                     a_out => C41_a);   
PE_C42: PE port map (a => C41_a,
                     b => C32_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(13),
                     a_out => C42_a);  
PE_C43: PE port map (a => C42_a,
                     b => C33_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(14),
                     a_out => C43_a);
PE_C44: PE port map (a => C43_a,
                     b => C34_b,
                     clk => clk,
                     rst => rst,
                     cell_val => comp_array(15),
                     a_out => C44_a);                                                                                                                                                                                                                                                                        
end Behavioral;
