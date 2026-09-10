# RISC-V Single-Cycle Processor

Verilog implementation of a single-cycle RISC-V processor. The datapath and control logic follow the design from *Computer Organization and Design: The Hardware/Software Interface* by David A. Patterson and John L. Hennessy.

---

## Datapath Overview

![Datapath](datapath.png)

The core executes instructions in a single clock cycle across five steps:
* **Fetch:** Reads instruction from memory and increments `PC + 4`.
* **Decode:** Generates control signals, reads source registers (`rs1`, `rs2`), and extends immediates.
* **Execute:** ALU computes the result or branch condition.
* **Memory:** Accesses data memory for load and store operations.
* **Write-Back:** Writes the final result back to `rd`.

---

## Supported Formats

![Formats](formats.png)

* **R-type:** Register-register operations (`add`, `sub`, `and`, `or`)
* **I-type:** Immediate arithmetic and loads (`addi`, `lw`)
* **S-type:** Memory stores (`sw`)
* **SB-type:** Conditional branches (`beq`)

---

## ALU Operations

| ALU Lines | Operation |
|:---:|:---:|
| `0000` | AND |
| `0001` | OR |
| `0010` | ADD |
| `0110` | SUB |

## Simulation & Verification

The core was tested in QuestaSim/ModelSim using this machine code sequence to verify basic operations and edge cases (zero register immutability, zero offsets, negative branch offsets, and signed immediate sign extension).

```text
// HEX       Binary Fields (Imm/funct7 - rs2 - rs1 - funct3 - rd - opcode)   Assembly        Comment
00002083    000000000000 00000 010 00001 0000011                        LW  x1, 0(x0)   // Load word from base address 0 into x1
00402103    000000000100 00000 010 00010 0000011                        LW  x2, 4(x0)   // Load word from address 4 into x2
002081B3    0000000 00010 00001 000 00011 0110011                        ADD x3, x1, x2  // x3 = x1 + x2
00302423    0000000 00011 00000 010 01000 0100011                        SW  x3, 8(x0)   // Store result x3 into memory address 8
00802203    000000001000 00000 010 00100 0000011                        LW  x4, 8(x0)   // Read back stored value from address 8 into x4
00418463    0000000 00100 00011 000 01000 1100011                        BEQ x3, x4, +8  // Branch forward if x3 == x4 (taken, skips next instruction)
002082B3    0000000 00010 00001 000 00101 0110011                        ADD x5, x1, x2  // Skipped instruction if branch evaluates correctly
00418333    0000000 00100 00011 000 00110 0110011                        ADD x6, x3, x4  // Branch target: x6 = x3 + x4
00000033    0000000 00000 00000 000 00000 0110011                        ADD x0, x0, x0  // NOP: verify x0 remains 0
00208033    0000000 00010 00001 000 00000 0110011                        ADD x0, x1, x2  // Corner test: writing to x0 must be ignored
000000B3    0000000 00000 00000 000 00001 0110011                        ADD x1, x0, x0  // Clear x1 to 0
001080B3    0000000 00001 00001 000 00001 0110011                        ADD x1, x1, x1  // Self-accumulate check (x1 = x1 + x1)
0020F1B3    0000000 00010 00001 111 00011 0110011                        AND x3, x1, x2  // Bitwise AND test
0020E233    0000000 00010 00001 110 00100 0110011                        OR  x4, x1, x2  // Bitwise OR test
402082B3    0100000 00010 00001 000 00101 0110011                        SUB x5, x1, x2  // Subtraction check using funct7 bit 30
00208463    0000000 00010 00001 000 01000 1100011                        BEQ x1, x2, +8  // Branch test (not taken: x1 != x2)
FFC0A303    111111111100 00001 010 00110 0000011                        LW  x6, -4(x1)  // Corner test: sign extension with negative immediate offset
FE108CE3    1111111 00001 00001 000 11001 1100011                        BEQ x1, x1, -8  // Corner test: backward branch with negative jump offset
````

![Simulation Waveform](waveform.jpg)
