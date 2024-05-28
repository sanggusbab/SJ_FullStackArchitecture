module sram_tb;
    parameter AW = 6; // AW: Address Width
    parameter DW = 32; // DW: Data Width

    reg clk;
    reg nWE;
    reg[AW-1:0] adr;
    reg[DW-1:0] d_in;
    wire[DW-1:0] d_out;

    integer fp;
    integer read_data;
    integer addr=0;
    integer data;

    sram #(.AW(AW), .DW(DW)) SRAM01 (.clk(clk), .nWE(nWE), .adr(adr), .d_in(d_in), .d_out(d_out));
    
    initial begin
        clk = 0;
        nWE = 0;
        forever #10 clk = ~clk;
    end

    initial begin 
        fp = $fopen("../etc/initialData.txt", "r"); // 상대경로
        if (fp) begin
            while (!$feof(fp)) begin
                if(addr == 0) begin
                    read_data = $fscanf(fp, "%h\n", data);
                    adr = addr;
                    d_in = data;
                    #30;
                    addr = addr+1;
                    @(posedge clk); // Wait for the positive edge of the clock
                    #2;
                end
                else if(addr < 24) begin
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
        
        forever @(posedge clk) begin
            adr = addr;
            addr = addr+1;
            #2;
        end
    end

endmodule
