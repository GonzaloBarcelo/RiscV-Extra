library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DesplDerArit is 
generic (g_data_w:integer:=32);
port(
	entrada: in std_logic_vector(g_data_w-1 downto 0);
	shamt: in std_logic_vector(4 downto 0);
	s: out std_logic_vector(g_data_w-1 downto 0)
	);
end DesplDerArit;
architecture behavioural of DesplDerArit is 
	signal registro: signed(g_data_w-1 downto 0);
	--signal temp: signed(g_data_w-1 downto 0);
begin 

registro<=shift_right(signed(entrada), to_integer(unsigned(shamt)));
s<=std_logic_vector(registro);

end behavioural;