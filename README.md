📖 Overview

This project implements both Synchronous and Asynchronous FIFO architectures in Verilog HDL.
The asynchronous FIFO design focuses on safe Clock Domain Crossing (CDC) using Gray-coded pointers and multi-stage synchronizers to mitigate metastability.

The design is fully parameterized, synthesizable, and verified using dual independent clock domains.

🎯 Objectives

Design a parameterized FIFO (configurable depth and width)
Implement a dual-clock asynchronous FIFO
Ensure safe pointer transfer across clock domains
Generate robust full and empty flags
Verify functionality under asynchronous clock operation

🏗 Architecture

🔹 Synchronous FIFO
Single clock domain
Binary read/write pointers
Full/Empty detection using pointer comparison
🔹 Asynchronous FIFO
Independent write and read clocks
Binary-to-Gray pointer conversion
Gray-to-binary synchronization
Two-stage flip-flop synchronizers
Metastability-safe CDC implementation

📂 Project Structure

├── FIFO_TOP_async.v
├── write_ptr.v
├── read_ptr.v
├── fifo_buff.v
├── synchronizer.v
├── FIFO_async_tb.v
└── README.md

⚙ Parameters

Parameter	Description
fifo_depth	Number of entries in FIFO
fifo_width	Data width
pointer_bits	Calculated using $clog2(fifo_depth)

🛠 Tools

Verilog HDL
Vivado Simulator (XSIM) / ModelSim 

📌 Author

Juriel
