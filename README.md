# Pipeline Arm Processor: 32-bit with Hazard Unit and Branch Predictor

## Overview

This project aims to design and implement an advanced 32-bit pipelined processor featuring a hazard unit and a branch predictor. The project expands upon the basic 32-bit processor by adding a comprehensive set of instructions to its instruction set, thereby augmenting its computational capabilities.


## Features

- **32-bit Pipeline Architecture**: Enhanced processing efficiency.
- **Hazard Unit**: Handles data and control hazards effectively.
- **Branch Predictor**: Improves instruction fetching accuracy.
- **Extended Instruction Set**: Supports a wide variety of computational tasks.
- **Implemented in Verilog**: High-fidelity hardware description language.
- **Cocotb-based Testbench**: For robust and flexible testing.

## Hazard Handling Mechanisms

- **Flush**: Clears a stage register, discarding the result of that stage.
- **Stall**: Holds the value of a stage register to introduce a bubble.
- **Forward**: Sends the calculated value to a previous stage.

### Data Hazards
- Handled by forwarding to avoid cycle wastage.
- Minimal stalling for memory operations.

### Control Hazards
- Branch Predictor for immediate value branches.
- Forwarding and minimal flushing for register value branches.

## Branch Predictor Components

- **Branch Target Buffer**: Stores PCs and branch target addresses.
- **Global Branch History Register**: For pattern recognition.
- **Pattern Table**: Maintains branching patterns.
- **RESET Input**: To initialize the predictor at startup.

## Getting Started

### Requirements
- Verilog Compiler
- Cocotb for testbench

### Running the Testbench
Run the Cocotb-based testbench to verify the processor design.

## Future Work
- Implement support for floating-point operations.
- Optimize the hazard unit for low-power consumption.

## Contribution
Uğur Tokdam
Yasincan Bozkurt

