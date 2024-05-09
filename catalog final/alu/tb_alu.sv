//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_alu                                                      //
//     Description: Testbench for 32-bit ALU                                    //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_alu();
    logic [15:0] a, b;
    logic [2:0] ctrl;
    logic [15:0] res;
    logic zero;

    reg clk, rst;


    logic [55:0] test[0:32];
    logic [15:0] num, errors;
    logic [15:0] exp_res;
    logic exp_zero;

    alu uut (
        .a(a),
        .b(b),
        .ctrl(ctrl),
        .res(res),
        .zero(zero)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_alu.vcd");
        $dumpvars(0, uut);
        
        test[0]  = {3'b010, 16'h0000, 16'h0000, 16'h0000, 1'b1};
        num = 0;
        errors = 0;
        rst = 1; #27; rst = 0;
    end

    always @(posedge clk) begin
        #1; 
        {ctrl, a, b, exp_res, exp_zero} = test[num];
    end

    always @(negedge clk) begin
        if (~rst) begin
            if ({res, zero} !== {exp_res, exp_zero}) begin
                $display("Error:\tinputs: ctrl = %h, a = %h, b = %h", ctrl, a , b);
                $display("\tresult = %h, zero = %b\n\texpectedResult = %h, expectedZero = %h", result, zero, expResult, expZero);
                errors = errors + 1;
            end
            num = num++;
            if (test[num] === 56'hx) begin
                $display("%d tests finished with %d errors", num, errors);
                $finish;
            end
        end
    end
endmodule
