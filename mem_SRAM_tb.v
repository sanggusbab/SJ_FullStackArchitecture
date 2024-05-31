module mem_SRAM_tb;

    parameter A_WIDTH = 8;
    parameter D_WIDTH = 32;
    parameter DEPTH = (1 << A_WIDTH);

    reg clk;
    reg nWE;

    reg [A_WIDTH-1:0] addr;
    reg [D_WIDTH-1:0] data_in;
    wire [D_WIDTH-1:0] data_out;

    mem_SRAM #(.A_WIDTH(A_WIDTH), .D_WIDTH(D_WIDTH), .DEPTH(DEPTH)) SRAM (.clk(clk), .nWE(nWE), .addr(addr), .data_in(data_in), .data_out(data_out));

    initial begin
        clk = 0;
        nWE = 1;
        addr = 0;
        data_in = 0;
    end

    always #5 clk = ~clk;
    always #20 nWE = ~nWE;

    initial @(posedge clk) begin
        #10
        addr = 8'h22;
        data_in = 32'h01234567;

        #11
        addr = 8'h01;
        data_in = 32'h12345678; 

        #12
        addr = 8'h14;
        data_in = 32'h23456789;

        #13
        addr = 8'h01;
    end
    endmodule