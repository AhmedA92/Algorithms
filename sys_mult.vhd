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
                                                       
end Behavioral;
