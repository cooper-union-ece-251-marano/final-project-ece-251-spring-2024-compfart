//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //   
//     Module Name: tb_computer                                                 //
//     Description: Test bench for a single-cycle MIPS computer                 // 
//                                                                              //
//                                                                              //  
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./computer.sv"
`include "../clock/clock.sv"

module tb_computer();

    logic clk;
    logic clk_enable;
    logic rst;
    logic [15:0] wd, addr;
    logic mw;


    computer dut(.clk(clk), .rst(rst), .wd(wd), .addr(addr), .mw(mw));

    clock dut1(.enable(clk_enable), .clock(clk));


    initial begin
        $dumpfile("tb_computer.vcd");
        $dumpvars(0,dut);
    end

    initial begin
        #0 clk_enable <= 0; #50 rst <= 1; #50; rst <= 0; #50 clk_enable <= 1;
        
    end

    always @(negedge clk or posedge clk) begin
        if (mw) begin
                $display("Output (hex): %h", wd);
                $display("Output (dec): %d", wd);
                $finish();
            end
        end
    
endmodule