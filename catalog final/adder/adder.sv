//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: adder                                                       //
//     Description: 16 bit adder                                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef ADDER
`define ADDER
`timescale 1ns/100ps

module adder (
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [15:0] sum
    );

    assign sum = a + b;

endmodule

`endif // ADDER
