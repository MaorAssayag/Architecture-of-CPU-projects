transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/xor.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/Swap.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/shift_unit.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/shift_Nbits.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/N_dff.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/MUX_Nbits.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/MUL_FPU.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/MUL.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/LeadingZeros_counter.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/full_adder.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/FPU_Unit.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/FPU_selector.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/dff_1bit.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/ADD_SUB_FPU.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/ADD_SUB.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/aidMips/ADD.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/MIPS.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/IFETCH.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/IDECODE.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/HAZARD.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/EXECUTE_branch.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/EXECUTE.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/DMEMORY.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/rtlMips/CONTROL.VHD}

vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/quartus/../tb/mips_tester_struct.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/CPU/LAB3/LABDOC/Lab3-1/ex9/quartus/../tb/mips_tb_struct.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  MIPS_tb

add wave *
view structure
view signals
run 20 us
