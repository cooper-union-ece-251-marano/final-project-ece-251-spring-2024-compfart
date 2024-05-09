//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //  
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_cpu                                                       //
//     Description: Testbench for a 16-bit RISC-based CPU (MIPS)                //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./cpu.sv"

module tb_cpu();
    logic rst;
    logic [15:0] instr, rd;

    logic mw;
    logic [15:0] alures, mwd, pc;

    reg clk, reset; 

    logic [87:0] test[0:1000];
    integer i, errors;

   
    logic exp_mw;
    logic [15:0] exp_alures, exp_mwd, exp_pc;

    cpu uut (
             .clk(clk),
             .rst(rst),
             .instr(instruction),
             .rd(rd),
             .mw(mw),
             .alures(alures),
             .mwd(mwd),
             .pc(pc)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_cpu.vcd");
        $dumpvars(0, uut);
        test[0] = {1'b0, 16'ha443, 16'h0000, 1'b0, 16'h000a, 16'h0007, 16'h0004};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        {rst, instruction, readData, expectedMemWrite, expectedAluResult, expectedMemWriteData, expectedPc} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({memWrite, aluResult, memWriteData, pc} !== {expectedMemWrite, expectedAluResult, expectedMemWriteData, expectedPc}) begin
                $display("Error:\tinputs: {rst, instruction, readData} = %b %b %b", rst, instruction, readData);
                $display("\tmemWrite= %h, expectedMemWrite = %h", memWrite, expectedMemWrite);
                $display("\taluResult = %h, expectedAluResult = %h", aluResult, expectedAluResult);
                $display("\tmemWriteData = %h, expectedMemWriteData = %h", memWriteData, expectedMemWriteData);
                $display("\tpc = %h, expectedPc = %h", pc, expectedPc);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 88'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
