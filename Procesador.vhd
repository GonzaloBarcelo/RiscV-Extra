library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Procesador is 
port (
--entradas
clk: in std_logic;
reset_n: in std_logic;
m_pc: in std_logic_vector(1 downto 0);

en_ir:in std_logic;
tipo_inst: in std_logic_vector(2 downto 0);
mask_b0: in std_logic;

m_banco: in std_logic_vector(1 downto 0);
en_banco: in std_logic;

m_alu_a: in std_logic_vector(1 downto 0);
m_alu_b: in std_logic_vector(1 downto 0);
alu_op: in std_logic_vector(3 downto 0);

m_shamt: in std_logic;

--tipo_acc: in std_logic_vector(1 downto 0);
--l_u: in std_logic;
--we_ram: in std_logic;
m_ram:in std_logic;

wr_pc_cond: in std_logic;
wr_pc: in std_logic;
ir_out1: out std_logic_vector(31 downto 0);

addr: out std_logic_vector(31 downto 0);
din: out std_logic_vector(31 downto 0);
d_out:in std_logic_vector(31 downto 0)
);

end Procesador;
architecture structural of Procesador is 

signal reg_a,reg_b: std_logic_vector(31 downto 0);
signal d_in: std_logic_vector(31 downto 0);
signal pc_in,pc_out,pc_ir,ir_in,ir_out: std_logic_vector(31 downto 0);
signal pc_out_reg,d_ram_alu,inm: std_logic_vector(31 downto 0);
signal z,lt,ge : std_logic;
signal alur_out,alu_out: std_logic_vector(31 downto 0);
signal en_pc: std_logic;
signal entrada_alu_a,entrada_alu_b: std_logic_vector(31 downto 0);
signal shamt: std_logic_vector(4 downto 0);
--signal d_out: std_logic_vector(31 downto 0);
signal temp0,temp1:std_logic;
signal inicio: std_logic_vector(1 downto 0);
begin
ir_out1<=ir_out; 
inicio<=ir_out(14)&ir_out(12);
--Multiplexor de equals y de signo
temp0<=z when inicio="00" else
			not z when inicio="01" else
			lt when inicio="10" else
			ge when inicio="11";
--Condiciones and
temp1<=wr_pc_cond and temp0;

en_pc<=wr_pc or temp1;

--Multiplexor de entrada
pc_in<=alu_out when m_pc = "00" else
		alur_out when m_pc = "01" else	
		(others=>'0');
		
PC: entity work.BiestD32
port map(
clk=> clk,
en => en_pc,
d	=> pc_in,
q	=>pc_out
);

PC_IRC: entity work.BiestD32
port map(
clk=> clk,
en => en_ir,
d	=> pc_out,
q	=>pc_ir
);

ROM_C: entity work.ROM
port map(
clk	=>clk,
en_pc	=>en_pc,
addr	=>pc_in,
data	=>ir_in
);

IRC: entity work.BiestD32
port map(
clk=> clk,
en => en_ir,
--Hay que cambiar esta entrada por la salida de la ROM
d	=> ir_in,
q	=>ir_out
);

GeneradorInm: entity work.GenInm
port map(
	ir_out		=>ir_out,
	tipo_inst	=>tipo_inst,
	mask_b0		=>mask_b0,
	inm			=>inm
);

--Entradas al banco de registro
d_in<=d_ram_alu when m_banco="00" else
		pc_out when m_banco="01" else
		inm when m_banco="10" else
		(others=>'0');
	
--Banco de registros
Banco_de_registros: entity work.BancoReg
port map(

addrA		=>ir_out(19 downto 15),
addrB		=>ir_out(24 downto 20),
addrW		=>ir_out(11 downto 7),

d_in		=>d_in,
reg_a		=>reg_a,
reg_b		=>reg_b,
en			=>en_banco,
clk		=>clk,
reset_n	=>reset_n
);

--Entradas al alu
entrada_alu_a<=reg_a when m_alu_a="00" else
					pc_out when m_alu_a="01" else
					pc_ir when m_alu_a="10" else
					(others=>'0');
entrada_alu_b<=reg_b when m_alu_b="00" else
					X"00000004" when m_alu_b="01" else
					inm when m_alu_b="10" else
					(others=>'0');

--Shamt

shamt<=reg_b(4 downto 0) when m_shamt='0' else 
       ir_out(24 downto 20) when m_shamt='1' else
		 (others=>'0');				

--ALU
ALU_C: entity work.Alu 
port map(
	a		=> entrada_alu_a,
	b		=> entrada_alu_b,
	shamt	=> shamt,
	alu_op=>alu_op,
	alu_out=>alu_out,
	z		=>z,
	lt		=>lt,
	ge		=>ge
);

ALUR: entity work.BiestD32
port map(
clk=> clk,
en => '1',
d	=> alu_out,
q	=>alur_out
);

--RAM
din<=reg_b;
addr<=alur_out;

--RAM_C: entity work.RAMJD
--port map(
	--reset_n  =>reset_n,
--	clk		=>clk,
--	addr		=> alur_out,
--	din		=>reg_b,
--	d_out		=>d_out,
--	tipo_acc	=>tipo_acc,
--	l_u		=>l_u,
--	we_ram	=> we_ram
--);
--salida final 
d_ram_alu<=alur_out when m_ram='0' else d_out;

end structural;