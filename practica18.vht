-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "05/03/2021 02:54:58"
                                                            
-- Vhdl Test Bench template for design  :  practica18
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY practica18_vhd_tst IS
END practica18_vhd_tst;
ARCHITECTURE practica18_arch OF practica18_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC:='0';
SIGNAL display0 : STD_LOGIC;
SIGNAL display1 : STD_LOGIC;
SIGNAL display2 : STD_LOGIC;
SIGNAL display3 : STD_LOGIC;
SIGNAL display4 : STD_LOGIC;
SIGNAL display5 : STD_LOGIC;
SIGNAL display6 : STD_LOGIC;
SIGNAL display7 : STD_LOGIC;
SIGNAL e_s : STD_LOGIC;
SIGNAL reset_n : STD_LOGIC;
SIGNAL s_p : STD_LOGIC_VECTOR(16 DOWNTO 0);
COMPONENT practica18
	PORT (
	clk : IN STD_LOGIC;
	display0 : OUT STD_LOGIC;
	display1 : OUT STD_LOGIC;
	display2 : OUT STD_LOGIC;
	display3 : OUT STD_LOGIC;
	display4 : OUT STD_LOGIC;
	display5 : OUT STD_LOGIC;
	display6 : OUT STD_LOGIC;
	display7 : OUT STD_LOGIC;
	e_s : IN STD_LOGIC;
	reset_n : IN STD_LOGIC;
	s_p : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : practica18
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	display0 => display0,
	display1 => display1,
	display2 => display2,
	display3 => display3,
	display4 => display4,
	display5 => display5,
	display6 => display6,
	display7 => display7,
	e_s => e_s,
	reset_n => reset_n,
	s_p => s_p
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;
clk<=not clk after 10 ns;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations 
                                     
BEGIN     

reset_n<='0';
e_s<='1';
wait for 10 ns;
reset_n<='1';                                                      
wait for 10 ms;
--Bit Start
e_s<='0';

--Primer bit
wait for 0.052 ms;
e_s<='1';
wait for 0.052 ms;
e_s<='0';
wait for 0.052 ms;
e_s<='1';
wait for 0.052 ms;
e_s<='1';
wait for 0.052 ms;
e_s<='0';
wait for 0.052 ms;
e_s<='0';
wait for 0.052 ms;
e_s<='0';
wait for 0.052 ms;
e_s<='0';
wait for 0.052 ms;
--Paridad IMPAR
e_s<='0';
wait for 0.052 ms;
e_s<='1';
wait for 10 ms;

--Sumaremos 11+1=012


assert false
report "Fin simulacion"
severity failure;						
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END practica18_arch;
