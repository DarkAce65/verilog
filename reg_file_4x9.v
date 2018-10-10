module reg_file_4x9 (
    input rst,
    input clk,
    input [1:0] rd0_addr,
    input [1:0] rd1_addr,
    input wr_en,
    input [1:0] wr_addr,
    input [8:0] wr_data,
    output [8:0] rd0_data,
    output [8:0] rd1_data
);

    integer i;
    reg [8:0] data[0:3];

    assign rd0_data = data[rd0_addr];
    assign rd1_data = data[rd1_addr];

    always @(negedge clk, posedge rst)
        if (rst)
            for (i = 0; i < 4; i = i + 1)
                data[i] = 0;
        else if (wr_en)
            data[wr_addr] = wr_data;
endmodule

module reg_file_4x9_tb;
    reg rst, clk, wr_en;
    reg [1:0] rd0_addr, rd1_addr, wr_addr;
    reg [8:0] wr_data;
    wire [8:0] rd0_data, rd1_data;

    reg_file_4x9 uut(
        .rst(rst),
        .clk(clk),
        .rd0_addr(rd0_addr),
        .rd1_addr(rd1_addr),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .rd0_data(rd0_data),
        .rd1_data(rd1_data)
    );

    initial begin
        rst = 1;
        #10 rst = 0;
    end

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor({
            "%d clk=%b rd0_addr=%b -> rd0_data=%9b\n",
            {27{" "}}, "rd1_addr=%b -> rd1_data=%9b\n",
            {27{" "}}, "wr_en=%b, wr_addr=%b, wr_data=%9b"
        }, $time, clk, rd0_addr, rd0_data, rd1_addr, rd1_data, wr_en, wr_addr, wr_data);

        #10 rd0_addr = 0;
            rd1_addr = 2;
            wr_en = 0;
            wr_addr = 0;
            wr_data = 0;
        #10 wr_en = 1;
            wr_addr = 1;
            wr_data = 13;
        #10 wr_addr = 0;
            wr_data = 117;
        #10 wr_en = 0;
            wr_data = 0;
            rd1_addr = 1;
        #10 $finish;
    end
endmodule
