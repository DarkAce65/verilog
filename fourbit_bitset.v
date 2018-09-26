module fourbit_bitset(input[3:0] x,
                      input[1:0] index,
                      input value,
                      output[3:0] y);

    wire[3:0] x3, x2, x1, x0;

    assign x3 = {value, x[2:0]};
    assign x2 = {x[3], value, x[1:0]};
    assign x1 = {x[3:2], value, x[0]};
    assign x0 = {x[3:1], value};

    fourbit_4to1mux mux(
        .sel(index),
        .i3(x3),
        .i2(x2),
        .i1(x1),
        .i0(x0),
        .y(y));
endmodule

module test_fourbit_bitset;
    reg[3:0] x;
    reg[1:0] index;
    reg value;

    wire[3:0] y;

    fourbit_bitset uut(
        .x(x),
        .index(index),
        .value(value),
        .y(y));

    initial begin
        $monitor("%d x=%4b, index=%2b, value=%b -> y=%4b",
                 $time, x, index, value, y);

        #10 x     = 4'b0000;
            index = 2'b00;
            value = 1'b0;

        #10 x     = 4'b1111;
            index = 2'b00;
            value = 1'b0;

        #10 x     = 4'b0000;
            index = 2'b01;
            value = 1'b1;

        #10 x     = 4'b0000;
            index = 2'b10;
            value = 1'b1;

        #10 x     = 4'b0000;
            index = 2'b11;
            value = 1'b1;

        #10 $finish;
    end
endmodule
