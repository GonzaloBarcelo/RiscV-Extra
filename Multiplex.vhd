library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplex is
 generic (
g_data_w : integer := 32);
port(
	alu_out : out std_logic_vector(g_data_w-1 downto 0);
	
	alu_op : in std_logic_vector(3 downto 0);
	
	s_sumres : in std_logic_vector(g_data_w-1 downto 0);
	s_sll    :in std_logic_vector(g_data_w-1 downto 0);
	s_maymen: in std_logic_vector(g_data_w-1 downto 0);
	s_srl :in std_logic_vector(g_data_w-1 downto 0);
	s_sra :in std_logic_vector(g_data_w-1 downto 0);
	
	s_r:out std_logic;
	a : in std_logic_vector(g_data_w-1 downto 0);
	b : in std_logic_vector(g_data_w-1 downto 0)
	);
end Multiplex;
architecture behavioural of Multiplex is 
signal signal_xor : std_logic_vector(g_data_w-1 downto 0);
signal signal_or : std_logic_vector(g_data_w-1 downto 0);
signal signal_and : std_logic_vector(g_data_w-1 downto 0);
begin

i1: for i in 0 to g_data_w-1 generate
	signal_and(i)<=a(i)and b(i);
	signal_or(i)<=a(i) or b(i);
	signal_xor(i)<=a(i) xor b(i);
end generate i1;

with alu_op select
alu_out<=
		s_sumres when "0000",
		s_sumres when "1000",
		s_maymen when "0010",
		s_maymen when "0011",
		s_sll when "0001" ,
		s_srl when "0101" ,
		s_sra when "1101",
		signal_xor when "0100",
		signal_or when "0110",
		signal_and when "0111",
		s_sumres when others;
		
s_r<='1' when alu_op="1000" or alu_op="0010" else '0';

end behavioural;