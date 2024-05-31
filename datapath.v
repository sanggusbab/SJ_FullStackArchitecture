//ALU = AC + LC
module ALU(AC, LC, sel, G_out);
    input AC;
    input LC;
    input sel;
    output G_out;

    mux2to1 ALUmux (.A(AC), .B(LC), .out(G_out), .sel(sel))
endmodule

module Arithmetic(clk, A, B, C_in, sel, G_out, C_out);
    parameter sel_LENGTH = 2;
    parameter data_LENGTH = (sel_LENGTH >> 1);
    
    input clk;
    input [data_LENGTH-1:0] A;
    input [data_LENGTH-1:0] B;
    input [sel_LENGTH-1:0] sel;

    output C_out;
    output reg [data_LENGTH-1:0] G_out;
    
    wire Y;

    always @(posedge clk) begin
        case (sel) // MUX
            2'b00 : Y <= 4'b0000;
            2'b01 : Y <= B;
            2'b10 : Y <= ~B;
            2'b11 : Y <= 4'b1111; // binar = (data_LENGTH >> 1); Y<= binar-1;
        endcase
    end

    assign {C_out, G_out[sel_LENGTH-1:0]} = A[data_LENGTH-1:0] + B[data_LENGTH-1:0] + C_in;

endmodule

module Logic(clk, A, B, sel, G_out);
    parameter sel_LENGTH = 2;
    parameter data_LENGTH = (sel_LENGTH >> 1);

    input clk;
    input [data_LENGTH-1:0] A;
    input [data_LENGTH-1:0] B;
    input [sel_LENGTH-1:0] sel;

    output [data_LENGTH-1:0] G_out;

    always @(pose clk) begin
        case (sel) // MUX
            2'b00 : G_out = A & B;
            2'b01 : G_out = A | B;
            2'b10 : G_out = A ^ B;
            2'b11 : G_out = ~A;
        endcase
    end
endmodule

module mux2to1(A, B, out, sel); //connect AC LC
    input [3:0] A;
    input [3:0] B;
    input sel;
    output [3:0] out;

    always @(A or B or sel) begin
        if (sel == 0) begin
        out = A;
        end

        else begin 
        out = B;
        end
    end

    endmodule

module mux4to1(A, B, C, D, sel, out);
    input [3:0] A, B, C, D;
    input [1:0] sel;
    output reg [3:0] out;

    always @(A or B or C or D or sel) begin
        case (sel)
            2'b00 : out = A;
            2'b01 : out = B;
            2'b10 : out = C;
            2'b11 : out = D;
        endcase
    end
endmodule


module decoder2to4(data_in, data_out);
    input [1:0] data_in;
    output reg [3:0] data_out;

    always @(data_in or data_out) begin
        case (data_in)
            2'b00 : data_out = 4'b0001;
            2'b01 : data_out = 4'b0010;
            2'b10 : data_out = 4'b0100;
            2'b11 : data_out = 4'b1000
        endcase
    end
endmodule

module registerFile(clk, nWE, A_addr, B_addr, D_addr, D_data, A_data, B_data, Reg0, Reg1, Reg2, Reg3);

    input clk;
    input nWE;
    input [3:0] D_data;
    input [1:0] A_addr, B_addr, D_addr;
    output [3:0] A_data;
    output [3:0] B_data;
    output reg [3:0] Reg0, Reg1, Reg2, Reg3;

    wire [3:0] dec_out;
    decoder2to4 dec1(.data_in(D_addr), .data_out(dec_out));

    mux4to1 mux4to1_0(.A(Reg0), .B(Reg1), .C(Reg2), .D(Reg3), .sel(A_addr), out(A_data));
    mux4to1 mux4to1_0(.A(Reg0), .B(Reg1), .C(Reg2), .D(Reg3), .sel(B_addr), out(B_data));

    initial begin
        Reg0 <= 4'b000;
        Reg1 <= 4'b000;
        Reg2 <= 4'b000;
        Reg3 <= 4'b000;
    end

    always @(posedge clk) begin
        if (~nWE) begin
            case(dec_out)
            4'
        end

    end


endmodule