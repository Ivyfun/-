`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 16:59:54
// Design Name: 
// Module Name: pc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "myhead.v"

module pc(
    input clk,
    input rst,
    
    input [31:0] npc_val,
    output reg [31:0] pc_val
    );
    
    
    
    always @(posedge clk) begin
        if (rst) 
           pc_val <=  `CODE_START;
        else
            pc_val <= npc_val;
    end
    
endmodule
