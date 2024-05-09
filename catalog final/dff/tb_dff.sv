//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: tb_dff
//     Description: Test bench for 16 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./dff.sv"

module tb_dff();
    logic [15:0] d;
    logic [15:0] q;
    logic rst; 

    reg clk, reset; 

    logic [32:0] test[0:1000];
    logic [32:0] tmp;
    integer i, errors;
    logic [15:0] expectedQ;


    dff uut (
             .rst(rst),
             .clk(clk),
             .d(d),
             .q(q)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_dff.vcd");
        $dumpvars(0, uut);

        test[0] = {1'b0, 16'h0000, 16'h0000};
        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; 
        {rst, d, expectedQ} = testvectors[vectornum];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if (q !== expectedQ) begin
                $display("Error:\tinputs: rst = %b, d = %h", rst, d);
                $display("\tq = %h, expectedQ = %h", q, expectedQ);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 33'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
