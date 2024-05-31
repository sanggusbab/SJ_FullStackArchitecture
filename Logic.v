module Logic(clk, A, B, sel, G_out);
    parameter sel_LENGTH = 2;
    parameter data_LENGTH = (sel_LENGTH >> 1);

    input clk;
    input [data_LENGTH-1:0] A;
    input [data_LENGTH-1:0] B;
    input [sel_LENGTH-1:0] sel;

    output reg [data_LENGTH-1:0] G_out;

    always @(posedge clk) begin
        case (sel) // MUX
            2'b00 : G_out = A & B;
            2'b01 : G_out = A | B;
            2'b10 : G_out = A ^ B;
            2'b11 : G_out = ~A;
        endcase
    end
endmodule