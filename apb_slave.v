`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:29 12/04/2024 
// Design Name: 
// Module Name:    apb_slave 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module apb_slave (
    input wire PCLK,        // APB Clock
    input wire PRESETn,     // APB Reset (active low)
    input wire PSEL,        // APB Select signal
    input wire PENABLE,     // APB Enable signal
    input wire PWRITE,      // APB Write signal
    input wire [31:0] PADDR, // APB Address Bus
    input wire [31:0] PWDATA, // APB Write Data
    output reg [31:0] PRDATA, // APB Read Data
    output reg PREADY       // APB Ready signal
);
    // Internal registers to simulate memory
    reg [31:0] mem [0:15];  // 16-word memory

    // On Reset
    always @(posedge PCLK or negedge PRESETn) begin
        if (~PRESETn)
            PREADY <= 0;
        else
            PREADY <= 1;  // Always ready after reset
    end

    // Read/Write Operations
    always @(posedge PCLK) begin
        if (PSEL && PENABLE) begin
            if (PWRITE) begin
                mem[PADDR[3:0]] <= PWDATA; // Write operation
            end else begin
                PRDATA <= mem[PADDR[3:0]]; // Read operation
            end
        end
    end
endmodule

