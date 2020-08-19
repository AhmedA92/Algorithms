library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIR_Filter is generic(data_width : integer := 16;                        --data input size.
                             out_width  : integer := 32;                        --data output size.
                             taps       : integer := 10);                       --number of taps in the filter.
                     Port (D_in : in signed(data_width-1 downto 0);
                           clk, rst: in std_logic;
                           D_out : out signed(data_width-1 downto 0));
end FIR_Filter;

architecture Behavioral of FIR_Filter is

begin


end Behavioral;
