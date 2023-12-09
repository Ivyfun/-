`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 20:08:22
// Design Name: 
// Module Name: make_imm
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

module make_imm(
    input [31:0] code,
    input [2:0] ConstSrc,
    input [1:0] ExtOp,
    output [31:0] imm
    );
    assign imm = (ConstSrc == `TYPE_I) ? {{20{code[31]}},code[31:20]}:
                 (ConstSrc == `TYPE_S) ? {{20{code[31]}},code[31:25],code[11:7]}:
                 (ConstSrc == `TYPE_B) ? {{19{code[31]}},code[31],code[7],code[30:25],code[11:8],1'b0}:   
                 (ConstSrc == `TYPE_U) ? {code[31:12],12'b0}:
                 (ConstSrc == `TYPE_J) ? {{11{code[31]}},code[31],code[19:12],code[20],code[30:21],1'b0}:
                 32'b0;           
endmodule
