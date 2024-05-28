module sram_tb;
    parameter AW = 4; // AW: Address Width
    parameter DW = 32; // DW: Data Width

    reg[AW-1:0] adr;
    reg[DW-1:0] d_in;
    wire[DW-1:0] d_out;

    SRAM SRAM01 #(.AW(AW), .DW(DW)) (.clk(clk), .nWE(nWE), .adr(adr), .d_in(d_in), .d_out(d_out));
    
    initial begin
        clk = 0;
        nWE = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        integer fp;
        integer read_data;
        integer addr=0;
        integer data;
        
        fp = $fopen("../etc/initialData.txt", "r");
        if (fp) begin
            while (!$feof(fp)) begin
                if(addr < 24) begin
                    read_data = $fscanf(fp, "%h\n", data);
                    adr = addr;
                    addr = addr+1;
                    d_in = data;
                    @(posedge clk); // Wait for the positive edge of the clock
                    #2;
                end
                else begin
                    nWE = 1;
                    read_data = $fscanf(fp, "%h\n", data);
                    adr = addr;
                    addr = addr+1;
                    d_in = data;
                    @(posedge clk); // Wait for the positive edge of the clock
                    #2;
                end
            end
        end
        $fclose(fp);
    end

endmodule
