module register(clk, nWE, A_addr, B_addr, D_addr, D_data, A_data, B_data, Reg0, Reg1, Reg2, Reg3);

    input clk;
    input nWE;
    input [3:0] D_data;
    input [1:0] A_addr, B_addr, D_addr;
    output [3:0] A_data;
    output [3:0] B_data;
    output reg [3:0] Reg0, Reg1, Reg2, Reg3;

    wire [3:0] dec_out;
    decoder2to4 dec1(.data_in(D_addr), .data_out(dec_out));

    mux4to1 mux4to1_0(.A(Reg0), .B(Reg1), .C(Reg2), .D(Reg3), .sel(A_addr), .out(A_data));
    mux4to1 mux4to1_1(.A(Reg0), .B(Reg1), .C(Reg2), .D(Reg3), .sel(B_addr), .out(B_data));

    initial begin //init setting
        Reg0 <= 4'b000;
        Reg1 <= 4'b000;
        Reg2 <= 4'b000;
        Reg3 <= 4'b000;
    end

    always @(posedge clk) begin
        if (~nWE) begin
            case(dec_out)
            4'b0001: Reg0 <= D_data;
            4'b0010: Reg1 <= D_data;
            4'b0100: Reg2 <= D_data;
            4'b1000: Reg3 <= D_data;
            endcase
        end
        end
endmodule