`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 16:15:45
// Design Name: 
// Module Name: top
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

module top(
    input clk,
    input rst
    );
    wire [31:0] npc_val;
    wire [31:0] pc_val;
    wire [31:0] imm;
    wire [31:0] code;
    wire RegWrite, MemRead, MemWrite, ALUSrc, NPCOp;
    wire [1:0] ALUOp, RegSrc, ExtOp;
    wire [2:0] ConstSrc;
    wire [4:0] rs1_addr, rs2_addr, rd_addr;
    wire [31:0] rs1_d, rs2_d;
    wire [31:0] alu_out;
    wire zf, sf;
    
    assign rs2_addr = code[24:20];
    assign rs1_addr = code[19:15];
    assign rd_addr = code[11:7];   
    
    instruction_fetch inst_fetcher(pc_val, code);
    
    control CU(code,zf,sf,RegWrite,MemRead,MemWrite,ALUOp,RegSrc,ConstSrc,ALUSrc,NPCOp,ExtOp);
    make_imm imm_maker(code,ConstSrc,ExtOp,imm);
    
    wire [31:0] src_data;
    assign src_data = ALUSrc ? rs2_d : imm;
    ALU my_alu(rs1_d, src_data, ALUOp, alu_out, zf, sf);
    
    wire [31:0] mem_data;
    Memory_RW mem_access(clk, alu_out, MemRead, MemWrite, rs2_d, mem_data);
    
    wire [31:0] reg_write_data;
    reg_write_choice reg_write_chooser(alu_out, mem_data, pc_val, imm, RegSrc, reg_write_data);
    register_file reg_access(clk, rd_addr, rs2_addr, rs1_addr, RegWrite, reg_write_data, rs2_d, rs1_d);
    
    pc program_counter(clk,rst,npc_val,pc_val);
    npc next_pc_counter(pc_val,NPCOp,imm,npc_val);
    
endmodule
