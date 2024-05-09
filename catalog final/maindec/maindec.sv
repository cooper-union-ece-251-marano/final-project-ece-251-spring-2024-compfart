////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineers: Lamiah Khan and Megan Vo
// 
// Create Date: 2024-07-27
// Module Name: maindec
// Description: 16-bit RISC-based CPU main decoder (MIPS)
//
////////////////////////////////////////////////////////////////////////////////

`ifndef MAINDEC
`define MAINDEC
`timescale 1ns/100ps
`include "../alu/alu.sv"

module maindec (
    input logic [3:0] op,
    output logic rw, branch, mw,
    output logic [1:0] rdst, mtr, jump, alusrc,
    output logic [2:0] aluctrl
    );

      `define MD_ADD    4'b0000
      `define MD_SUB    4'b0001
      `define MD_MOVE   4'b0010
      `define MD_JR     4'b0011
      `define MD_AND    4'b0100
      `define MD_OR     4'b0101
      `define MD_SLL    4'b0110
      `define MD_SRL    4'b0111
      `define MD_SLT    4'b1000
      `define MD_BEQ    4'b1001
      `define MD_ADDI   4'b1010
      `define MD_SUBI   4'b1011
      `define MD_LW     4'b1100
      `define MD_SW     4'b1101
      `define MD_J      4'b1110
      `define MD_JAL    4'b1111

    logic [13:0] ctrl;
    assign {rw, rdst, branch, mw, mtr, jump, alusrc, aluctrl} = ctrl;

    always @*
        case(op)
            `MD_ADD:  ctrl <= {11'b10100000000, `ADD};
            `MD_SUB:  ctrl <= {11'b10100000000, `SUB};
            `MD_MOVE: ctrl <= {11'b10100000000, `ADD};
            `MD_JR:   ctrl <= {11'b00000001000, `ADD};
            `MD_AND:  ctrl <= {11'b10100000000, `AND};
            `MD_OR:   ctrl <= {11'b10100000000, `OR};
            `MD_SLL:  ctrl <= {11'b10100000010, `SLL};
            `MD_SRL:  ctrl <= {11'b10100000010, `SRL};
            `MD_SLT:  ctrl <= {11'b10100000000, `SLT};

            `MD_BEQ:  ctrl <= {11'b00010000000, `SUB};
            `MD_ADDI: ctrl <= {11'b10000000001, `ADD};
            `MD_SUBI: ctrl <= {11'b10000000001, `SUB};
            `MD_LW:   ctrl <= {11'b10000010001, `ADD};
            `MD_SW:   ctrl <= {11'b00001000001, `ADD};

            `MD_J:    ctrl <= {11'b00000000100, `ADD};
            `MD_JAL:  ctrl <= {11'b11000100100, `ADD};
        endcase
endmodule

`endif // MAINDEC
