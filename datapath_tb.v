module datapath_tb;

    reg clk;
    reg [12:0] ControlWord;
    reg [3:0] ConstantIn;
    reg [3:0] data_in;
    
    wire [3:0] Reg0, Reg1, Reg2, Reg3;

    datapath DATA(.clk(clk), .ControlWord(ControlWord), .ConstantIn(ConstantIn), .data_in(data_in), .Reg0(Reg0), .Reg1(Reg1), .Reg2(Reg2), .Reg3(Reg3));

    initial begin
        clk = 0;
        ControlWord <= 13'b0_0000_0000_0000;
        ConstantIn <= 4'b0000;
        data_in <= 4'b0000;

        #10 data_in <= 4'b0100;
        ControlWord <= 13'b0_0000_0000_0011;

        #10 data_in <= 4'b0101;
        ControlWord <= 13'b0_1000_0000_0011;

        #10 data_in <= 4'b0101;
        ControlWord <= 13'b0_1000_0000_0011;

        #10 data_in <= 4'b0101;
        ControlWord <= 13'b0_1000_0000_0011;

        #10 data_in <= 4'b0110;
        ControlWord <= 13'b1_1000_0000_0011;

        #10 ControlWord <= 13'b1_1000_1000_0101;
        ConstantIn <= 4'b0000;
        data_in <= 4'b0000;

        #10 ControlWord <= 13'b1_1000_1000_0101;
        ConstantIn <= 4'b0000;
        data_in <= 4'b0011;
    end

    always #5 clk = ~clk;

endmodule