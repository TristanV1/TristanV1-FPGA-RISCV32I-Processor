`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2022 08:06:15 PM
// Design Name: 
// Module Name: RF
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


module RF(
input  clk,
input  reset,
input  write_enable,
input  rs1_enable,
input  rs2_enable,
input  wire [31:0] data_write,
input  wire [4:0]  rd,
input  wire [4:0]  rs1,
input  wire [4:0]  rs2,
output wire  [31:0] rs1_val,
output wire  [31:0] rs2_val
//output reg  RF_data_out [31:0]
);
 
integer i;
reg [31:0] RF_val [31:0]; //Register file with 32 words, 32-bits. 

initial RF_val[0] <= 0;
initial RF_val[2] <= 32'd80;
initial RF_val[1] <= 32'd80;

assign rs1_val = rs1_enable ? RF_val[rs1] : 32'b0; //If rs1 is required, index RF at the value of rs1 and return it.
assign rs2_val = rs2_enable ? RF_val[rs2] : 32'b0; //If rs2 is required, index RF at the value of rs2 and return it.

always @ (posedge clk) begin
    
    if (reset) begin
        for (i=0; i<32; i = i+1) begin
            RF_val[i] <= 32'b0;
        end
    end

//    if (rs1_enable) begin //If rs1 is required, index RF at the value of rs1 and return it.
//        rs1_val <= RF_val[rs1];
//    end
//    else begin
//        rs1_val <= 32'b0; //otherwise return 0
//    end    
    
//    if (rs2_enable) begin //If rs2 is required, index RF at the value of rs2 and return it.
//        rs2_val <= RF_val[rs2];
//    end
//    else begin
//        rs2_val <= 32'b0; //otherwise return 0
//    end
    
    if (write_enable && rd != 0) begin //If writing to rd is required. Index RF at the value of rd and write the given data. Second conditions ensure x0 remains 0. 
        RF_val[rd] <= data_write[31:0];
    end
        
    //RF_data_out[31:0] <= RF_val;
    
end

endmodule
