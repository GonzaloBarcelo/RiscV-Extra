library IEEE;
use ieee.std_logic_1164.all;

entity Puente is 
port(
addr: in std_logic_vector(31 downto 0);
din: in std_logic_vector(31 downto 0);
we: in std_logic;
re: in std_logic;

dout: out std_logic_vector(31 downto 0);
dato_val: out std_logic;


pwdata: out std_logic_vector(7 downto 0);
pwrite: out std_logic;
paddr: out std_logic_vector(3 downto 0);
penable: out std_logic;
psel0: out std_logic;
psel1: out std_logic;
psel2: out std_logic;
psel3: out std_logic




);

end Puente;
architecture behavioural of Puente is


begin 

end behavioural;