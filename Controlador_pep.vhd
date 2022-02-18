library IEEE;
use ieee.std_logic_1164.all;

entity Controlador_pep is
port (
clean: out std_logic;
valor_psp: in std_logic_vector(7 downto 0)
);
end Controlador_pep;
architecture behavioural of Controlador_pep is
begin 
clean<='1' when valor_psp="01000000" else '0';

end behavioural;