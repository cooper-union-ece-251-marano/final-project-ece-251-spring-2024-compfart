//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./datapath.sv"

module tb_datapath();
    logic rst, rw, pcsrc;
    logic [1:0] rdst, mtr, jump, alusrc;
    logic [2:0] aluctrl;
    logic [15:0] instr, rd;

    logic[15:0] alures, mwd, pc;
    logic zero;

    reg clk, reset; 

    logic [139:0] test[0:1000];
    integer i, errors;
  

    logic [15:0] exp_alures, exp_mwd, exp_Pc;
    logic exp_zero;


    datapath uut (
             .clk(clk),
             .rst(rst),
             .rw(rw),
             .rdst(rdst),
             .mtr(mtr),
             .jump(jump),
             .alusrc(alusrc),
             .pcsrc(pcsrc),
             .aluctrl(aluctrl),
             .instr(instr),
             .rd(rd),
             .alures(alures),
             .mwd(mwd),
             .pc(pc),
             .zero(zero)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_datapath.vcd");
        $dumpvars(0, uut);
        
        test[0] = {1'b0, 1'b0, 2'b00, 2'b00, 2'b00, 2'b01, 1'b0, 3'b000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'hXXXX, 1'b1};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        {rst, rw, rdst, mtr, jump, alusrc, pcsrc, aluctrl, instr, rd, exp_alures, exp_mwd, exp_Pc, exp_zero} = test[i];



    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({alures, mwd, pc, zero} !== {exp_alures, exp_mwd, exp_Pc, exp_zero}) begin
                $display("Error:\tinputs: {rst,regWrite,regDst,memToReg,jump,aluSrc,pcSrc,aluCtrl} = %b %b %b %b %b %b %b %b", rst, regWrite, regDst, memToReg, jump, aluSrc, pcSrc, aluCtrl);
                $display("      \tinstruction = %h, readData = %h", instr, rd);
                $display("\taluResult = %h, expectedAluResult = %h", alures, exp_alures);
                $display("\tmemWriteData = %h, expectedMemWriteData = %h", mwd, exp_mwd);
                $display("\tpc = %h, expectedPc = %h", pc, exp_Pc);
                $display("\tzero = %b, expectedZero = %h", zero, exp_zero);

                errors = errors++;
            end
            i = i++;
            if (test[i] === 140'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
