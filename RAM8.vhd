	library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM8 is 
port (
	addr: in std_logic_vector(9 downto 0);
	tipo_acc: in std_logic_vector(1 downto 0);
	d_out: out std_logic_vector(7 downto 0);
	din1: in std_logic_vector(7 downto 0);
	din2: in std_logic_vector(7 downto 0);
	din3: in std_logic_vector(7 downto 0);
	--reset_n: in std_logic;
	we_b: in std_logic;
	we_h: in std_logic;
	we_w: in std_logic;
	clk: in std_logic

);
end RAM8;
architecture behavioural of RAM8 is 
signal d_in: std_logic_vector(7 downto 0);
signal we: std_logic;
type mem_t is array (0 to 1023) of std_logic_vector(7 downto 0);
signal ram_block: mem_t;

begin 

d_in<= din1 when tipo_acc="00" else	
		 din2 when tipo_acc="01" else
		 din3 when tipo_acc="10" else
		 din1;

we<= we_b or we_h or we_w;

process(we,d_in,addr,clk)
begin
if clk' event and clk='1' then 
	if we='1' then
		ram_block(to_integer(unsigned(addr)))<=d_in;
	end if;
end if;
end process;	
d_out<=ram_block(to_integer(unsigned(addr)));
end behavioural;
