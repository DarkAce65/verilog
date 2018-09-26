module fourbit_4to1mux(input[1:0] sel,
                       input[3:0] i3,
                       input[3:0] i2,
                       input[3:0] i1,
                       input[3:0] i0,
                       output reg[3:0] y);

    always @(sel, i3, i2, i1, i0)
        case (sel)
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b11: y = i3;
    endcase
endmodule
