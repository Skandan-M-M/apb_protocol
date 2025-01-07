module tb_apb_write_with_wait;
    reg PCLK, PRESETn;
    reg PSEL, PENABLE, PWRITE;
    reg [31:0] PADDR, PWDATA;
    wire [31:0] PRDATA;
    wire PREADY;
    reg PREADY_reg;  // Add a reg to control PREADY

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
        .PREADY(PREADY)  // Connect wire to slave
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
        .PREADY(PREADY)  // Wire to master
    );

    apb_bus_monitor monitor (
        .PCLK(PCLK),
        .PADDR(PADDR),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY)  // Wire to monitor
    );

    // Clock generation
    always begin
        PCLK = ~PCLK; #5;
    end

    // Continuous assignment to drive PREADY from PREADY_reg
    assign #10 PREADY = PENABLE;

    initial begin
        // Initialize signals
        PRESETn = 0;
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;
        PADDR = 0;
        PWDATA = 0;
        PREADY_reg = 0;  // Initialize PREADY_reg to 0
        
        // Apply reset
        #10 PRESETn = 1;
        
        // Write Operation with Wait
        #10 PADDR = 32'h0000; PWDATA = 32'h5678; PWRITE = 1; PSEL = 1; PENABLE = 1;
        
        // Simulate the PREADY signal generation
        #10;
        if (PENABLE) begin
            // Assert PREADY when PENABLE is high (slave is ready to complete the operation)
            #5 PREADY_reg = 1;
        end
        #10 PSEL = 0; PENABLE = 0; PREADY_reg = 0;  // Deassert signals
        
        // Finish the simulation
        #100 $finish;
    end
endmodule


