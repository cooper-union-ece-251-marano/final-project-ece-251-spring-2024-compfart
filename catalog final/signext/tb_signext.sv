//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: tb_signext
//     Description: Test bench for sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./signext.sv"

module signext_tb();
    logic [3:0] in;
    logic [15:0] out;

    reg clk, reset; //reset for initializing testvectors

    logic [19:0] test[0:1000];
    integer i, errors;
    logic [15:0] exp_out;


    signext uut (
             .in(in),
             .out(out)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_signext.vcd");
        $dumpvars(0, uut);
    
        test[0] = {4'b1010, 16'hfffa};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; 
        {in, exp_out} = test[i];
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (out !== exp_out) begin
                $display("Error:\tinputs: in = %h", in);
                $display("\tout = %h, expectedOut = %h", out, expectedOut);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 20'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule