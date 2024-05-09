//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_clock                                                    //
//     Description: Test bench for clock generator                              //  
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "../clock/clock.sv"

module tb_clock;
    wire clk;
    logic enable;

   initial begin
        $dumpfile("tb_clock.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t \t enable=%b clk=%b",$realtime, enable, clk);
    end

    initial begin
        enable <= 0;
        #10 enable <= 1;
        #100 enable <= 0;
        $finish;
    end

   clock uut(
        .enable(enable),
        .clk(clk)
    );
endmodule