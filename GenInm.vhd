library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GenInm is 
port (
	ir_out: in std_logic_vector(31 downto 0);
	tipo_inst: in std_logic_vector(2 downto 0);
	mask_b0: in std_logic;
	inm: out std_logic_vector(31 downto 0)
);
end GenInm;
architecture behavioural of GenInm is 
	signal inm_sin_mask: std_logic;
	signal cod_inst: std_logic_vector(31 downto 0);
	signal inmediato: std_logic_vector(31 downto 0);
	subtype tipo_inst_t is std_logic_vector (2 downto 0);
	constant TYPE_I : tipo_inst_t := "000";
	constant TYPE_S : tipo_inst_t := "001";
	constant TYPE_B : tipo_inst_t := "010";
	constant TYPE_U : tipo_inst_t := "011";
	constant TYPE_J : tipo_inst_t := "100";
begin 
cod_inst<=ir_out;
inm_sin_mask <= cod_inst (20) when tipo_inst = TYPE_I else 
					 cod_inst (7) when tipo_inst = TYPE_S else
					'0';

inmediato (0) <= inm_sin_mask and not mask_b0;

inmediato (4 downto 1) <=
	cod_inst (24 downto 21) when tipo_inst = TYPE_I or	tipo_inst = TYPE_J else
	cod_inst (11 downto 8) when tipo_inst = TYPE_S or
	tipo_inst = TYPE_B else "0000";
  
inmediato (10 downto 5)<=
	cod_inst (30 downto 25) when tipo_inst = TYPE_I or tipo_inst = TYPE_S or tipo_inst = TYPE_B or tipo_inst = TYPE_J 
	else "000000";

inmediato (11)<=
	cod_inst(7) when tipo_inst=TYPE_B else
	cod_inst(20)when tipo_inst=TYPE_J else
	cod_inst(31)when tipo_inst=TYPE_I or tipo_inst = TYPE_S else
	'0';
inmediato(19 downto 12)<=
	cod_inst(19 downto 12) when tipo_inst=TYPE_U or tipo_inst = TYPE_J else
	(others => cod_inst(31));
inmediato(30 downto 20)<=
	cod_inst(30 downto 20) when tipo_inst = TYPE_U else 
	(others=>cod_inst(31));
inmediato(31)<=cod_inst(31);


inm<=inmediato;	

end behavioural;