library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumador_restadornbits is
generic (
g_data_w : integer := 32) ;

port( 
	a_out,b_out: in std_logic_vector (g_data_w-1 downto 0);
	s_sumres: out std_logic_vector (g_data_w-1 downto 0);
	s_r: in std_logic;
	sig: out std_logic);
end sumador_restadornbits;

architecture structural of sumador_restadornbits is
	signal b_s: std_logic_vector(g_data_w-1 downto 0);
	signal c: std_logic_vector(g_data_w downto 0);
component sumador1bit is
	port (a_i,b_i : in std_logic;
		c_i: in std_logic;
		c_i_mas_1: out std_logic;
		s_i: out std_logic);
	end component;
	
begin

c(0)<=s_r;
sig<=c(g_data_w) xor c(g_data_w-1);

crearB :for i in 0 to g_data_w-1 generate
		b_s(i)<=s_r xor b_out(i);
	end generate crearB;

gensum :for i in 0 to g_data_w-1 generate
	i_1 : sumador1bit
	port map(
		a_i =>a_out(i),
		b_i =>b_s(i),
		s_i =>s_sumres(i),
		c_i =>c(i),
		c_i_mas_1=>c(i+1));
	
 end generate gensum;
end structural;