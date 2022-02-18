transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/Quartus14Extra/unbit.vhd}
vcom -93 -work work {D:/Quartus14Extra/selector.vhd}
vcom -93 -work work {D:/Quartus14Extra/rutadatos.vhd}
vcom -93 -work work {D:/Quartus14Extra/RegistroPP.vhd}
vcom -93 -work work {D:/Quartus14Extra/registro64bits.vhd}
vcom -93 -work work {D:/Quartus14Extra/Multiplexor.vhd}
vcom -93 -work work {D:/Quartus14Extra/ms1.vhd}
vcom -93 -work work {D:/Quartus14Extra/medioBit.vhd}
vcom -93 -work work {D:/Quartus14Extra/detector_de_flanco.vhd}
vcom -93 -work work {D:/Quartus14Extra/contador9bits.vhd}
vcom -93 -work work {D:/Quartus14Extra/Contador8.vhd}
vcom -93 -work work {D:/Quartus14Extra/comparador.vhd}
vcom -93 -work work {D:/Quartus14Extra/AsciiA16Seg.vhd}
vcom -93 -work work {D:/Quartus17/sumador1bit.vhd}
vcom -93 -work work {D:/Quartus17/sumador_restadornbits.vhd}
vcom -93 -work work {D:/Quartus17/RutaDatos.vhd}
vcom -93 -work work {D:/Quartus17/ROM.vhd}
vcom -93 -work work {D:/Quartus17/RAMJD.vhd}
vcom -93 -work work {D:/Quartus17/Multiplex.vhd}
vcom -93 -work work {D:/Quartus17/GenInm.vhd}
vcom -93 -work work {D:/Quartus17/DesplIzq.vhd}
vcom -93 -work work {D:/Quartus17/DesplDerArit.vhd}
vcom -93 -work work {D:/Quartus17/DesplDer.vhd}
vcom -93 -work work {D:/Quartus17/CompMayorMenor.vhd}
vcom -93 -work work {D:/Quartus17/BiestD32.vhd}
vcom -93 -work work {D:/Quartus17/BiestD8.vhd}
vcom -93 -work work {D:/Quartus17/BancoReg.vhd}
vcom -93 -work work {D:/Quartus18/BiestD8_r.vhd}
vcom -93 -work work {D:/Quartus18/BiestD8_s.vhd}
vcom -93 -work work {D:/Quartus18/Controlador_pep.vhd}
vcom -93 -work work {D:/Quartus14Extra/registroSP.vhd}
vcom -93 -work work {D:/Quartus14Extra/DecodDisp.vhd}
vcom -93 -work work {D:/Quartus17/Alu.vhd}
vcom -93 -work work {D:/Quartus14Extra/Receptor.vhd}
vcom -93 -work work {D:/Quartus17/Procesador.vhd}
vcom -93 -work work {D:/Quartus17/RISCV.vhd}
vcom -93 -work work {D:/Quartus17/Practica17.vhd}
vcom -93 -work work {D:/Quartus18/practica18.vhd}

