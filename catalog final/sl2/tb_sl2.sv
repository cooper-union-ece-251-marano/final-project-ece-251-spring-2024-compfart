//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: tb_sl2
//     Description: Test bench for shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./sl1.sv"

module sl1_tb();
    logic [15:0] in;
    logic [15:0] out;

    reg clk, reset; //reset for initializing testvectors

    logic [31:0] test[0:1000];
    integer i, errors;
    logic [15:0] exp_out;


    sl1 uut (
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
        $dumpfile("tb_sl1.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        test[0] = {16'h000F, 16'h001E};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; 
        {in, exp_out} = test[i];

        in = tmp[31:16];

        exp_out = tmp[15:0];
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (out !== exp_out) begin
                $display("Error:\tinputs: in = %h", in);
                $display("\tout = %h, expectedOut = %h", out, exp_out);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 32'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
