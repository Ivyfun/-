`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 16:17:34
// Design Name: 
// Module Name: myhead
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

`define ADD_OPC 7'b0110011
`define SUB_OPC 7'b0110011
`define ADDI_OPC 7'b0010011
`define AUIPC_OPC 7'b0010111
`define ORI_OPC 7'b0010011
`define JAL_OPC 7'b1101111
`define BEQ_OPC 7'b1100011
`define LW_OPC 7'b0000011
`define SW_OPC 7'b0100011

`define ADD_FUNCT_7 7'b0000000
`define SUB_FUNCT_7 7'b0100000
`define ADDI_FUNCT_3 3'b000
`define ORI_FUNCT_3 3'b110
`define BEQ_FUNCT_3 3'b000
`define BGE_FUNCT_3 3'b101

`define CODE_START 32'h00400000 
`define DATA_START 32'h10010000

//ALUOp
`define ALU_ADD 2'b01
`define ALU_SUB 2'b10
`define ALU_OR 2'b11
`define ALU_DEFAULT 2'b00

//RegSrc
`define FROM_ALU 2'b00
`define FROM_DATA 2'b01
`define FROM_JAL 2'b10
`define FROM_AUIPC 2'b11

//ConstSrc
`define TYPE_R 3'b000
`define TYPE_I 3'b001
`define TYPE_S 3'b010
`define TYPE_B 3'b011
`define TYPE_U 3'b100
`define TYPE_J 3'b101

//ExtOp
`define DG_12 2'b00
`define DG_13 2'b01
`define DG_20 2'b10
`define DG_21 2'b11


`define INSTRUCTION_SIZE 8'd111
`define DATA_SIZE 3'd5