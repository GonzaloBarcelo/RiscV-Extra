library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alu is 
generic(g_data_w:integer:=32);
port(
	a: in std_logic_vector(31 downto 0);
	b: in std_logic_vector(31 downto 0);
	shamt: in std_logic_vector(4 downto 0);
	alu_op:in std_logic_vector(3 downto 0);
	
	alu_out: out std_logic_vector(31 downto 0);
	z: out std_logic;
	lt:out std_logic;
	ge:out std_logic
	);
end Alu;	
architecture structural of Alu is

	signal s_sumres,s_maymen,s_sll,s_srl,s_sra: std_logic_vector(31 downto 0);
	signal sig,s_r: std_logic;
	signal a_uns,b_uns: unsigned(31 downto 0);
	
begin 
a_uns<=unsigned(a);
b_uns<=unsigned(b);

z<='1' when a=b else '0';
lt<='1' when a_uns < b_uns else '0';

--ge<=not '0' when a_uns < b_uns else '1';
ge<='1' when a_uns>b_uns or a_uns=b_uns else '0';
Multiplexor: entity work.multiplex
	generic map(g_data_w=>32)
	port map(
		s_r			=>		s_r,
		alu_out		=>		alu_out,
		alu_op		=>		alu_op,
		s_sumres		=>		s_sumres,
		s_maymen		=>		s_maymen,
		s_sll			=>		s_sll,
		s_srl			=>		s_srl,
		s_sra			=>		s_sra,
		a				=>		a,
		b				=>		b
		);

Sumador_restador: entity work.sumador_restadornbits
	generic map(g_data_w =>32)
	port map(
		s_r			=>s_r,
		s_sumres		=>s_sumres,
		a_out			=>a,
		b_out			=>b,
		sig			=>sig
		);

ComparadorMayorMenor: entity work.CompMayorMenor
	generic map(g_data_w=>32)
	port map(
		entrada_a		=>		a,
		entrada_b		=>		b,
		s_r				=>		s_r,
		s					=>s_maymen
		);
		
DesplazamientoDer: entity work.DesplDer
	generic map(g_data_w=>32)
	port map(
	s		=>			s_srl,
	entrada	=>			a,
	shamt	=>			shamt
	);
	
DesplazamientoIzq: entity work.DesplIzq
	generic map(g_data_w=>32)
	port map(
	s		=>			s_sll,
	entrada	=>			a,
	shamt	=>			shamt
	);



DesplazamientoDerAr: entity work.DesplDerArit
	generic map(g_data_w=>32)
	port map(
	s		=>			s_sra,
	entrada=>			a,
	shamt	=>			shamt
	);
end structural;