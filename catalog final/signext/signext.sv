//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: signext
//     Description: 16 bit sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`ifndef SIGNEXT
`define SIGNEXT
`timescale 1ns/100ps

module signext (
    input logic [3:0] in,
    output logic [15:0] out
    );

    always @* begin
        out <= {{12{in[3]}}, in};
    end

endmodule

`endif // SIGNEXT
