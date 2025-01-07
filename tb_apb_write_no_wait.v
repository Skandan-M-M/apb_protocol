/* module tb_apb_write_no_wait;
    reg PCLK, PRESETn;
    reg PSEL, PENABLE, PWRITE;
    reg [31:0] PADDR, PWDATA;
    wire [31:0] PRDATA;
    wire PREADY;

    // Instantiate the modules
    apb_slave slave (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );
    
    apb_master master (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );

    apb_bus_monitor monitor (
        .PCLK(PCLK),
        .PADDR(PADDR),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );

    // Clock generation
    always begin
        PCLK = ~PCLK; #5;
    end

    initial begin
        // Initialize signals
        PRESETn = 0;
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;
        PADDR = 0;
        PWDATA = 0;
        
        // Apply reset
        #10 PRESETn = 1;
        
        // Write Operation without Wait
        #10 PADDR = 32'h0000; PWDATA = 32'h1234; PWRITE = 1; PSEL = 1; PENABLE = 1;
        #10 PSEL = 0; PENABLE = 0;
        
        // Finish the simulation
        #100 $finish;
    end
endmodule */

module tb_apb_read_no_wait;
    reg PCLK, PRESETn;
    reg PSEL, PENABLE, PWRITE;
    reg [31:0] PADDR;
    wire [31:0] PRDATA;
    wire PREADY;

    // Instantiate the modules
    apb_slave slave (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(32'b0),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );
    
    apb_master master (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(32'b0),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );

    apb_bus_monitor monitor (
        .PCLK(PCLK),
        .PADDR(PADDR),
        .PWRITE(PWRITE),
        .PWDATA(32'b0),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );

    // Clock generation
    always begin
        PCLK = ~PCLK; #5;
    end

    initial begin
        // Initialize signals
        PRESETn = 0;
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;
        PADDR = 0;
        
        // Apply reset
        #10 PRESETn = 1;
        
        // Read Operation without Wait
        #10 PADDR = 32'h0000; PSEL = 1; PENABLE = 1;
        #10 PSEL = 0; PENABLE = 0;
        
        // Finish the simulation
        #100 $finish;
    end
endmodule


