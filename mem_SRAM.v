module mem_SRAM(
    clk, nWE, addr, data_in, data_out
);

    parameter A_WIDTH = 8;
    parameter D_WIDTH = 32;
    parameter DEPTH = (1 << A_WIDTH);

    input clk;
    input nWE;
    input [A_WIDTH-1:0] addr;
    input [D_WIDTH-1:0] data_in;
    output reg [D_WIDTH-1:0] data_out;

    reg [D_WIDTH-1:0] SRAM [0:DEPTH-1];

    integer i;

    initial begin
        // SRAM 초기화
        for (i = 0; i < DEPTH; i = i + 1) begin
            SRAM[i] = 0;
        end
    end

    always @(posedge clk) begin
        if (~nWE) begin
            SRAM[addr] <= data_in;
        end else begin
            data_out <= SRAM[addr];
        end
    end

endmodule