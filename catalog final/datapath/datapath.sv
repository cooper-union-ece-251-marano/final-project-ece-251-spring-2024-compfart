//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: datapath
//     Description: 16-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`ifndef DATAPATH
`define DATAPATH
`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../mux2/mux2.sv"
`include "../mux3/mux3.sv"
`include "../adder/adder.sv"
`include "../dff/dff.sv"
`include "../alu/alu.sv"
`include "../signext/signext.sv"
`include "../sl1/sl1.sv"
`include "../regfile/regfile.sv"


module datapath (
    input logic clk, rst, rw, pcSrc,
    input logic [1:0] rdst, mtr, jump, alusrc,
    input logic [2:0] aluctrl,

    input logic [15:0] instr, rd,

    output logic [15:0] alures, mwd, pc,
    output logic zero
    );


    logic [15:0] pcNext, pcPlus2, pcBranch, pcBranchNext;
    logic [15:0] signImmediate,signImmediateSHIFTED;

    logic [3:0] wa;
    logic [15:0] rwd;

    logic [15:0] alu1, alu2;

    dff pcReg(rst, clk, pcNext, pc);
    adder add(pc, 16'b10, pcPlus2);
    sl2 shImmediate(signImm, sign_shifted);
    adder addAlu(pcPlus2,sign_shifted, pcBranch);
    mux2 #(16) branchMux(pcPlus2, pcBranch, pcsrc, pcBranchNext);
    mux2 #(16) pcMux(pcBranchNext, {pcPlus2[15:13], instr[11:0], 1'b0}, alu1, jump, pcNext);
    mux2 #(4) waMux(instr[7:4], instr[3:0], 4'b1111, rdst, wa);
    regfile rf(instr[11:8], instr[7:4], wa, rwd, rw, clk, alu1, mwd);
    signext signext(instr[3:0], signImm);
    mux2 #(16) memMux(alures, rd, pcPlus2, mtr, rwd);
    mux2 #(16) alu2Mux(mwd,signImmed, {12'b0,instr[7:4]}, alusrc, alu2);
    alu alu(alu1, alu2, aluctrl, alures, zero);



endmodule

`endif // DATAPATH
