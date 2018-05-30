onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/reset
add wave -noupdate -divider Fetch
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4_out
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Add_result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Branch
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Zero
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC_out
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/next_PC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Mem_Addr
add wave -noupdate -divider Decode
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_data_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_data_2
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/Instruction
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/ALU_result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/RegWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/MemtoReg
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/RegDst
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/Sign_extend
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/register_array
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_register_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_register_1_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_register_2_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_register_address_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_register_address_0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/Instruction_immediate_value
add wave -noupdate -divider Execute
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Read_data_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Read_data_2
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Sign_extend
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Function_opcode
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALUOp
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALUSrc
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Zero
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_Result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Add_Result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/PC_plus_4
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Ainput
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Binput
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_output_mux
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Branch_Add
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
add wave -noupdate -divider Mem
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/read_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/write_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/MemRead
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/Memwrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MEM/write_clock
add wave -noupdate -divider {Control Signals}
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Opcode
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/RegDst
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/ALUSrc
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/MemtoReg
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/RegWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/MemRead
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/MemWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Branch
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/ALUop
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/R_format
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Lw
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Sw
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Beq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {76622 ps} 0}
configure wave -namecolwidth 189
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
WaveRestoreZoom {0 ps} {1013108 ps}
