transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/8) Altera/CPU CE MARCH 2013/LABs/LAB2 - FPGA,Quartus/LAB2 Exercise/Part 1 - Counter/Code - Quartus/counter.vhd}

vcom -93 -work work {D:/8) Altera/CPU CE MARCH 2013/LABs/LAB2 - FPGA,Quartus/LAB2 Exercise/Part 1 - Counter/Code - ModelSim/sample_package.vhd}
vcom -93 -work work {D:/8) Altera/CPU CE MARCH 2013/LABs/LAB2 - FPGA,Quartus/LAB2 Exercise/Part 1 - Counter/Code - ModelSim/test_counter.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  test_counter

add wave *
view structure
view signals
run -all
