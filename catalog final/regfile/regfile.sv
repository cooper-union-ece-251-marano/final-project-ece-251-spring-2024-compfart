//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: regfile
//     Description: 16-bit RISC register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef REGFILE
`define REGFILE
`timescale 1ns/100ps

module regfile (
    input logic [3:0] ra1, ra2, wa,
    input logic [15:0] wd,
    input logic rw, clk,
    output logic [15:0] rd1, rd2
    );

    reg [15:0] rFile [15:0];
    assign rd1 = rFile[ra1];
    assign rd2 = rFile[ra2];

    always begin
        rFile[0] <= 0; 
        @(posedge clk) if (rw && wa != 0) rFile[wa] <= wd;
    end


endmodule

`endif // REGFILE
