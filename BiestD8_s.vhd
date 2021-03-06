library IEEE;
use ieee.std_logic_1164.all;

entity BiestD8_s is
port (
clk: in std_logic;
reset_n: in std_logic;
d: in std_logic_vector(7 downto 0);
q: out std_logic_vector(7 downto 0);
en: in std_logic
);
end BIestD8_s;
architecture behavioural of BiestD8_s is 
begin 
process(clk,reset_n)
begin 
if reset_n='0' then 
q<=(others=>'0');
elsif en='1' then 
	q<=d;

end if;
end process;
end behavioural;
