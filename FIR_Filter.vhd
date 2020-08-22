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
                             coeff_width: integer := 8;                         --this is only defined because often times 16 bit is too big for it.
                             out_width  : integer := 32;                        --data output size.
                             taps       : integer := 11);                       --number of taps in the filter.
                     Port (D_in : in signed(data_width-1 downto 0);
                           clk, rst: in std_logic;
                           D_out : out signed(out_width-1 downto 0));
end FIR_Filter;

architecture Behavioral of FIR_Filter is

--Filter Coefficients
type coeficient_type is array (0 to taps-1) of signed(coeff_width-1 downto 0);  
constant coeficients: coeficient_type := (X"F1",X"F3",X"07",X"26",X"42",X"4E",X"42",X"26",X"07",X"F3",X"F1");  

--shift register for the input data.
type shift_reg_type is array (0 to taps-1) of signed(data_width-1 downto 0);  
signal input_shift_reg : shift_reg_type;

--2 shift registers to save and shift values calculated from addition and multiplication.
type accum_shift_reg_type is array (0 to taps-1) of signed(out_width-1 downto 0);  
signal mult : accum_shift_reg_type;
signal add: accum_shift_reg_type;

--internal signals
signal counter : integer;

begin

process (clk) begin
    if (rst = '1') then
        D_out <= (others => '0');
        counter <= 0;
    else 
        if rising_edge(clk) then

            if counter = 0 then
                input_shift_reg(0) <= D_in;
                mult(0) <= D_in * coeficients(0);   
                add(0) <= D_in * coeficients(0);
                counter <= counter + 1;
            elsif counter < taps then
                input_shift_reg(counter) <= input_shift_reg(counter-1);
                mult(counter) <= input_shift_reg(counter) * coeficients(counter);   
                add(counter) <= mult(counter) + add(counter-1);
                counter <= counter + 1;
            else 
                counter <= 0;        
            end if;
            
        end if;    
        D_out <= add(taps-1);
    end if;

end process;

end Behavioral;
