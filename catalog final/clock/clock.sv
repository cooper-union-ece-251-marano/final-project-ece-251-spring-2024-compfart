//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //    
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              // 
//     Create Date: 2024-04-27                                                  // 
//     Module Name: clock                                                       //
//     Description: Clock generator; duty cycle = 50%                           //
//                                                                              //
//                                                                              // 
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef clock
`define clock
`timescale 1ns/100ps

module clock (
    input enable,
    output reg clk
    );

    reg start;
    real on = 5;
    real off = 5;

    initial begin
        clk <= 0;
        start <= 0;
    end

    always @(posedge enable or negedge enable) begin
        if (ENABLE) begin
            start = 1;
        end
        else begin
            start = 0;
        end
    end

    always @(start) begin
        clk = 0;
        while (start) begin
            #(off) clk = 1;
            #(on) clk = 0;
        end
        clk = 0;
    end
endmodule

`endif // CLOCK


