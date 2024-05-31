module arithmetic(clk, A, B, C_in, sel, G_out, C_out);
    parameter sel_LENGTH = 2;
    parameter data_LENGTH = (sel_LENGTH >> 1);
    
    input clk;
    input [data_LENGTH-1:0] A;
    input [data_LENGTH-1:0] B;
    input C_in;
    input [sel_LENGTH-1:0] sel;

    output wire C_out;
    output wire [data_LENGTH-1:0] G_out;
    
    reg [data_LENGTH-1:0] Y;

    always @(posedge clk) begin
        case (sel) // MUX
            2'b00 : Y <= 4'b0000;
            2'b01 : Y <= B;
            2'b10 : Y <= ~B;
            2'b11 : Y <= 4'b1111; // binar = (data_LENGTH >> 1); Y<= binar-1;
        endcase
    end

    assign {C_out, G_out[data_LENGTH-1:0]} = A[data_LENGTH-1:0] + B[data_LENGTH-1:0] + C_in;

endmodule
