`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2022 08:05:38 PM
// Design Name: 
// Module Name: PC
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


module PC(
input clk,
input reset,
input read_enable,
input write_enable,
input value,
output wire [31:0] data
);


reg  [31:0] PC_val; //Instantiates the register which the 32-bit Program Counter will be stored. 
initial PC_val = 32'b0; //Initialize the register with value of 0.

//reg [31:0] outData;

//always @ (posedge clk) begin
//    data <= 32'd2;
//end

assign data = read_enable ? PC_val[31:0] : 32'b0;

always @ (posedge clk) 
begin

    if (reset == 1'b1 || PC_val[31:0] >= 32'd31) //Reset condition
    begin
        PC_val[31:0] <= 32'b0;
    end
    
    else 
        PC_val[31:0] <= PC_val[31:0]+32'd1;
    begin
    
    end

    if (write_enable == 1'b1)
    begin
        PC_val[31:0] <= value; //Writing to PC. For branch, shift, and jump instructions.
    end
    
//    else 
//    begin
       //If not Write_enable -> continue to increment the PC.
//    end
    
//    else
//    begin
//        data <= 32'b0; //Returning nothing if not Read_enable.
//    end


end

endmodule
