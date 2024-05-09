//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: mux2
//     Description: 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef mux2
`define mux2
`timescale 1ns/100ps

module mux2
    #(parameter n = 16) (
    input logic [(n-1):0] a, b,
    input logic s,
    output logic [(n-1):0] res
    );

    assign res = s ? b : a;

endmodule

`endif // MUX2