//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: aludec                                                      //
//     Description: ALU decoder                                                 //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef ALU
 `define ALU
 
 module alu(alu, aluop, funct);  
 output reg[2:0] alu;  
 input [1:0] aluop;  
 input [3:0] funct;  
 wire [5:0] aluctrl;  
 assign aluctrl = {ALUOp,funct};  
 always @(aluctrl)  
 casex (aluctrl)  
  6'b11xxxx: aluctrl=3'b000;  
  6'b10xxxx: aluctrl=3'b100;  
  6'b01xxxx: aluctrl=3'b001;  
  6'b000000: aluctrl=3'b000;  
  6'b000001: aluctrl=3'b001;  
  6'b000010: aluctrl=3'b010;  
  6'b000011: aluctrl=3'b011;  
  6'b000100: aluctrl=3'b100;  
  default: aluctrl=3'b000;  
  endcase  
 endmodule  


module jr_ctrl( input[1:0] alu_op, 
       input [3:0] funct,
       output jr_ctrl
    );
assign jr_ctrl = ({alu_op,funct}==6'b001000) ? 1'b1 : 1'b0;
endmodule

`endif // ALUDecoder
