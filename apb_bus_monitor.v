`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:25 12/04/2024 
// Design Name: 
// Module Name:    apb_bus_monitor 
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
module apb_bus_monitor (
    input wire PCLK,        // APB Clock
    input wire [31:0] PADDR, // APB Address Bus
    input wire PWRITE,      // APB Write signal
    input wire [31:0] PWDATA, // APB Write Data
    input wire [31:0] PRDATA, // APB Read Data
    input wire PREADY       // APB Ready signal
);
    // Monitor the bus
    always @(posedge PCLK) begin
        if (PWRITE) begin
            $display("APB Write - Addr: %h, Data: %h", PADDR, PWDATA);
        end else begin
            $display("APB Read - Addr: %h, Data: %h", PADDR, PRDATA);
        end
        if (PREADY) begin
            $display("APB Ready signal is active.");
        end
    end
endmodule

