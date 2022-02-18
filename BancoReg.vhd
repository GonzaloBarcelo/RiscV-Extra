library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BancoReg is 
port 
(
addrA: in std_logic_vector(4 downto 0);
addrB: in std_logic_vector(4 downto 0);
addrW: in std_logic_vector(4 downto 0);

d_in: in std_logic_vector(31 downto 0);
reg_a: out std_logic_vector(31 downto 0);
reg_b: out std_logic_vector(31 downto 0);
en: in std_logic;
clk: in std_logic;
reset_n: in std_logic
);

end BancoReg;
architecture behavioural of BancoReg is 
	type mem_t is array(0 to 31) of std_logic_vector(31 downto 0);
	signal ram_block : mem_t;
	
begin 
process(clk,reset_n)
begin 
if reset_n ='0' then
	ram_block<=(others=>(others=>'0'));
elsif clk' event and clk='1' then 
	if en = '1' then 
		ram_block(to_integer(unsigned(addrW)))<=d_in;
	end if;
end if;
end process;
reg_a<=ram_block(to_integer(unsigned(addrA)));
reg_b<=ram_block(to_integer(unsigned(addrB)));
end behavioural;