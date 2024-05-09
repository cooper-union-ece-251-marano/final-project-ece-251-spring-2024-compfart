//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //                                                   
//     Module Name: computer                                                    // 
//     Description: 16-bit RISC                                                 //
//                                                                              //
//                                                                              //
//                                                                              // 
//////////////////////////////////////////////////////////////////////////////////
 `ifndef COMPUTER
`define COMPUTER
`timescale 1ns/100ps

`include "../cpu/cpu.sv"
`include "../imem/imem.sv"
`include "../dmem/dmem.sv"

module computer (
    input logic clk, rst,
    output logic [15:0] wd, addr,
    output logic mw
    );

    logic [15:0] instr, rd, pc;

    cpu compfart(
        clk,
        rst,
        instr,
        rd,
        mw,
        addr,
        wd,
        pc
    );


    imem imem(
        pc[5:1],
        instr
    );

    dmem dmem(
        clk,
        mw,
        addr,
        wd,
        rd
    );

endmodule

`endif // COMPUTER