//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             // 
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: controller                                                  //
//     Description: 16-bit RISC-based CPU controller                            //
//                                                                              //    
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef controller
`define controler
`timescale 1ns/100ps

`include "../maindec/maindec.sv"

module controller (
    input logic [3:0] op,
    input logic zero,
    output logic rw, mw, pcsrc,
    output logic [1:0] rdst, mtr, jump, alusrc,
    output logic [2:0] aluctrl
    );


    logic branch;
    maindec md(
        op,
        rw,
        branch,
        mw,
        rdst,
        mtr,
        jump,
        alusrc,
        aluctrl
        );
    assign pcsrc = branch & zero;
endmodule

`endif // CONTROLLER