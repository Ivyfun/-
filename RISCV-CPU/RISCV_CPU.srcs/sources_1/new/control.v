`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 17:04:48
// Design Name: 
// Module Name: control
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

module control(
    input [31:0] code,
    input zf,
    input sf,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output [1:0] ALUOp,
    output [1:0] RegSrc,
    output [2:0] ConstSrc,
    output ALUSrc,
    output NPCOp,
    output [1:0] ExtOp
    );
    
    wire [6:0] funct7;
    wire [2:0] funct3;
    wire [6:0] op_code;
    
    
    assign funct7 = code[31:25];
    assign funct3 = code[14:12];
    assign op_code = code[6:0];
    
    wire islw = op_code == `LW_OPC;
    wire issw = op_code == `SW_OPC;
    wire isb = op_code == `BEQ_OPC;
    wire is_type_r = op_code == `ADD_OPC;
    wire is_type_i_alu = op_code == `ADDI_OPC;
    
    wire isadd = is_type_r && (funct7 == `ADD_FUNCT_7);
    wire issub = is_type_r && (funct7 == `SUB_FUNCT_7); 
    wire isaddi = is_type_i_alu && (funct3 == `ADDI_FUNCT_3);
    wire isori = is_type_i_alu && (funct3 == `ORI_FUNCT_3);
    wire isauipc = op_code == `AUIPC_OPC;
    wire isjal = op_code == `JAL_OPC;
    wire isbeq = isb && (funct3 == `BEQ_FUNCT_3);
    wire isbge = isb && (funct3 == `BGE_FUNCT_3);
    
    wire is_type_i = is_type_i_alu || islw;
    
    assign RegWrite = !(isb || issw);
    assign MemRead = islw;
    assign MemWrite = issw;
    assign ALUOp = (isadd||isaddi||islw||issw) ? `ALU_ADD:
                    (issub||isb)? `ALU_SUB:
                    (isori)? `ALU_OR: `ALU_DEFAULT;
    assign RegSrc = (isauipc) ? `FROM_AUIPC:
                    (isjal) ? `FROM_JAL:
                    (islw) ? `FROM_DATA: `FROM_ALU;
    assign ConstSrc = isjal ? `TYPE_J:
                      issw ? `TYPE_S:
                      isb ? `TYPE_B:
                      isauipc? `TYPE_U:
                      is_type_i ? `TYPE_I: `TYPE_R;
    assign ALUSrc = is_type_r||isb;
    assign NPCOp = isjal ? 1:
                   isbeq ? zf :
                   isbge ? !sf: 0;
    assign ExtOp = (is_type_i||issw) ? `DG_12:
                   (isbeq) ? `DG_13:
                   (isauipc) ? `DG_20: `DG_21;
    
endmodule
