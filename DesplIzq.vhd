library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DesplIzq is 
generic (g_data_w:integer:=32);
port(
	entrada: in std_logic_vector(g_data_w-1 downto 0);
	shamt: in std_logic_vector(4 downto 0);
	s: out std_logic_vector(g_data_w-1 downto 0)
	);
end DesplIzq;
architecture behavioural of DesplIzq is 
	signal registro: unsigned(g_data_w-1 downto 0);

begin 
registro<=shift_left(unsigned(entrada),to_integer(unsigned(shamt)));
s<=std_logic_vector(registro);

end behavioural;