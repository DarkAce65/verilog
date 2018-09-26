module eightbit_comp(input[7:0] a,
                     input[7:0] b,
                     output eq,
                     output lt,
                     output gt);

    wire[7:0] a, b;
    wire hb_eq, hb_lt, hb_gt,
        lb_eq, lb_lt, lb_gt;

    fourbit_comp hb(
        .a(a[7:4]),
        .b(b[7:4]),
        .eq(hb_eq),
        .lt(hb_lt),
        .gt(hb_gt));
    fourbit_comp lb(
        .a(a[3:0]),
        .b(b[3:0]),
        .eq(lb_eq),
        .lt(lb_lt),
        .gt(lb_gt));

    assign eq = hb_eq & lb_eq;
    assign lt = hb_lt & ~hb_eq | lb_lt & hb_eq;
    assign gt = hb_gt & ~hb_eq | lb_gt & hb_eq;
endmodule

module test_eightbit_comp;
    reg[7:0] a, b;

    wire eq, gt, lt;

    eightbit_comp uut(
        .a(a),
        .b(b),
        .eq(eq),
        .lt(lt),
        .gt(gt));

    initial begin
        $monitor("%d a=%d (%4b), b=%d (%4b) -> eq=%b, lt=%b, gt=%b",
                 $time, a, a, b, b, eq, lt, gt);

        #10 a = 8'b00000000;
            b = 8'b00000000;

        #10 a = 8'b00000001;
            b = 8'b00000000;

        #10 a = 8'b00000000;
            b = 8'b00000001;

        #10 a = 8'b00000001;
            b = 8'b00010000;

        #10 a = 8'b00010000;
            b = 8'b00000001;

        #10 a = 8'b11111110;
            b = 8'b11101111;

        #10 a = 8'b11101111;
            b = 8'b11111110;

        #10 $finish;
    end
endmodule
