
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/reset
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Mem_Addr
add wave -noupdate -group {Rs+Immediate value} -radix hexadecimal /mips_tb/U_0/ID/read_data_1
add wave -noupdate -group {Rs+Immediate value} -radix hexadecimal /mips_tb/U_0/ID/read_register_1_address
add wave -noupdate -group {Rs+Immediate value} -radix hexadecimal /mips_tb/U_0/ID/Instruction_immediate_value
add wave -noupdate -group {Rs+Immediate value} -radix hexadecimal /mips_tb/U_0/ID/Sign_extend
add wave -noupdate -group {Rs+Immediate value} -radix hexadecimal /mips_tb/U_0/ID/ALU_result
add wave -noupdate -group {Rd write destination} -radix hexadecimal /mips_tb/U_0/ID/write_register_address
add wave -noupdate -group {Rd write destination} -radix hexadecimal /mips_tb/U_0/ID/write_data
add wave -noupdate -group {Rd write destination} -radix hexadecimal /mips_tb/U_0/ID/read_register_2_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/register_array
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Read_data_1
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Sign_extend
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ALU_Result
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Ainput
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Binput
add wave -noupdate -group Mem -radix hexadecimal /mips_tb/U_0/MEM/read_data
add wave -noupdate -group Mem -radix hexadecimal /mips_tb/U_0/MEM/address
add wave -noupdate -group Mem -radix hexadecimal /mips_tb/U_0/MEM/MemRead
add wave -noupdate -group Mem -radix hexadecimal /mips_tb/U_0/MEM/write_clock
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/Opcode
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/RegDst
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/ALUSrc
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/MemtoReg
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/RegWrite
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/MemRead
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/MemWrite
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/Branch
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/ALUop
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/clock
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/reset
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/R_format
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/Lw
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/Sw
add wave -noupdate -group {Control Signals} -radix hexadecimal /mips_tb/U_0/CTL/Beq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {76622 ps} 0}
configure wave -namecolwidth 227
configure wave -valuecolwidth 62
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
WaveRestoreZoom {0 ps} {977162 ps}
restart -force; run 1000 ns