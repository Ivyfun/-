`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 20:39:18
// Design Name: 
// Module Name: register_file
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


module reg_write_choice(
    input [31:0] alu_out, 
    input [31:0] data,
    input [31:0] pc,
    input [31:0] imm,
    input [1:0] RegSrc,
    output [31:0] reg_data
);
    wire [31:0] auipc_out;
    wire [31:0] step_pc_out;
    
    assign reg_data = (RegSrc == `FROM_ALU) ? alu_out:
                      (RegSrc == `FROM_DATA) ? data:
                      (RegSrc == `FROM_AUIPC) ? (imm+pc):
                      (pc+4);
endmodule

module register_file(
    input clk,
    input [4:0] rd_addr,
    input [4:0] r2_addr,
    input [4:0] r1_addr,
    input wen,
    input [31:0] write_data,
    
    output [31:0] r2_data,
    output [31:0] r1_data
    );
    
    reg [31:0] registers[31:0];
    reg [5:0] i;
    initial 
        for(i=0;i<32;i=i+1) begin
            registers[i] <= 32'b0;
        end
    
    assign r2_data = registers[r2_addr];
    assign r1_data = registers[r1_addr];
    
    always @(negedge clk)begin
        if(wen && rd_addr)
             registers[rd_addr] <= write_data;
    end
    
endmodule
