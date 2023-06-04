`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2022 04:40:43 PM
// Design Name: 
// Module Name: slowClk
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


module slowClk(
input clk,
output reg newClk
); 

reg counter = 0;
always @(posedge clk) begin
    
    if (counter >= 1_000_000) begin
        counter <= 1'd0;
        newClk <= !newClk; 
    end
    
    else begin
        counter <= counter + 1'd1;
    end
    
end
    
endmodule
