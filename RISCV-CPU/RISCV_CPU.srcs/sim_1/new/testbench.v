`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 16:46:09
// Design Name: 
// Module Name: testbench
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


module testbench(
    
    );
    reg clk;
    reg rst;
    top tp1(clk, rst);
    
    always #5 clk<=~clk;
    reg [31:0] i;
    initial begin
        rst <= 1;
        clk <= 0;
        #6
        rst <= 0;
        
        for(i=0;i<117;i=i+1)
            #10 i=i+0;
        
        #5 $stop;
    end
    
    
endmodule
