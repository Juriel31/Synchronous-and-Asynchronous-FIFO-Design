## 📖 Overview

This project implements both Synchronous and Asynchronous FIFO architectures in Verilog HDL.
The asynchronous FIFO design focuses on safe Clock Domain Crossing (CDC) using Gray-coded pointers and multi-stage synchronizers to mitigate metastability.

The design is fully parameterized, synthesizable, and verified using dual independent clock domains.

## 🎯 Objectives

Design a parameterized FIFO (configurable depth and width)
Implement a dual-clock asynchronous FIFO
Ensure safe pointer transfer across clock domains
Generate robust full and empty flags
Verify functionality under asynchronous clock operation

## 🏗 Architecture

### 1. Synchronous FIFO
- Single clock domain
- Binary read/write pointers
- Full/Empty detection using pointer comparison

### 2. Asynchronous FIFO
- Independent write and read clocks
- Binary-to-Gray pointer conversion
- Gray-to-binary synchronization
- Two-stage flip-flop synchronizers
- Metastability-safe CDC implementation


## ⚙ Parameters

1. fifo_depth	-   Number of entries in FIFO
2. fifo_width	-   Data width
3. pointer_bits -  Calculated using $clog2(fifo_depth)

## 🛠 Tools

- Verilog HDL
- Vivado / ModelSim 

## Results and Design 
**[Test Waveform]**
![Refrence image](/FIFO_TEST.png)

**[Architecture]**
![Refrence image](/image1.png)

**[2 Synchronizer Working]**
![Refrence image](/sync.png)

## 📌 Author
Juriel
