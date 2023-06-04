`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2022 08:07:18 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
input              clk,
input              [2:0]  funct3,
input              [6:0]  funct7,
input              [6:0]  opcode,
input              [4:0]  rd,
input              [31:0] rs1_val,
input              [31:0] rs2_val,
input              [31:0] imm,
input              [31:0] pc,
output reg        taken_branch,
output wire        branch_to_pc,
output reg   [31:0]ALU_output,
output wire  [10:0]full_opcode // Temporary
);

wire   [31:0] ALU_out;
//wire  [10:0] full_opcode; 
wire        branch_taken;

assign full_opcode = {funct7[5],funct3,opcode};

always @ (negedge clk) begin
     taken_branch <=      (full_opcode == 11'bx_000_1100011)?(rs1_val == rs2_val)://is_beq
                          (full_opcode == 11'bx_001_1100011)?(rs1_val != rs2_val)://is_bne
                          (full_opcode == 11'bx_100_1100011)?((rs1_val < rs2_val)  ^ (rs1_val[31] != rs2_val[31]))://is_blt
                          (full_opcode == 11'bx_101_1100011)?((rs1_val >= rs2_val) ^ (rs1_val[31] != rs2_val[31]))://is_bge
                          (full_opcode == 11'bx_110_1100011)?(rs1_val < rs2_val)://is_bltu
                          (full_opcode == 11'bx_111_1100011)?(rs1_val >= rs2_val)://is_bgeu
                          1'b0;
                          
   //Decoding register instructions
    ALU_output[31:0] <= 
                    (full_opcode == 11'bx_000_0010011)?  rs1_val + imm                               : //is_addi
                    (full_opcode == 11'b0_000_0110011)?  rs1_val + rs2_val                           : //is_add 
                    (full_opcode == 11'bx_xxx_0110111)?  {imm[31:12], 12'b0}                         : //is_lui
                    (full_opcode == 11'bx_xxx_0010111)?  pc + imm                                    : //is_auipc
                    (full_opcode == 11'bx_xxx_1101111)?  pc + 32'd1                                  : //is_jal 
                    (full_opcode == 11'bx_011_0010011)?  {31'b0, rs1_val < imm}                      ://is_sltiu
                    (full_opcode == 11'bx_100_0010011)?  rs1_val ^ imm                               ://is_xori
                    (full_opcode == 11'bx_110_0010011)?  rs1_val || imm                              ://is_ori
                    (full_opcode == 11'bx_111_0010011)?  rs1_val & imm                               ://is_andi
                    (full_opcode == 11'b0_001_0010011)?  rs1_val << imm[5:0]                         ://is_slli
                    (full_opcode == 11'b0_101_0010011)?  rs1_val >> imm[5:0]                         ://is_srli
                    (full_opcode == 11'b1_101_0010011)?  {{32{rs1_val[31]}}, rs1_val} >> imm[4:0]    ://is_srai
                    (full_opcode == 11'b1_000_0110011)?  rs1_val - rs2_val                           ://is_sub
                    (full_opcode == 11'b0_001_0110011)?  rs1_val << rs2_val[4:0]                     ://is_sll
                    (full_opcode == 11'b0_011_0110011)?  {31'b0, rs1_val < rs2_val}                  ://is_sltu
                    (full_opcode == 11'b0_100_0110011)?  rs1_val ^ rs2_val                           ://is_xor
                    (full_opcode == 11'b0_101_0110011)?  rs1_val >> rs2_val[4:0]                     ://is_srl
                    (full_opcode == 11'b1_101_0110011)?  {{32{rs1_val[31]}}, rs1_val} >> rs2_val[4:0]://is_sra
                    (full_opcode == 11'b0_110_0110011)?  rs1_val | rs2_val                           ://is_or
                    (full_opcode == 11'b0_111_0110011)?  rs1_val & rs2_val                           ://is_and
                    32'b0;
                    
    //branch_to_pc <= (branch)taken
                    
        
          //$is_lh    = $full_opcode[10:0]  ==?  11'bx_001_0000011;  //Not done
//        //$is_lw    = $full_opcode[10:0]  ==?  11'bx_010_0000011;  //Not done
//        //$is_lbu   = $full_opcode[10:0]  ==?  11'bx_100_0000011;  //Not done 
//        //$is_lhu   = $full_opcode[10:0]  ==?  11'bx_101_0000011;  //Not done
//        //$is_sb    = $full_opcode[10:0]  ==?  11'bx_000_0100011;  //Not done
//        //$is_sh    = $full_opcode[10:0]  ==?  11'bx_001_0100011;  //Not done
//        //$is_sw    = $full_opcode[10:0]  ==?  11'bx_010_0100011;  //Not done
//        //11'bx_010_0010011: //is_slti //Not done
//        //11'b0_010_0110011: //is_slt //Not done
//        default ALU_out <= 32'b0;
//    endcase
end
   
    assign branch_to_pc = (branch_taken)? pc+imm:
                          1'b0;
    
    //assign ALU_output = ALU_out;
    //assign taken_branch = branch_taken;



   //Decoding branch instructions

endmodule
