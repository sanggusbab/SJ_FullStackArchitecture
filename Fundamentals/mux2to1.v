module mux2to1(A, B, out, sel); //connect AC LC
    input [3:0] A;
    input [3:0] B;
    input sel;
    output reg [3:0] out;

    always @(A or B or sel) begin
        case (sel)
            1'b0 : out = A;
            1'b1 : out = B;
        endcase
    end

endmodule