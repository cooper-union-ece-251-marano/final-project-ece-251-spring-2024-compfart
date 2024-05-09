//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: dmem
//     Description: 16-bit RISC memory ("data" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef dmem
`define dmem
`timescale 1ns/100ps

module dmem (
    input logic clk, mw,
    input logic [15:0] addr, wd,
    output logic [15:0] rd
    );

    logic [15:0] MEMORY [32767:0];

    assign rd = MEMORY[addr[15:1]];

    always @(posedge clk) begin
        if (mw) MEMORY[addr[15:1]] <= wd;
    end
endmodule

`endif // DMEM