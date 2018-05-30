onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_full_adder/A
add wave -noupdate /testbench_full_adder/B
add wave -noupdate /testbench_full_adder/Cin
add wave -noupdate /testbench_full_adder/S
add wave -noupdate /testbench_full_adder/Cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {299153 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {434176 ps}
