library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BiestD32 is
port(
en: in std_logic;
d: in std_logic_vector(31 downto 0);
q: out std_logic_vector(31 downto 0);
clk: in std_logic
);
end BiestD32;
architecture behavioural of BiestD32 is 
begin
process(clk)
begin 
if clk' event and clk='1' then 
	if en = '1' then 
		q<=d;
	end if;
end if;
end process;

end behavioural;
