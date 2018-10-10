module reg_file_32x32 (
    input clear,
    input clock,
    input [4:0] read_index1,
    input write1,
    input [4:0] write_index1,
    input [31:0] write_data1,
    input write2,
    input [4:0] write_index2,
    input [31:0] write_data2,
    output [31:0] read_value
);

    reg [31:0] data[0:31];
    integer i;

    assign read_value = data[read_index1];

    always @(negedge clock, posedge clear)
        if (clear)
            for (i = 0; i < 32; i = i + 1)
                data[i] = 0;
        else begin
            if (write2)
                data[write_index2] = write_data2;
            if (write1)
                data[write_index1] = write_data1;
        end
endmodule

module reg_file_32x32_tb;
    reg clear, clock, write1, write2;
    reg [4:0] read_index1, write_index1, write_index2;
    reg [31:0] write_data1, write_data2;
    wire [31:0] read_value;

    reg_file_32x32 uut (
        .clear(clear),
        .clock(clock),
        .read_index1(read_index1),
        .write1(write1),
        .write_index1(write_index1),
        .write_data1(write_data1),
        .write2(write2),
        .write_index2(write_index2),
        .write_data2(write_data2),
        .read_value(read_value)
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
        $monitor({
            "%d clock=%b clear=%b\n",
            {21{" "}}, "read_index1=%0d -> read_value=%0d\n",
            {21{" "}}, "write1=%b, write_index1=%0d, write_data1=%0d\n",
            {21{" "}}, "write2=%b, write_index2=%0d, write_data2=%0d"
        }, $time, clock, clear, read_index1, read_value, write1, write_index1, write_data1, write2, write_index2, write_data2);

        #10 read_index1 = 0;
            write1 = 0;
            write_index1 = 0;
            write_data1 = 0;
            write2 = 0;
            write_index2 = 0;
            write_data2 = 0;

        #10 read_index1 = 1;
            write1 = 1;
            write_index1 = 1;
            write_data1 = 25;

        #10 read_index1 = 7;
            write1 = 0;
            write2 = 1;
            write_index2 = 7;
            write_data2 = 625;

        #10 read_index1 = 4;
            write1 = 1;
            write_index1 = 4;
            write_data1 = 3739;
            write2 = 1;
            write_index2 = 4;
            write_data2 = 4295;

        #10 $finish;
    end
endmodule
