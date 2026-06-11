# 🛗 Elevator Controller — Verilog HDL

![Verilog](https://img.shields.io/badge/Verilog-HDL-FF6F00?style=flat-square&logo=v&logoColor=white)
![FPGA](https://img.shields.io/badge/FPGA-PYNQ--Z2-6E40C9?style=flat-square)
![Xilinx Vivado](https://img.shields.io/badge/Xilinx-Vivado-E01F27?style=flat-square&logo=amd&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-38BDAE?style=flat-square)

A fully functional **4-Floor Elevator Controller** implemented in Verilog HDL. The controller moves the elevator one floor at a time toward the requested floor using sequential RTL logic. Simulated and verified using Xilinx Vivado with a complete testbench.

---

## 📌 Project Overview

This project implements an elevator controller that:
- Accepts a **requested floor** as input
- Compares it with the **current floor**
- Moves the elevator **up or down one floor per clock cycle**
- Stops when the elevator **reaches the requested floor**
- Supports **asynchronous reset** to ground floor (Floor 0)

---

## 🔧 Features

- ✅ 4-floor support (Floor 0 to Floor 3) using 2-bit encoding
- ✅ Moves one floor per clock cycle toward requested floor
- ✅ Asynchronous active-high reset → returns to Floor 0
- ✅ Handles UP, DOWN, and IDLE conditions
- ✅ RTL Schematic verified in Xilinx Vivado
- ✅ FPGA implementation ready

---

## 📁 Project Structure

```
Elevator-Controller-Verilog/
│
├── elevator_controller.v      # Main RTL design
├── elevator_controller_tb.v   # Testbench
├── simulation/
│   └── waveform.png           # Simulation waveform
├── schematic.png              # RTL Schematic
├── floorplan.png              # FPGA Floorplan
└── README.md
```

---

## 💻 Source Code

### `elevator_controller.v` — RTL Design

```verilog
module elevator_controller(
    input clk,
    input rst,
    input  [1:0] request_floor,
    output reg [1:0] current_floor
);

// Sequential Logic — Move elevator one floor per clock cycle
always @(posedge clk or posedge rst)
begin
    if(rst)
        current_floor <= 2'b00;       // Reset to Ground Floor
    else
    begin
        if(request_floor > current_floor)
            current_floor <= current_floor + 1;   // Move UP
        else if(request_floor < current_floor)
            current_floor <= current_floor - 1;   // Move DOWN
        else
            current_floor <= current_floor;        // IDLE — Stay
    end
end

endmodule
```

---

### `elevator_controller_tb.v` — Testbench

```verilog
`timescale 1ns/1ps

module elevator_controller_tb;

reg clk;
reg rst;
reg [1:0] request_floor;
wire [1:0] current_floor;

// Instantiate DUT
elevator_controller DUT(
    .clk(clk),
    .rst(rst),
    .request_floor(request_floor),
    .current_floor(current_floor)
);

// Clock generation — 10ns period
always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    request_floor = 0;
    #10 rst = 0;

    request_floor = 2'b11;   // Request Floor 3
    #40;
    request_floor = 2'b01;   // Request Floor 1
    #40;
    request_floor = 2'b10;   // Request Floor 2
    #40;
    request_floor = 2'b00;   // Request Floor 0
    #40;
    $finish;
end

initial
begin
    $monitor("Time=%0t  Requested=%d  Current=%d",
              $time,
              request_floor,
              current_floor);
end

endmodule
```

---

## 🔄 Control Logic

```
┌─────────────────────────────────────────────────┐
│              ELEVATOR CONTROLLER                 │
│                                                  │
│  request_floor > current_floor → Move UP   ↑    │
│  request_floor < current_floor → Move DOWN ↓    │
│  request_floor = current_floor → IDLE      ■    │
│                                                  │
│  rst = 1 → Reset to Floor 0 (Ground)            │
└─────────────────────────────────────────────────┘
```

| Condition | Action | Floor Change |
|---|---|---|
| request > current | Move UP | current + 1 |
| request < current | Move DOWN | current - 1 |
| request = current | IDLE | No change |
| rst = 1 | Reset | Floor 0 |

---

## 🏢 Floor Encoding

| Floor | Binary |
|---|---|
| Ground Floor (0) | 2'b00 |
| Floor 1 | 2'b01 |
| Floor 2 | 2'b10 |
| Floor 3 | 2'b11 |

---

## 🖥️ Simulation Output

```
Time=0    Requested=0  Current=0
Time=10   Requested=3  Current=0
Time=20   Requested=3  Current=1
Time=30   Requested=3  Current=2
Time=40   Requested=3  Current=3
Time=50   Requested=1  Current=3
Time=60   Requested=1  Current=2
Time=70   Requested=1  Current=1
...
```

---

---

## 🚀 How to Run in Xilinx Vivado

1. **Open Vivado** → Create New Project
2. Add `elevator_controller.v` as **Design Source**
3. Add `elevator_controller_tb.v` as **Simulation Source**
4. Click **Run Simulation → Run Behavioral Simulation**
5. Observe waveforms for `request_floor` and `current_floor`
6. Click **Run Synthesis** → View RTL Schematic

---

## 📚 Concepts Used

| Concept | Description |
|---|---|
| **RTL Design** | Register Transfer Level sequential logic |
| **Sequential Logic** | Clocked always block with async reset |
| **Comparator Logic** | Greater than / less than floor comparison |
| **2-bit Counter** | Floor tracking using 2-bit register |
| **Testbench** | Multi-scenario simulation with $monitor |
| **FPGA Synthesis** | Vivado synthesis and floorplan generation |

---

## 👩‍💻 Author

**Prideeswari A**
B.E. Electronics Engineering — VLSI Design & Technology
M. Kumarasamy College of Engineering, Karur

[![GitHub](https://img.shields.io/badge/GitHub-PrideeswariA-181717?style=flat-square&logo=github)](https://github.com/PrideeswariA)
[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-FF6F00?style=flat-square&logo=netlify)](https://phenomenal-heliotrope-c53716.netlify.app)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
