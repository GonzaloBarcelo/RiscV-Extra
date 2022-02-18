library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RutaDatos is 
port (
clk: in std_logic;
ir_out: in std_logic_vector(31 downto 0);
m_pc: out std_logic_vector(1 downto 0);
reset_n:in std_logic;
en_ir: out std_logic;
tipo_inst: out std_logic_vector(2 downto 0);
mask_b0: out std_logic;

m_banco: out std_logic_vector(1 downto 0);
en_banco: out std_logic;

m_alu_a: out std_logic_vector(1 downto 0);
m_alu_b: out std_logic_vector(1 downto 0);
alu_op: out std_logic_vector(3 downto 0);

m_shamt: out std_logic;

tipo_acc: out std_logic_vector(1 downto 0);
l_u: out std_logic;
we_ram: out std_logic;
m_ram:out std_logic;

wr_pc_cond: out std_logic;
wr_pc: out std_logic
);
end RutaDatos;
architecture behavioural of RutaDatos is 
signal opcode: std_logic_vector(6 downto 0);
type t_estados is (Reset,Fetch,Decod,lui3,lwsw3,auipc3,Arit3,Ariti3,SalCond,Jal3,Jalr3, lw4,sw4,Arit4,lw5);
signal estado_sig,estado_act: t_estados;
begin 
opcode<=ir_out(6 downto 0);

VarEstados: process (clk,reset_n)
begin 
	if reset_n ='0' then 
		estado_act<=Reset;
	elsif clk' event and clk='1' then 
		estado_act<=estado_sig;
	end if; 
end process VarEstados;

Transicion: process(opcode,estado_act)
begin
estado_sig<=estado_act;
case estado_act is 
	when Reset=>
		estado_sig<=Fetch;
	
	when Fetch=>
		estado_sig<=Decod;
		
	when Decod=>
		if opcode="0110111" then
			estado_sig<=lui3;
		elsif opcode="0100011" then 
			estado_sig<=lwsw3;
		elsif opcode="0000011" then 
			estado_sig<=lwsw3;
		elsif opcode="0010111" then 
			estado_sig<=auipc3;
		elsif opcode="0110011" then 
			estado_sig<=arit3;
		elsif opcode="1100011" then 
			estado_sig<=salCond;
		elsif opcode="0010011" then 
			estado_sig<=ariti3;
		elsif opcode="1100111" then 
			estado_sig<=jalr3;
		elsif opcode="1101111" then 
			estado_sig<= jal3;
		end if;
		
	when lwsw3=>
		if opcode="0000011" then 
			estado_sig<=lw4;
		elsif opcode="0100011" then 
			estado_sig<=sw4;
		end if;
		
	when lui3=>
		estado_sig<=Fetch;
	
	when auipc3=>
		estado_sig<=Arit4;
	
	when Ariti3=>
		estado_sig<=Arit4;
	
	when Arit3=>
		estado_sig<=Arit4;
		
	when SalCond=>
		estado_sig<=Fetch;
	when Jal3=>
		estado_sig<=fetch;
	when Jalr3=>
		estado_sig<=fetch;
	
	when lw4=>
		estado_sig<=lw5;
	when sw4=>
		estado_sig<=Fetch;
		
	when lw5=>
		estado_sig<=Fetch;
		
	when Arit4=>
		estado_sig<=Fetch;
	end case;
	
end process Transicion;
Salidas: process(clk,ir_out,estado_act)
begin
	m_pc		<="00";
	en_ir		<='0';
	tipo_inst<="000";
	mask_b0	<='0';

	m_banco	<="00";
	en_banco	<='0';

	m_alu_a	<="00";
	m_alu_b	<="00";
	alu_op	<="0000";

	m_shamt	<='0';

	tipo_acc	<="00";
	l_u		<='0';
	we_ram	<='0';
	m_ram		<='0';

	wr_pc_cond<='0';
	wr_pc<='0';
	
	case estado_act is
		when Reset =>
			m_pc <= "10";
			wr_pc <='1';
		when Fetch =>
			m_alu_a <= "01";
			m_alu_b <= "01";
			alu_op  <= "0000";
			m_pc    <= "00";
			wr_pc   <= '1';
			en_ir   <= '1' ;
		when Decod => 
			tipo_inst <= "010";
			m_alu_a <= "10";
			m_alu_b <= "10";
			alu_op <= "0000";
		when auipc3 =>
			tipo_inst <= "011";--3
			alu_op <= "0000";
			m_alu_a <= "10";
			m_alu_b <= "10";
		when lwsw3 =>
			if opcode="0000000" then 
				tipo_inst<="000";
			else 
				tipo_inst<="001";
			end if;
			
			alu_op <= "0000";
			m_alu_a <= "00";
			m_alu_b <= "10";
			
		when lui3 =>
			tipo_inst <= "011";
			m_banco <= "10";
			en_banco <= '1';
		when arit3=>
			alu_op<=ir_out(30)&ir_out(14)&ir_out(13)&ir_out(12);
			m_alu_a<="00";
			m_alu_b<="00";
			m_shamt<='0';
			
		when ariti3=>
		--He cambiado esto!!
	   --alu_op<=ir_out(30)&ir_out(14)&ir_out(13)&ir_out(12);
			if ir_out(14 downto 12)="101" then 
				alu_op<=ir_out(30)&ir_out(14)&ir_out(13)&ir_out(12);
			else 
				alu_op<='0'&ir_out(14)&ir_out(13)&ir_out(12);
			end if;
			m_alu_a<="00";
			m_alu_b<="10";
			m_shamt<='1';
		when arit4=>
			m_ram<='0';
			m_banco<="00";
			en_banco<='1';
			
		when salCond=>
			wr_pc_cond<='1';
			m_pc<="01";
			m_alu_a<="00";
			m_alu_b<="00";
			alu_op<="0010";
			
		when lw4=>
			tipo_acc<=ir_out(13)&ir_out(12);
			l_u<=ir_out(14);
			
			
		when sw4=>
			tipo_acc<=ir_out(13)&ir_out(12);
			we_ram<='1';
			
			
		when lw5=>
			m_banco<="00";
			en_banco<='1';
			m_ram<='1';
			l_u<=ir_out(14);
			tipo_acc<=ir_out(13)&ir_out(12);
				
			
		when Jal3=>
			wr_pc<='1';
			en_banco<='1';
			m_banco<="01";
			m_pc<="00";
			alu_op<="0000";
			m_alu_a<="10";
			m_alu_b<="10";
			tipo_inst<="100";
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		when jalr3=>
			mask_b0<='1';
			wr_pc<='1';
			en_banco<='1'		;
			m_banco<="01";
			m_pc<="00";
			alu_op<="0000";
			m_alu_a<="00";
			m_alu_b<="10";
			tipo_inst<="000";
	end case ;
	
end process Salidas;
end behavioural;