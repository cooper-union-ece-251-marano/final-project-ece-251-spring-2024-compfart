//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: tb_regfile
//     Description: Test bench for simple behavorial register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./regfile.sv"

module regfile_tb();
    logic [3:0] ra1, ra2, wa;
    logic [15:0] wd;
    logic rw;
    reg clk, reset;

    logic [15:0] rd1, rd2;

    logic [60:0] test[0:1000];
    logic [60:0] tmp;
    logic [15:0] i, errors;
    logic [15:0] exp_rd1;
    logic [15:0] exp_rd2;



    regfile uut (
                 .ra1(ra1),
                 .ra2(ra2),
                 .wa(wa),
                 .wd(wd),
                 .rw(rw),
                 .clk(clk),
                 .rd1(rd1),
                 .rd2(rd2)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_regfile.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        test[0] = {1'b1, 4'b0000, 16'b0000000000000000, 1'b0, 1'b0, 16'b0000, 16'b0000};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; 
        {rw,  wa, wd, ra1, ra2, exp_rd1, exp_rd2} = test[i];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if ({rd1, rd2} !== {exp_rd1, exp_rd22}) begin
                $display("Error:\tinputs: regWrite = %b, writeAddr = %h, writeData = %h, readAddr1 = %h, readAddr2 = %h", rw, wa, wd, ra1, ra2);
                $display("\treadData1 = %h, readData2 = %b\n\texpectedReadData1 = %h, expectedReadData2 = %h", rd1, rd2, exp_rd1, exp_rd2);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 61'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule