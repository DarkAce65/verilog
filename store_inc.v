module store_inc (
    input clock,
    input clear,
    input inc,
    output reg [31:0] store
);

    always @(negedge clock, posedge clear)
        if (clear)
            store = 0;
        else if (inc)
            store = store + 3;
endmodule

module store_inc_tb;
    reg clock, clear, inc;
    wire [31:0] store;

    store_inc uut(
        .clock(clock),
        .clear(clear),
        .inc(inc),
        .store(store)
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
        $monitor("%d clock=%b inc=%b -> store=%d", $time, clock, inc, store);

        #10 inc = 1;
        #50 inc = 0;
        #30 inc = 1;
        #10 $finish;
    end
endmodule
