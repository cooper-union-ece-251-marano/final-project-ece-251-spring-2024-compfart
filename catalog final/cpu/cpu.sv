//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //  
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: cpu                                                         //
//     Description: 32-bit RISC-based CPU (MIPS)                                //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU
`timescale 1ns/100ps

`include "../datapath/datapath.sv"
`include "../controller/controller.sv"

module cpu (
    input logic clk, rst,
    input logic [15:0] instruction, rd,
    output logic mw,
    output logic [15:0] alures, mwd, pc
    );
    logic zero, rw, pcsrc;
    logic [1:0] rdst, mtr, jump, alusrc;
    logic [2:0] aluctrl;

    controller cf_c(
        instr[15:12],
        zero,
        rw,
        mw,
        pcsrc,
        rdst,
        mtr,
        jump,
        alusrc,
        aluctrl
        );
    datapath cf_dp(
        clk,
        rst,
        rw,
        pccrc,
        rdst,
        mtr,
        jump,
        alusrc,
        aluctrl,
        instr,
        rd,
        alures,
        mwd,
        pc,
        zero
        );
endmodule

`endif // CPU