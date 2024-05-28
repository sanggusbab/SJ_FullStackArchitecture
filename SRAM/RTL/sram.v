module sram #(parameter AW = 2,
              DW = 2)
             (clk,
              nWE,
              adr,
              d_in,
              d_out);
    // AW: Address Width
    // DW: Data Width
    input clk;
    input nWE;
    input[AW-1:0] adr;
    input[DW-1:0] d_in;
    output reg[DW-1:0] d_out;
    
    reg[DW-1:0] DataStorage[(1<<AW)-1:0];
    
    always @(posedge clk) begin
        if (nWE) begin
            d_out[DW-1:0] <= #5 DataStorage[adr][DW-1:0];
        end
        else begin
            DataStorage[adr][DW-1:0] <= #5 d_in;
        end
    end
    
endmodule
