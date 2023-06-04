`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2022 08:06:54 PM
// Design Name: 
// Module Name: DEC
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


module DEC(
input clk,
input  wire [31:0] instr,
output wire [6:0]  opcode,
output wire [2:0]  funct3,
output wire [6:0]  funct7,
output wire [4:0]  rd,
output wire [4:0]  rs1,
output wire [4:0]  rs2,
output wire [31:0] imm,
output wire        rd_valid,
output wire        rs1_valid,
output wire        rs2_valid,
output wire        imm_valid
);

wire is_u_instr  = instr[6:2] == 5'b0x101;
wire is_i_instr  = instr[6:2] == 5'b0000x || instr[6:2] == 5'b00100 || instr[6:2] == 5'b00110 || instr[6:2] == 5'b11001;
wire is_s_instr  = instr[6:2] == 5'b0100x;
wire is_r_instr  = instr[6:2] == 5'b01011 || instr[6:2] == 5'b01100 || instr[6:2] == 5'b10100 || instr[6:2] == 5'b01110;
wire is_b_instr  = instr[6:2] == 5'b11000;
wire is_j_instr  = instr[6:2] == 5'b11011;

//wire rd_valid  = (is_r_instr || is_i_instr || is_u_instr || is_j_instr);
//wire rs1_valid = (is_r_instr || is_i_instr || is_s_instr || is_b_instr);
//wire rs2_valid = (is_r_instr || is_s_instr || is_b_instr);
//wire imm_valid = (is_i_instr || is_s_instr || is_b_instr || is_u_instr || is_j_instr);

assign    rd_valid  = (is_r_instr || is_i_instr || is_u_instr || is_j_instr);
assign    rs1_valid = (is_r_instr || is_i_instr || is_s_instr || is_b_instr);
assign    rs2_valid = (is_r_instr || is_s_instr || is_b_instr);
assign    imm_valid = (is_i_instr || is_s_instr || is_b_instr || is_u_instr || is_j_instr);

assign    opcode[6:0] =  instr[6:0];
assign    funct3[2:0] =  rs1_valid  ? instr[14:12] : 0;
assign    funct7[6:0] =  is_r_instr ? instr[31:25] : 0;
assign    rd[4:0]     =  rd_valid   ? instr[11:7]  : 0;
assign    rs1[4:0]    =  rs1_valid  ? instr[19:15] : 0;
assign    rs2[4:0]    =  rs2_valid  ? instr[24:20] : 0;

assign    imm[31:0] = is_i_instr  ?  { {21{instr[31]}}, instr[30:20] } : 
                 is_s_instr  ?  { {21{instr[31]}}, instr[30:25] , instr[11:8], instr[7] } : 
                 is_b_instr  ?  { {20{instr[31]}}, instr[7], instr[30:25] , instr[11:8], 1'b0 } : 
                 is_u_instr  ?  { {instr[31]}, instr[30:20] , instr[19:12], {12{1'b0}} } : 
                 is_j_instr  ?  { {12{instr[31]}}, instr[19:12] , instr[20], instr[30:25], instr[24:21], 1'b0 } :
                 32'b0;



                 
                 
endmodule
