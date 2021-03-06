library IEEE;
use ieee.std_logic_1164.all;

entity BiestD8_r is
port (
clk: in std_logic;
reset_n: in std_logic;
d: in std_logic_vector(7 downto 0);
q: out std_logic_vector(7 downto 0);
en: in std_logic;
clean: in std_logic
);
end BIestD8_r;
architecture behavioural of BiestD8_r is 
begin 
process(clk,reset_n)
begin 
if reset_n='0' then 
q<=(others=>'0');
elsif clk' event and clk='1' and en='1' then 
	q<=d;
elsif clk' event and clk='1' and clean='1' then 
q<=(others=>'0');

end if;
end process;
end behavioural;
