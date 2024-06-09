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