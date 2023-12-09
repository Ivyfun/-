`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 16:26:42
// Design Name: 
// Module Name: instruction_fetch
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

module instruction_fetch(
    input [31:0] pc,
    output [31:0] code
    );
    reg [31:0] im[`INSTRUCTION_SIZE+5:0];
    reg [9:0] n;
    wire [31:0] position;
    initial begin 
        $display("Instructions:");
        $readmemh("hexcode.txt", im);
        for(n=0;n<`INSTRUCTION_SIZE;n=n+1) 
            $display("%h", im[n]);
    end
    
    assign position = (pc-`CODE_START)>>2;
    assign code = im[position][31:0];
    
endmodule
