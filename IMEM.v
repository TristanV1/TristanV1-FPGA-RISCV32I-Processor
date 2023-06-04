`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2022 08:06:30 PM
// Design Name: 
// Module Name: IMEM
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


module IMEM(
input clk,
input read_enable,
input       [31:0] address,
output wire [31:0] data 
);

(* rom_style = "block" *)
reg [31:0] IMEM_Val [31:0]; //This implementation will only run 32 instructions. Can be increased to fit a 32-bit address. 

initial begin
    $readmemb("Instructions.mem",IMEM_Val); //Writing program instructions to IMEM ROM which is stored in Instructions.mem file. 
end

assign data = read_enable ? IMEM_Val[address] : 32'b0;
//always @ (posedge clk) begin
//    if (read_enable == 1'b1) begin //If read_enable -> return value at address.
//        data <= IMEM_Val[address];
//    end

//end

endmodule
