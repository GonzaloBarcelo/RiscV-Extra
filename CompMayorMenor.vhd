library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CompMayorMenor is 
generic(g_data_w:integer:=32);
port (
	entrada_a: in std_logic_vector(g_data_w-1 downto 0);
	entrada_b: in std_logic_vector(g_data_w-1 downto 0);
	s: out std_logic_vector(g_data_w-1 downto 0);
	s_r: in std_logic
	);
end CompMayorMenor;
architecture behavioural of CompMayorMenor is
	signal s_sig: std_logic;
	signal s_sin_sig: std_logic;
	
begin 

s_sin_sig<='1' when unsigned(entrada_a)<unsigned(entrada_b) else '0';
s_sig<='1' when signed(entrada_a)<signed(entrada_b) else '0';



with s_r select
s<=(g_data_w-1 downto 1 => '0')&s_sig when '1',
	(g_data_w-1 downto 1 => '0')&s_sin_sig when '0',
	(g_data_w-1 downto 1 => '0')&s_sin_sig when others;
end behavioural;