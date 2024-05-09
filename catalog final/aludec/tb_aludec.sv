//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_aludec                                                   //
//     Description: Testbench for aludec                                        //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_aludec;


  reg [5:0] funct;
  reg [1:0] aluop;
  wire [2:0] aluctrl;


  aludec #(.n(32)) dut (
    .funct(funct),
    .aluop(aluop),
    .aluctrl(aluctrl)
  );

 
  initial begin
  
    // test case 1
    funct = 6'b000000;
    aluop = 2'b00;

    #10;

    // test case 2
    funct = 6'b000011;
    aluop = 2'b10;
    #5; 
    $display("ALU Control: %b", aluctrl);

    // test case 3
    funct = 6'b000100;
    aluop = 2'b10;
    #5; 
    $display("ALU Control: %b", aluctrl);

    
    funct = 6'b000000;
    aluop = 2'b10;
    #5; 
    $display("ALU Control: %b", aluctrl);

    #100 $finish;
  end

endmodule

