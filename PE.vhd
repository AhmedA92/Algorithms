-- processing Element (PE) as the building unit of a systolic 
-- matrix multiplication array.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PE is Port (a : in signed(7 downto 0);
                   b : in signed(7 downto 0); 
                   clk : in std_logic;
                   rst : in std_logic;
                   cell_val : out std_logic_vector (15 downto 0);
                   a_out : out signed(7 downto 0); 
                   b_out : out signed(7 downto 0));
end PE;

architecture Behavioral of PE is
-- System Signals
signal accum : signed(15 downto 0);

begin

process (clk) begin
    if(rst  = '1') then 
        accum <= "0000000000000000"; 
    else
        if rising_edge(clk)then
            accum <= accum + a*b;
            a_out <= a;
            b_out <= b;
            
        end if;
    end if;
     
end process;
cell_val <= std_logic_vector(accum); 
end Behavioral;
