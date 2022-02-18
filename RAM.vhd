library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is 
port (
	addr: in std_logic_vector(31 downto 0);
	din: in std_logic_vector(31 downto 0);
	d_out: out std_logic_vector(31 downto 0);
	
	tipo_acc: in std_logic_vector(1 downto 0);
	l_u: in std_logic;
	we_ram: in std_logic;
	clk: in std_logic
	--reset_n: in std_logic
);
end RAM;
architecture behavioural of RAM is 

signal we_b: std_logic_vector(3 downto 0);
signal we_h: std_logic_vector(1 downto 0);
signal we_w: std_logic;
signal b0,b1,b2,b3: std_logic_vector(7 downto 0);
signal MuxByte: std_logic_vector(7 downto 0);
signal MuxMedia: std_logic_vector(15 downto 0);

signal MuxByteSig: std_logic_vector(31 downto 0);
signal MuxMediaSig: std_logic_vector(31 downto 0);

begin 


--Nos ahorramos el primer descodificador: 
we_b(0)<='1' when addr(1 downto 0)="00" and tipo_acc="00" and we_ram='1' else '0';
we_b(1)<='1' when addr(1 downto 0)="01" and tipo_acc="00" and we_ram='1' else '0';
we_b(2)<='1' when addr(1 downto 0)="10" and tipo_acc="00" and we_ram='1' else '0';
we_b(3)<='1' when addr(1 downto 0)="11" and tipo_acc="00" and we_ram='1' else '0';
we_h(0)<='1' when addr(1)='0' and tipo_acc="01" and we_ram='1' else '0';
we_h(1)<='1' when addr(1)='1' and tipo_acc="01" and we_ram='1' else '0';
we_w<='1' when tipo_acc="10" and we_ram='1' else '0';

--Identamos todas las RAMS
RAM1: entity work.RAM8 
port map(
	--reset_n =>reset_n,
	addr => addr(11 downto 2),
	clk 	=>clk,
	tipo_acc=>"00",
	d_out=> b0,
	din1 => din(7 downto 0),
	din2=> din(7 downto 0),
	din3=> din(7 downto 0),
	we_b	=>we_b(0),
	we_h	=>we_h(0),
	we_w	=>we_w
);

RAM2: entity work.RAM8 
port map(
	--reset_n =>reset_n,
	addr => addr(11 downto 2),
	tipo_acc=>tipo_acc,
	clk 	=>clk,
	d_out=> b1,
	din1 => din(7 downto 0),
	din2=> din(15 downto 8),
	din3=> din(15 downto 8),
	
	we_b	=>we_b(1),
	we_h	=>we_h(0),
	we_w	=>we_w
);

RAM3: entity work.RAM8 
port map(
	--reset_n =>reset_n,
	addr => addr(11 downto 2),
	tipo_acc=>tipo_acc,
	d_out=> b2,
	clk 	=>clk,
	din1 => din(7 downto 0),
	din2=> din(7 downto 0),
	din3=> din(23 downto 16),
	
	we_b	=>we_b(2),
	we_h	=>we_h(1),
	we_w	=>we_w
);

RAM4: entity work.RAM8 
port map(
	--reset_n =>reset_n,
	addr => addr(11 downto 2),
	tipo_acc=>tipo_acc,
	d_out=> b3,
	clk 	=>clk,
	din1 => din(7 downto 0),
	din2=> din(15 downto 8),
	din3=> din(31 downto 24),
	
	we_b	=>we_b(3),
	we_h	=>we_h(1),
	we_w	=>we_w
);

--salidas

with addr(1 downto 0) select
MuxByte<=b0 when "00",
			b1 when "01",
			b2 when "10",
			b3 when "11",
			b1 when others;
			
MuxMedia<=b1&b0 when addr(1)='0'else  b3&b2 when addr(1)='1';

MuxByteSig<= std_logic_vector(resize(signed(muxByte),32)) when l_u ='1' else std_logic_vector(resize(unsigned(muxByte),32)); 
MuxMediaSig<= std_logic_vector(resize(signed(muxMedia),32)) when l_u ='1' else std_logic_vector(resize(unsigned(muxMedia),32)); 	

with tipo_acc select
D_out<=
	MuxByteSig when "00",
	MuxMediaSig when "01",
	b3&b2&b1&b0 when others;


end behavioural;
