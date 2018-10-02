module eightbit_alu(input signed [7:0] a, input signed [7:0] b,
                    input [2:0] sel,
                    output reg signed [7:0] f,
                    output reg ovf, output reg take_branch);

    always @(a, b, sel)
        case (sel)
            0:  begin
                    {ovf, f} = a + b;
                    ovf = (a[7] ^ f[7]) & (b[7] ^ f[7]);
                    take_branch = 0;
                end
            1: {f, ovf, take_branch} = {~b, 2'b00};
            2: {f, ovf, take_branch} = {a & b, 2'b00};
            3: {f, ovf, take_branch} = {a | b, 2'b00};
            4: {f, ovf, take_branch} = {a >>> 1, 2'b00};
            5: {f, ovf, take_branch} = {a << 1, 2'b00};
            6: {f, ovf, take_branch} = {9'b000000000, a === b};
            7: {f, ovf, take_branch} = {9'b000000000, a !== b};
        endcase
endmodule

module eightbit_alu_tb;
    reg signed [7:0] a, b;
    reg [2:0] sel;

    wire signed [7:0] f;
    wire ovf, take_branch;

    eightbit_alu uut(
        .a(a),
        .b(b),
        .sel(sel),
        .f(f),
        .ovf(ovf),
        .take_branch(take_branch));

    initial begin
        $monitor("%d sel=%d, a=%d (%8b), b=%d (%8b) -> f=%d (%8b), ovf=%b, take_branch=%b", $time, sel, a, a, b, b, f, f, ovf, take_branch);

        #10 sel = 0;
            a   = 8'b00000001;
            b   = 8'b00000000;
        #10 a   = 8'b11010100;
            b   = 8'b10101010;
        #10 a   = 8'b00101011;
            b   = 8'b01010101;

        #10 sel = 1;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 sel = 2;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 sel = 3;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 sel = 4;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 sel = 5;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 sel = 6;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 sel = 7;
            a   = 8'b00000000;
            b   = 8'b00000000;
        #10 a   = 8'b01010101;
            b   = 8'b10101010;
        #10 a   = 8'b11111111;
            b   = 8'b11111111;

        #10 $finish;
    end
endmodule
