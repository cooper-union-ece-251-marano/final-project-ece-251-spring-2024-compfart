module assembler;

// Define opcodes and registers
typedef enum logic [7:0] {
    add = 8'h0,
    sub = 8'h1,
    move = 8'h2',
    jr = 8'h3',
    and = 8'h4',
    or = 8'h5',
    sll = 8'h6',
    srl = 8'h7',
    slt = 8'h8',
    beq = 8'h9',
    addi = 8'hA',
    subi = 8'hB',
    lw = 8'hC',
    sw = 8'hD',
    j = 8'hE',
    jal = 8'hF'
} opcode_t;

typedef enum logic [7:0] {
    zero = 8'h0,
    at = 8'h1,
    v0 = 8'h2',
    v1 = 8'h3',
    a0 = 8'h4',
    a1 = 8'h5',
    t0 = 8'h6',
    t1 = 8'h7',
    t2 = 8'h8',
    t3 = 8'h9',
    s0 = 8'hA',
    s1 = 8'hB',
    s2 = 8'hC',
    s3 = 8'hD',
    sp = 8'hE',
    ra = 8'hF'
} register_t;

function logic [31:0] asm_instr(input string instr);
    string tokens[$];
    instr.tokenize(" ,)(#", tokens);

    foreach (tokens[i]) begin
        if (tokens[i] in OP_CODES)
            tokens[i] = OP_CODES[tokens[i]];
        else if (tokens[i] in REGISTERS)
            tokens[i] = REGISTERS[tokens[i]];
        else
            tokens[i] = $urandom_range(32'h0, 32'hFFFF_FFFF);
    end

    case (tokens[0])
        add: asm_instruction = {8'b0000_0000, tokens[2:0], tokens[5:3], tokens[8:6]};
        sub: asm_instruction = {8'b0000_0001, tokens[2:0], tokens[5:3], tokens[8:6]};
        move: asm_instruction = {8'b0000_0010, tokens[2:0], tokens[5:3], 5'b00000};
        jr: asm_instruction = {8'b0000_0011, tokens[2:0], 13'b000_0000_0000};
        and: asm_instruction = {8'b0000_0100, tokens[2:0], tokens[5:3], tokens[8:6]};
        or: asm_instruction = {8'b0000_0101, tokens[2:0], tokens[5:3], tokens[8:6]};
        sll: asm_instruction = {8'b0000_0110, tokens[2:0], tokens[5:3], tokens[8:6]};
        srl: asm_instruction = {8'b0000_0111, tokens[2:0], tokens[5:3], tokens[8:6]};
        slt: asm_instruction = {8'b0000_1000, tokens[2:0], tokens[5:3], tokens[8:6]};
        beq: asm_instruction = {8'b0000_1001, tokens[2:0], tokens[5:3], tokens[8:6]};
        addi: asm_instruction = {8'b0000_1010, tokens[2:0], tokens[5:3], tokens[8:6]};
        subi: asm_instruction = {8'b0000_1011, tokens[2:0], tokens[5:3], tokens[8:6]};
        lw: asm_instruction = {8'b0000_1100, tokens[2:0], tokens[5:3], tokens[8:6]};
        sw: asm_instruction = {8'b0000_1101, tokens[2:0], tokens[5:3], tokens[8:6]};
        j: asm_instruction = {8'b0000_1110, tokens[2:0], 13'b000_0000_0000};
        jal: asm_instruction = {8'b0000_1111, tokens[2:0], 13'b000_0000_0000};
        default: asm_instruction = 32'h0; // Default instruction
    endcase
endfunction

module top;
   
    string OP_CODES[string] = {
        "add": "0x0",
        "sub": "0x1",
        "move": "0x2",
        "jr": "0x3",
        "and": "0x4",
        "or": "0x5",
        "sll": "0x6",
        "srl": "0x7",
        "slt": "0x8",
        "beq": "0x9",
        "addi": "0xA",
        "subi": "0xB",
        "lw": "0xC",
        "sw": "0xD",
        "j": "0xE",
        "jal": "0xF"
    };

    string REGISTERS[string] = {
        "$zero": "0",
        "$at": "1",
        "$v0": "2",
        "$v1": "3",
        "$a0": "4",
        "$a1": "5",
        "$t0": "6",
        "$t1": "7",
        "$t2": "8",
        "$t3": "9",
        "$s0": "A",
        "$s1": "B",
        "$s2": "C",
        "$s3": "D",
        "$sp": "E",
        "$ra": "F"
    };

    string input_file[$];
    initial begin

        if (!$value$plusargs("INPUT_FILE=%s", input_file)) begin
            input_file = {"fib.asm"}; 
        end

        $fopen(input_file, input_file[0], "r");

        // Check if input file opened successfully
        if (!$feof(input_file)) begin
            string line[$];
            while (!$feof(input_file)) begin
                $fgets(line, input_file);
                logic [31:0] machine_code = asm_instr(line);
                $display("Machine code for line '%s': %h", line, machine_code);
            end

            $fclose(input_file);
        end else begin
            $display("Error: Unable to open input file.");
            $finish;
        end
    end
endmodule

endmodule
