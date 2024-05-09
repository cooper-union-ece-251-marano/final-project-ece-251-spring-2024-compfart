//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-04-27
//     Module Name: tb_imem
//     Description: Test bench for instruction memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./imem.sv"

module tb_imem();
    logic [4:0] addr;
    logic [15:0] instr;

    reg clk, reset; 

    logic [23:0] test[0:1000];
    integer i, errors;
    logic [15:0] exp_instr;


    imem uut (
             .addr(addr),
             .instr(instr)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_imem.vcd");
        $dumpvars(0, uut);
    
        test[0] = {8'h02, 16'h0002};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; 
        {addr, exp_instr} = test[i];
        
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (instr !== expectedInstr) begin
                $display("Error:\tinputs: address = %h", address);
                $display("\tinstruction = %h, expectedInstruction = %h", instruction, expectedInstruction);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 24'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule