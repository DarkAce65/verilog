module d_flipflop (
    input clock,
    input clear,
    input d,
    output reg q
);

    always @(negedge clock, posedge clear)
        if (clear)
            q = 0;
        else
            q = d;
endmodule

module d_flipflop_tb;
    reg clock, clear, d;
    wire q;

    d_flipflop uut(
        .clock(clock),
        .clear(clear),
        .d(d),
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
        $monitor("%d clock=%b d=%b -> q=%b", $time, clock, d, q);

        #10 d = 0;
        #10 d = 1;
        #10 d = 0;
        #10 $finish;
    end
endmodule
