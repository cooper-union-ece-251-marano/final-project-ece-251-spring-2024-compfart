//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: dff
//     Description: 16 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`ifndef dff
`define dff
`timescale 1ns/100ps

module dff (
    input logic rst, clk,
    input logic [15:0] d,
    output reg [15:0] q
    );

    always @(posedge clk, posedge rst) begin
        if (rst)
            q <= 15'b0;
        else
            q <= d;
    end

endmodule

`endif // DFF
