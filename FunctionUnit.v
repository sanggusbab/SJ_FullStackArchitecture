module FunctionUnit(clk, A_data, B_data, F_sel, F_out);
    input clk;
    input [3:0] A_data;
    input [3:0] B_data;
    input [3:0] F_sel;
    output [3:0] F_out;

    wire [3:0] L_out, A_out;
    wire C_out; //not use

    Logic Logic_0(.clk(clk), .A(A_data), .B(B_data), .sel(F_sel[2:1]), .G_out(L_out));
    arithmetic Arithmetic_0(.clk(clk), .A(A_data), .B(B_data), .C_in(F_sel[0]), .sel(F_sel[2:1]), .G_out(A_out), .C_out(C_out));

    mux2to1 FUmux(.A(A_out), .B(L_out), .out(F_out), .sel(F_sel[3]));
endmodule

module inputLogic(B_data, sel, B_out);
    input [3:0] B_data;
    input [1:0] sel;
    output [3:0] B_out;

    mux4to1 Inputlogmux (.A(0), .B(~B_data), .C(B_data), .D(1), .sel(sel), .out(B_out));
endmodule