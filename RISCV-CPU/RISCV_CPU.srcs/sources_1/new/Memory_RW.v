`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 17:14:47
// Design Name: 
// Module Name: Memory_RW
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

module Memory_RW(
    input clk,
    input [31:0] addr,
    input ren, 
    input wen,
    input [31:0] write_data,
    output reg [31:0] fetched_data
    );
    reg [4:0] n;
    reg [31:0] data_memory[`DATA_SIZE-1:0];
    wire [31:0] position;
    
    initial begin
        $display("Data:");
        $readmemh("data.txt", data_memory);
        for(n=0;n<5;n=n+1)begin
            $display("%d",data_memory[n]);
        end
        fetched_data <= 32'b0;
    end
    
    assign position = (addr - `DATA_START)>>2;
    
    always @(position)begin
        if (ren)
            fetched_data <= data_memory[position];
        else
            fetched_data <= 32'b0;
    end
    
    always @(negedge clk)begin
        if (wen) 
            data_memory[position] <= write_data;
    end
        
    
endmodule
