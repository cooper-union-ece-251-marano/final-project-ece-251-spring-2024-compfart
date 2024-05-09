//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_dmem
//     Description: Test bench for data memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./dmem.sv"

module tb_dmem();
    logic mw;
    logic [15:0] addr, wd;

    logic [15:0] rd;

    reg clk, reset; 

    logic [51:0] test[0:1000];
    integer i, errors;
    logic [15:0] expectedReadData;


    dmem uut (
             .clk(clk),
             .mw(mw),
             .addr(addr),
             .wd(wd),
             .rd(rd)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_dmem.vcd");
        $dumpvars(0, uut);
    
        test[0] = {1'b1, 16'h000E, 16'h000E, 16'h000E};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; 
        {mw, addr, wd, exp_rd} = test[i];

    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if (rd !== exp_rd) begin
                $display("Error:\tinputs: memWrite = %b, address = %h, writeData = %h", memWrite, address, writeData);
                $display("\treadData = %h, expectedReadData = %h", readData, expectedReadData);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 52'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule