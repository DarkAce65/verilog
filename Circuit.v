module CircuitStructural (
   input a,
   input b,
   input c,
   output d,
   output e);

   wire w;

   and G1 (w, a, b);
   not G2 (e, c);
   or  G3 (d, w, e);

endmodule

module CircuitDataflow (
    input a,
    input b,
    input c,
    output d,
    output e);

    assign d = (a & b) | ~c;
    assign e = ~c;
endmodule

module CircuitBehavioral (
    input a,
    input b,
    input c,
    output d,
    output e);

    reg d, e;

    always @(a, b, c)
        case ({a, b, c})
            0: {d, e} = 2'b11;
            1: {d, e} = 2'b00;
            2: {d, e} = 2'b11;
            3: {d, e} = 2'b00;
            4: {d, e} = 2'b11;
            5: {d, e} = 2'b00;
            6: {d, e} = 2'b11;
            7: {d, e} = 2'b10;
        endcase
endmodule

module TestCircuit;
    reg a, b, c;
    wire d, e;
    CircuitStructural m1(a, b, c, d, e);
    initial begin
        $monitor("%d abc=%b%b%b de=%b%b", $time, a, b, c, d, e);

        #10 {a, b, c} = 0;
        #10 {a, b, c} = 1;
        #10 {a, b, c} = 2;

        #10 $finish;
    end
endmodule
