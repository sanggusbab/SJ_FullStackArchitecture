module inputLogic(B_data, sel, B_out);
    input [3:0] B_data;
    input [1:0] sel;
    output [3:0] B_out;

    mux4to1 Inputlogmux (.A(0), .B(~B_data), .C(B_data), .D(1), .sel(sel), .out(B_out));
endmodule