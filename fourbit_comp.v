module fourbit_comp(input[3:0] a,
                    input[3:0] b,
                    output eq,
                    output lt,
                    output gt);

    wire[3:0] na;
    wire[3:0] x;

    not(na[3], a[3]);
    not(na[2], a[2]);
    not(na[1], a[1]);
    not(na[0], a[0]);

    xnor(x[3], a[3], b[3]);
    xnor(x[2], a[2], b[2]);
    xnor(x[1], a[1], b[1]);
    xnor(x[0], a[0], b[0]);

    and(eq, x[3], x[2], x[1], x[0]);

    wire[3:0] lti;

    and(lti[3], na[3], b[3]);
    and(lti[2], x[3], na[2], b[2]);
    and(lti[1], x[3], x[2], na[1], b[1]);
    and(lti[0], x[3], x[2], x[1], na[0], b[0]);

    or(lt, lti[3], lti[2], lti[1], lti[0]);

    wire neq, nlt;
    not(neq, eq);
    not(nlt, lt);
    and(gt, neq, nlt);
endmodule

module test_fourbit_comp;
    reg[3:0] a, b;

    wire eq, gt, lt;

    fourbit_comp uut(
        .a(a),
        .b(b),
        .eq(eq),
        .lt(lt),
        .gt(gt));

    initial begin
        $monitor("%d a=%d (%4b), b=%d (%4b) -> eq=%b, lt=%b, gt=%b",
                 $time, a, a, b, b, eq, lt, gt);

        #10 a = 4'b0000;
            b = 4'b0000;

        #10 a = 4'b0001;
            b = 4'b0000;

        #10 a = 4'b0000;
            b = 4'b0001;

        #10 a = 4'b1110;
            b = 4'b1111;

        #10 $finish;
    end
endmodule
