//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-28                                                  //
//     Module Name: tb_adder                                                    //
//     Description: Test bench for 16 bit adder.                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./adder.sv"

module adder_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] sum;

    reg clk, rst; //reset for initializing testvectors

    logic [47:0] test[0:1000];
    integer num, errors;
    logic [15:0] exp_sum;


    adder uut (
             .a(a),
             .b(b),
             .sum(sum)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, uut);
        $monitor("a = 0x%0h b = 0x%0h sum = 0x%0h", a, b, sum);
        
        test[0] = {16'hFFFF, 16'h0000, 16'hFFFF};
        num = 0;
        errors = 0;
        rst = 1; #27; rst = 0;
    end

    always @(posedge clk) begin
        #1; 
        {a, b, exp_sum} = test[num];
    end

    always @(negedge clk) begin
        #1;
        if (~rst) begin
            if (sum !== exp_sum) begin
                $display("Error:\tinputs: a = %h, b=%h", a, b);
                $display("\tactual = %h, expected = %h", sum, expSum);
                errors = errors++;
            end
            num = num++;
            if (test[num] === 48'hx) begin
                $display("%d tests finished with %d errors", num, errors);
                $finish;
            end
        end
    end


endmodule
