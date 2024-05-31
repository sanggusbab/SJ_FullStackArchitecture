module datapath(clk, ControlWord, ConstantIn, data_in, Reg0, Reg1, Reg2, Reg3);
    input clk;
    input [12:0] ControlWord;
    input [3:0] ConstantIn;
    input [3:0] data_in;

    output [3:0] Reg0, Reg1, Reg2, Reg3;

    wire [3:0] A, B, C, D;
    wire [3:0] F_out;

    assign C = (ControlWord[6])? ConstantIn : B;
    assign D = (ControlWord[1])? data_in : F_out;

    register RF(.clk(clk), .nWE(ControlWord[0]), .A_addr(ControlWord[10:9]), .B_addr(ControlWord[8:7]), .D_addr(D),
                .D_data(D), .A_data(A), .B_data(B), .Reg0(Reg0), .Reg1(Reg1), .Reg2(Reg2), .Reg3(Reg3));
    FunctionUnit FU(.clk(clk), .A_data(A), .B_data(C), .F_sel(ControlWord[5:2]), .F_out(F_out));

endmodule

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


// module Arithmetic(clk, A, B, C_in, sel, G_out, C_out);
//     parameter sel_LENGTH = 2;
//     parameter data_LENGTH = (sel_LENGTH >> 1);
    
//     input clk;
//     input [data_LENGTH-1:0] A;
//     input [data_LENGTH-1:0] B;
//     input [sel_LENGTH-1:0] sel;

//     output C_out;
//     output reg [data_LENGTH-1:0] G_out;
    
//     wire Y;

//     always @(posedge clk) begin
//         case (sel) // MUX
//             2'b00 : Y <= 0;
//             2'b01 : Y <= B;
//             2'b10 : Y <= ~B;
//             2'b11 : Y <= (1 << data_LENGTH)-1;
//         endcase
//     end

//     assign {C_out, G_out[sel_LENGTH-1:0]} = A[data_LENGTH-1:0] + B[data_LENGTH-1:0] + C_in;

// endmodule