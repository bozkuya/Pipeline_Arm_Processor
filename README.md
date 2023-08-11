# Pipeline_Arm_Processor
 Arm 32 bit Pipeline Processor
 The aim of this project is to expand upon the design of the 32-bit pipelined processor.
The pipelined processor with the hazard unit and the branch predictor. For this project the instruction set is extended with a few more instructions. The designed processor will be able to execute all instructions in the extended instruction set.
The hazard unit that will be implemented for this project will handle two hazard types. Most of the
design will be consistent with the implementation you have studied in the lectures. As a reminder, the
list of the terms for hazard handling is given.<br>
• Flush: Clearing a stage register so that the result of that stage is discarded<br>
• Stall: Holding the value of a stage register so that a bubble can be introduced<br>
• Forward: Sending the calculated value to a previous stage<br>
Data hazards happen when an instruction tries to read a register that has not yet been written back
by a previous instruction. There can be multiple methods to handle this hazard type even as simple as
constant stalling. However, you can see that this implementation method will decrease the efficiency of
your design. Hence you are required to implement your hazard unit such that:<br>
• Hazards caused by data operations must be handled by forwarding such that no cycle is wasted.<br>
• Hazards caused by memory operations can use a minimal amount of stalling.<br>
Control hazards happen when the decision of what instruction to fetch next has not been made by the
time the fetch takes place. In this project, different branch types will use different methods.<br>
• Branch operations that use immediate values (B, BL, and their conditional variants) will use branch
predictor. However, the predictor can make wrong guesses in which case flushing the stages are also necessary<br>
• Branch operations that use register values (MOV r15, BX, and their conditional variants) will
forward the new PC value to the fetch cycle and flush the wrong stages when the branch is
taken. This should be implemented with a minimal amount of flushing while considering the
critical path.<br>
Branch target buffer for storing
the PCs and branch target addresses of the last branch instructions, global branch history register, and
pattern table. The overall structure of the predictor can be seen in Figure 1.
The predictor will have a RESET input which will be used at the beginning to initialize
the predictor. <br>
The branch predictor can make wrong predictions, hence the computer will sometimes branch when
it should not. In this case, Fetch and Decode stages should be flushed and PC + 4 after the branch
instruction should be fetched. Thus, apart from the 3 modules that will be discussed predictor will also
forward PC + 4 from the branch instructions till the Execute stage for possible use. To realize this predictor you will be using Verilog HDL, Schematic editor is not required apart
from the extra Mux in the datapath that will select the next fetch address.
For Testbench cocotb is used.
