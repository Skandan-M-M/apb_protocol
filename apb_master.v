`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:59 12/04/2024 
// Design Name: 
// Module Name:    apb_master 
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
module apb_master (
    input wire PCLK,         // APB Clock
    input wire PRESETn,      // APB Reset (active low)
    output reg PSEL,         // APB Select signal
    output reg PENABLE,      // APB Enable signal
    output reg PWRITE,       // APB Write signal
    output reg [31:0] PADDR, // APB Address Bus
    output reg [31:0] PWDATA, // APB Write Data
    input wire [31:0] PRDATA, // APB Read Data
    input wire PREADY        // APB Ready signal
);
    // Control signals
    reg [3:0] state;
    
    // State machine for write and read operations
    always @(posedge PCLK or negedge PRESETn) begin
        if (~PRESETn) begin
            state <= 4'b0000;
            PSEL <= 0;
            PENABLE <= 0;
            PWRITE <= 0;
            PADDR <= 32'b0;
            PWDATA <= 32'b0;
        end else begin
            case(state)
                4'b0000: begin // Idle state
                    state <= 4'b0001;
                end
                4'b0001: begin // Set address and initiate transaction
                    PSEL <= 1;
                    PADDR <= 32'h0000; // Example address
                    PWRITE <= 1;       // Write operation
                    PWDATA <= 32'h1234; // Example data
                    state <= 4'b0010;
                end
                4'b0010: begin // Enable transaction
                    PENABLE <= 1;
                    state <= 4'b0100;
                end
                4'b0100: begin // Wait for ready signal
                    if (PREADY) begin
                        PSEL <= 0; // Deactivate select signal
                        PENABLE <= 0; // Deactivate enable signal
                        state <= 4'b0000; // Go back to idle state
                    end
                end
                default: state <= 4'b0000;
            endcase
        end
    end
endmodule

