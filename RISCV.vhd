library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISCV is 
port (
--entradas
clk: in std_logic;
reset_n: in std_logic;

addr: out std_logic_vector(31 downto 0);
dout: out std_logic_vector(31 downto 0);
tipo_acc:out std_logic_vector(1 downto 0);
l_u: out std_logic;
we: out std_logic;
din: in std_logic_vector(31 downto 0)
);

end RISCV;
architecture structural of RISCV is 

signal m_pc:  std_logic_vector(1 downto 0);
signal ir_out: std_logic_vector(31 downto 0);
signal en_ir: std_logic;
signal tipo_inst:  std_logic_vector(2 downto 0);
signal mask_b0:  std_logic;

signal m_banco:  std_logic_vector(1 downto 0);
signal en_banco:  std_logic;

signal m_alu_a:  std_logic_vector(1 downto 0);
signal m_alu_b:  std_logic_vector(1 downto 0);
signal alu_op:  std_logic_vector(3 downto 0);

signal m_shamt:  std_logic;

--signal tipo_acc:  std_logic_vector(1 downto 0);
--signal l_u:  std_logic;
signal we_ram:  std_logic;
signal m_ram: std_logic;

signal wr_pc_cond:  std_logic;
signal wr_pc:  std_logic;

begin 

Processor: entity work.Procesador
port map(

d_out=>din,
din=>dout,
addr=>addr,

clk  =>clk,
reset_n=> reset_n,
m_pc =>m_pc,
ir_out1=>ir_out,
en_ir=>en_ir,
tipo_inst =>tipo_inst,
mask_b0 =>mask_b0,

m_banco =>m_banco,
en_banco =>en_banco,

m_alu_a =>m_alu_a,
m_alu_b =>m_alu_b,
alu_op =>alu_op,

m_shamt =>m_shamt,

--tipo_acc =>tipo_acc,
--l_u =>l_u,
--we_ram =>we_ram,
m_ram=> m_ram,

wr_pc_cond =>wr_pc_cond,
wr_pc =>wr_pc
);

MaquinaEstados: entity work.RutaDatos
port map(
clk  =>clk,
reset_n=> reset_n,
m_pc =>m_pc,
ir_out=>ir_out,
en_ir=>en_ir,
tipo_inst =>tipo_inst,
mask_b0 =>mask_b0,

m_banco =>m_banco,
en_banco =>en_banco,

m_alu_a =>m_alu_a,
m_alu_b =>m_alu_b,
alu_op =>alu_op,

m_shamt =>m_shamt,

tipo_acc =>tipo_acc,
l_u =>l_u,
we_ram =>we_ram,
m_ram=> m_ram,

wr_pc_cond =>wr_pc_cond,
wr_pc =>wr_pc
);

we<=we_ram;

end structural;