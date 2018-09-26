module eightbit_palu (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] f,
    output ovf);

    reg f, ovf;

    always @(sel, a, b)
        case (sel)
            0: {ovf, f} = a + b;
            1: {ovf, f} = {1'b0, ~b};
            2: {ovf, f} = {1'b0, a & b};
            3: {ovf, f} = {1'b0, a | b};
        endcase
endmodule

module test_eightbit_palu;
    reg [1:0] sel;
    reg [7:0] a, b;

    wire [7:0] f;
    wire ovf;

    eightbit_palu uut(
        .sel(sel),
        .a(a),
        .b(b),
        .f(f),
        .ovf(ovf));

    initial begin
        $monitor("%d sel=%2b a=%d (%8b), b=%d (%8b) -> f=%d (%8b), ovf=%b",
                 $time, sel, a, a, b, b, f, f, ovf);

        #10 sel = 0;
            a   = 8'b00000001;
            b   = 8'b00000000;
        #10 a   = 8'b01010100;
            b   = 8'b10101010;
        #10 a   = 8'b10101011;
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

        #10 $finish;
    end
endmodule
