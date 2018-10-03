module t_flipflop (
    input clock,
    input clear,
    input t,
    output reg q
);

    always @(negedge clock, posedge clear)
        if (clear)
            q = 0;
        else if (t)
            q = ~q;
endmodule

module t_flipflop_tb;
    reg clock, clear, t;
    wire q;

    t_flipflop uut(
        .clock(clock),
        .clear(clear),
        .t(t),
        .q(q)
    );

    initial begin
        clear = 1;
        #10 clear = 0;
    end

    initial begin
        clock = 1;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor("%d clock=%b t=%b -> q=%b", $time, clock, t, q);

        #10 t = 1;
        #20 t = 0;
        #10 t = 1;
        #20 $finish;
    end
endmodule
