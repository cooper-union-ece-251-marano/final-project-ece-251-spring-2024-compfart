//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: alu
//     Description: 16-bit RISC-based CPU alu (MIPS)
//
// 
// 
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

module alu (
    input logic [15:0] a, b,
    input logic [2:0] ctrl,
    output logic [15:0] res,
    output logic zero
    );
    
    `define AND 3'b000
    `define OR  3'b001
    `define ADD 3'b010
    `define SLL 3'b011
    `define NOR 3'b100
    `define SRL 3'b101
    `define SUB 3'b110
    `define SLT 3'b111
    
    always @* begin
    case (ctrl)
        `AND: res <= a & b;     
        `OR : res <= a | b;     
        `ADD: res <= a + b;     
        `SLL: res <= a << b;   
        `NOR: res <= ~(a | b);  
        `SRL: res <= a >> b;    
        `SUB: res <= a - b;     
        `SLT: begin                
            if (a[15] != b[15])
                res <= (a[15] > b[15]);
            else
                res <= (a < b);
        end
        default: res <= 0;
    endcase
end

endmodule

`endif // ALU
