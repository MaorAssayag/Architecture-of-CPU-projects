transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/xor.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/Swap.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/shift_unit.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/shift_Nbits.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/N_dff.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/MUX_Nbits.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/MUL_FPU.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/MUL.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/LeadingZeros_counter.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/full_adder.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/FPU_Unit.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/FPU_selector.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/dff_1bit.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/ADD_SUB_FPU.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/ADD_SUB.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/aidMips/ADD.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/MIPS.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/IFETCH.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/IDECODE.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/HAZARD.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/EXECUTE_branch.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/EXECUTE.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/DMEMORY.VHD}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/VHDL/rtlMips/CONTROL.VHD}

vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/QUARTUS/quartus/../tb/mips_tester_struct.vhd}
vcom -2008 -work work {C:/Users/MaorA/Desktop/204654891_318550746/QUARTUS/quartus/../tb/mips_tb_struct.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  MIPS_tb

add wave *
view structure
view signals
run 20 us
