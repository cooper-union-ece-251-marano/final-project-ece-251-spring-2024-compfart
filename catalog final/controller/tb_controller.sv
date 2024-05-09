//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //   
//     Module Name: tb_controller                                               //
//     Description: Test bench for a 32-bit RISC-based CPU controller           // 
//                                                                              //
//                                                                              //  
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./controller.sv"

module tb_controller();
    logic [3:0] op;
    logic [2:0] aluctrl;
    logic [1:0] rdst, mtr, jump, alusrc;
    logic rw, mw, pcsrc, zero;

    logic [13:0] ctrl;

    reg clk, rst;

    logic [63:0] test[0:1000];
    integer i, errors;


    logic [13:0] exp_ctrl;

    controller uut (
             .op(op),
             .zero(zero),
             .rw(rw),
             .rdst(rdst),
             .mw(mw),
             .mtr(mtr),
             .jump(jump),
             .alusrc(alusrc),
             .pcsrc(pcsrc),
             .aluctrl(aluctrl)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end


    initial begin
    $dumpfile("tb_controller.vcd");
    $dumpvars(0, uut);
    
    
    test[0] = {4'b0000, 1'b0, 14'b10100000000010}; // Adjust the value according to your needs
    
    num = 0; 
    errors = 0;
    reset = 1; #27; reset = 0;
    $display("control = {regWrite,regDst,memWrite,memToReg,jump,aluSrc,pcSrc} {aluCtrl}");
end

    always @(negedge clk) begin
        #1;  
        {op, zero, expCtrl} = test[i];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            ctrl = {
                rw,
                rdst,
                mw,
                mtr,
                jump,
                alusrc,
                pcsrc,
                aluctrl
                };
            if (ctrl !== exp_ctrl) begin
                $display("Error:\tinputs: op = %h, zero = %b", op, zero);
                $display("\tcontrol = %b %b, expectedControl = %b %b", control[9:3], control[2:0], expectedControl[9:3], expectedControl[2:0]);
                errors = errors++;
            end
            i = i++;
            if (test[i] === 64'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule