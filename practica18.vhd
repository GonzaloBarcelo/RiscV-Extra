library IEEE;
use ieee.std_logic_1164.all;

entity practica18 is 
port(
clk: in std_logic;
reset_n: in std_logic;
e_s: in std_logic;

	display0: out std_logic;
	display1: out std_logic;
	display2: out std_logic;
	display3: out std_logic;
	display4: out std_logic;
	display5: out std_logic;
	display6: out std_logic;
	display7: out std_logic;
	
	s_p: out std_logic_vector(16 downto 0)
);
end practica18;
architecture structural of practica18 is
signal entrada_p,salida_p: std_logic_vector(7 downto 0);
signal enable64:std_logic;
signal valor64nuevos: std_logic_vector(63 downto 0);
signal enable_nuevo_valor_para_display:std_logic;
signal salida_r: std_logic_vector(7 downto 0);
signal clean_pep: std_logic;
begin 

RISC_V:entity work.practica17
port map(
reset_n=>reset_n,
clk 	=> clk,
psp=>salida_p, --Valor para los displays o para limpiar la entrada
pep=>entrada_p,	--Entrada paralela para el procesador 
en_psp=>enable_nuevo_valor_para_display,
clean_pep =>open
);

Recept: entity work.Receptor
port map(
reset_n=>reset_n,
clk 	=> clk,
e_s	=>e_s,
led_correcto=>salida_r,
led_error=>open,
led_errorF=>open,
enable_64=>enable64
);

Controlador: entity work.Controlador_pep
port map(
valor_psp=>salida_p,
clean		=> clean_pep
);



Guardar_valor_e_p: entity work.BiestD8_r
port map(
clean=>clean_pep,
reset_n=>reset_n,
clk 	=> clk,
d	=>salida_r, --Sal	ida del receptor 
q  =>entrada_p,	--entrada del procesador
en=>enable64
);


Decodificador: entity work.DecodDisp
port map(
	clk=>clk,
	reset_n=>reset_n,
	e_p=>valor64nuevos,
	
	display0=>display0,
	display1=>display1,
	display2=>display2,
	display3=>display3,
	display4=>display4,
	display5=>display5,
	display6=>display6,
	display7=>display7,
	
	s_p=>s_p
	
);
RegistroDisplays: entity work.Registro64bits
port map(
clk=>clk,
reset_n=>reset_n,
e_p=>salida_p,
s_p=>valor64nuevos,
enable=>enable_nuevo_valor_para_display
);




end structural;
