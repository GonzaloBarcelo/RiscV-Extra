library IEEE;
use ieee.std_logic_1164.all;
entity Practica17 is 
port (
clk: in std_logic;
reset_n: in std_logic;

psp: out std_logic_vector(7 downto 0);
pep: in std_logic_vector(7 downto 0);
en_psp: out std_logic;
clean_pep: out std_logic
);
end Practica17;
architecture structural of practica17 is

signal addr: std_logic_vector(31 downto 0);
signal dinRAM: std_logic_vector(31 downto 0);
signal d_outRAM: std_logic_vector(31 downto 0);
signal tipo_acc:std_logic_vector(1 downto 0);
signal l_u:std_logic;
signal we_ram: std_logic;
signal we:std_logic;
signal din_RISCV: std_logic_vector(31 downto 0);

signal we_en_psp:std_logic;
signal p_data: std_logic_vector(31 downto 0);
signal dout_psp,dout_pep,pep_temp: std_logic_vector(7 downto 0);

begin 
--And 1

we_ram<=we and not(addr(31));

RAM_c: entity work.RAMJD
port map(
	clk		=>clk,
	addr		=> addr,
	din		=>dinRAM,
	d_out		=>d_outRAM,
	tipo_acc	=>tipo_acc,
	l_u		=>l_u,
	we_ram	=> we_ram
);

RISCV: entity work.RISCV
port map(
	clk		=>clk,
	reset_n	=> reset_n,
	addr		=>addr,
	din		=>din_RISCV,
	dout		=>dinRAM,
	tipo_acc	=>tipo_acc,
	l_u		=>l_u,
	we	=> we

);

--MUL1

din_RISCV<=d_outRAM when addr(31)='0' else p_data;

--And2

we_en_psp<=addr(31)and we;

--Puerto de salida paralelo
PSP_C: entity work.BiestD8_s
port map(
clk	=>clk,
en		=> we_en_psp,
q		=> dout_psp,
d		=> dinRAM(7 downto 0),
reset_n=>reset_n
);

en_psp<=we_en_psp;
psp<=dout_psp;

--PEP
PEP_C1: entity work.BiestD8
port map(
clk	=>clk,
reset_n=>reset_n,
en=>'1',
d=>pep,
q=>pep_temp
);
PEP_C2: entity work.BiestD8
port map(
clk	=>clk,
reset_n=>reset_n,
en=>'1',
d=>pep_temp,
q=>dout_pep
);


--MUL2
clean_pep<='1' when addr(2)='1' and addr(31)='1' else '0';

p_data(31 downto 8)<=(others=>'0');
p_data(7 downto 0)<=dout_pep when addr(2)='1' else dout_psp;



end structural;