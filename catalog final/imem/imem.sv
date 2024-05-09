//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-04-27
//     Module Name: imem
//     Description: 16-bit RISC memory (instruction "text" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef imem
`define imem
`timescale 1ns/100ps

module imem (
    input logic [4:0] addr,
    output logic [15:0] instr
    );

    logic [15:0] MEMORY [0:31];

    integer file;

    initial begin
        file = $fopen("program_data.dat", "r"); 
        if (file != 0) begin
            for (int i = 0; i < 32; i = i + 1) begin
                if (!$feof(file)) begin
                    $fscanf(file, "%h", MEMORY[i]); 
                end
            end
            $fclose(file); 
        end else begin
            $display("ERROR: Could not open file for reading.");
        end
    end


    assign instruction = MEMORY[address];

endmodule

`endif // IMEM