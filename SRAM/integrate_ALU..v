//ALU = AC + LC
module integrate_ALU(AC, LC, sel, G_out);
    input AC;
    input LC;
    input sel;
    output G_out;

    mux2to1 ALUmux (.A(AC), .B(LC), .out(G_out), .sel(sel));
endmodule