`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 20:34:32
// Design Name: 
// Module Name: ALU
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

module ALU(
    input [31:0] val_a,
    input [31:0] val_b,
    input [1:0] alu_op,
    output [31:0] alu_out,
    output zf,
    output sf
    );
    wire [32:0] alu_reg;
    assign alu_out = alu_reg[31:0];
    assign alu_reg = (alu_op == `ALU_ADD) ? {val_a[31], val_a} + {val_b[31], val_b}:
                     (alu_op == `ALU_SUB) ? {val_a[31], val_a} - {val_b[31], val_b}:
                     (alu_op == `ALU_OR) ? {1'b0, val_a} | {1'b0, val_b}: 32'd114514;
    assign zf = !(|(alu_out));
    assign sf = alu_out[31];
    
    
endmodule
