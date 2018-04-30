Hey refahel ! 

# Tools
  * floating point convertor : https://www.h-schmidt.net/FloatConverter/IEEE754.html
  
## To-Do List

* [x] Swap.VHDL file - if we need to swap 2 numbers (for ADD FPU)
* [x] LeadingZeroes_counter.VHDL file - find how much leading zeroes in the input, output as signed(5 downto 0)
* [x] LeadingZeroes_counter - test bench + checking in modelsim
* [x] ADD_SUB_FPU.VHDL file
* [x] ADD_SUB_FPU - test bench + checking in modelsim
* [x] MUL_FPU.VHDL file
* [x] MUL_FPU.VHDL - test bench + checking in modelsim
* [x] FloatinPointNormlizer.VHDL file - convert 8 bit integer to 32-bit ieee 754 standart
* [x] FloatinPointNormlizer - test bench + checking in modelsim
* [x] FPU_selector.VHDL file - aid file for FPU_UNIT, exactly like arithmetic_selector
* [x] FPU_Unit.VHDL file - main unit for floating point, input&output 32 bit only ! (as required)
* [x] FPU_Unit - test bench + checking in modelsim
* [x] Output_selector.VHDL file - update to support FPU 8-bit LOW LSB&MSB, 8-bit HIGH LSB&MSB with the control of FPU_SW
* [x] ALU.VHDL file - update to support FPU + convert A,B to 32bit for AFU ( inputs A,B will be 8 bit, we convert them to 32-bit)
* [x] assign ADD & MUL new OPP , ADD = 1010, MUL = 1100

## 
* [ ] new test bench for Output_selector
* [ ] new test bench for ALU
* [ ] connect bit FPU_SW in ALU input to a swithc
* [ ] create a 16-bit convertor to the 7 segament display on the FPGA ( the output already been handled)
* [ ] board switches to registers to input for the ALU
* [ ] all the reports from quartus as required

