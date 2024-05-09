////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineers: Lamiah Khan and Megan Vo
// 
// Create Date: 2023-02-07
// Module Name: tb_maindec
// Description: Test bench for simple behavioral main decoder
//
// Revision: 1.0
// citation: https://www.ece.ucdavis.edu/~bbaas/281/notes/Handout.verilog6.pdf 
//provided a lot of useful info about this decoder design! 
////////////////////////////////////////////////////////////////////////////////

module tb_maindec();
    logic [3:0] op;
    logic rw, branch, mw;
    logic [1:0] rdst, mtr, jump, alusrc;
    logic [2:0] aluctrl;

    reg clk, reset;

    logic [71:0] test[0:1000];
    logic [15:0] i, errors;
    logic exp_rw, exp_branch, exp_mw;
    logic [1:0] exp_rdst, exp_mtr, exp_jump, exp_alusrc;
    logic [2:0] exp_aluctrl;


    maindec uut (
             .op(op),
             .rw(rw),
             .rdst(rdst),
             .branch(branch),
             .mw(mw),
             .mtr(mtr),
             .jump(jump),
             .alusrc(alusrc),
             .aluctrl(aluctrl)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_maindec.vcd");
        $dumpvars(0, uut);

        // Define test vectors directly in the testbench
        // r-type
        test[0]  = {4'b0000, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b010};
        test[1]  = {4'b0001, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b110};
        test[2]  = {4'b0010, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b010};
        test[3]  = {4'b0011, 1'b0, 1'b0, 1'b0, 2'b00, 2'b00, 2'b10, 2'b00, 3'b010};
        test[4]  = {4'b0100, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b000};
        test[5]  = {4'b0101, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b001};
        test[6]  = {4'b0110, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b10, 3'b011};
        test[7]  = {4'b0111, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b10, 3'b101};
        test[8]  = {4'b1000, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b111};
        // i-type
        test[9]  = {4'b1001, 1'b0, 1'b0, 1'b0, 2'b10, 2'b00, 2'b00, 2'b00, 3'b110};
        test[10] = {4'b1010, 1'b1, 1'b0, 1'b0, 2'b00, 2'b00, 2'b00, 2'b01, 3'b010};
        test[11] = {4'b1011, 1'b1, 1'b0, 1'b0, 2'b00, 2'b00, 2'b00, 2'b01, 3'b110};
        test[12] = {4'b1100, 1'b1, 1'b0, 1'b0, 2'b00, 2'b01, 2'b00, 2'b01, 3'b010};
        test[13] = {4'b1101, 1'b0, 1'b0, 1'b0, 2'b01, 2'b00, 2'b00, 2'b01, 3'b010};
        // j-type
        test[14] = {4'b1110, 1'b0, 1'b0, 1'b0, 2'b00, 2'b00, 2'b01, 2'b00, 3'b010};
        test[15] = {4'b1111, 1'b1, 1'b1, 1'b0, 2'b00, 2'b10, 2'b01, 2'b00, 3'b010};

        i = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

     always @(posedge clk) begin
        #1;
        {op, exp_rw, exp_rdst, exp_branch, exp_mw, exp_mtr, exp_jump, exp_alusrc, exp_aluctrl} = test[i];
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({rw, rdst, branch, mw, mtr, jump, alusrc, aluctrl} !== {exp_rw, expected_rdst, exp_branch, exp_mw, exp_mtr, exp_jump, exp_alusrc, exp_aluctrl}) begin
                $display("Error:\tinput: op %b", op);
                $display("\tcontrol results = %b\n\texpected result = %b", {rw, rdst, branch, mw, mtr, jump, alusrc, aluctrl}, {exp_rw, exp_rdst, exp_branch, exp_mw, exp_mtr, exp_jump, exp_alusrc, exp_aluctrl});
                errors = errors++;
            end
            i = i++;
            if (test[i] === 72'hx) begin
                $display("%d tests finished with %d errors", vectornum, errors);
                $finish;
            end
        end
    end
endmodule
