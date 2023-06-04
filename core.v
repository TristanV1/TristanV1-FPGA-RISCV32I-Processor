`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2022 08:05:16 PM
// Design Name: 
// Module Name: core
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


module core(
input clk, 
output reg [31:0] rs1_valT,
output reg [31:0] rs2_valT,
output reg [31:0] immT,
output reg [31:0] PC,
output reg [31:0] IMEM_outT,
output reg [31:0] ALU_outputT,
output reg [10:0] full_opcodeT
);

wire newClk;

slowClk OneHz(
.clk(clk),
.newClk(newClk)
);

wire [31:0] PC_out; 
 
PC one(
.clk(clk),
.reset(1'b0),
.read_enable(1'b1),
.write_enable(taken_branch), //// taken_branch
.value(branch_to_pc), /// Change to branch_to_pc
.data(PC_out)
);

wire[31:0] IMEM_out;

IMEM two(
.clk(clk),
.read_enable(1'b1),
.address(PC_out),
.data(IMEM_out)
);

wire [2:0]  funct3;
wire [6:0]  funct7;
wire [4:0]  rd;
wire [4:0]  rs1;
wire [4:0]  rs2;
wire [31:0] imm;
wire [6:0]  opcode;
wire        rd_valid;
wire        rs1_valid;
wire        rs2_valid;
wire        imm_valid;

DEC three(
.clk(clk),
.opcode(opcode),
.instr(IMEM_out),
.funct3(funct3),
.funct7(funct7),
.rd(rd),
.rs1(rs1),
.rs2(rs2),
.imm(imm),
.rd_valid(rd_valid),
.rs1_valid(rs1_valid),
.rs2_valid(rs2_valid),
.imm_valid(imm_valid)
);

wire [31:0] rs1_val;
wire [31:0] rs2_val;

RF four(
.clk(clk),
.reset(32'b0),
.write_enable(rd_valid),
.rs1_enable(rs1_valid),
.rs2_enable(rs2_valid),
.data_write(32'b0), //not implemented yet should be ALU out.
.rd(rd),
.rs1(rs1),
.rs2(rs2),
.rs1_val(rs1_val),
.rs2_val(rs2_val)
);

wire        taken_branch;
wire [31:0] branch_to_pc;
wire [31:0] ALU_output;
wire [10:0] full_opcode;

ALU five(
.clk(clk),
.funct3(funct3),
.funct7(funct7),
.opcode(opcode),
.rd(rd),
.rs1_val(rs1_val),
.rs2_val(rs2_val),
.imm(imm),
.pc(PC_out),
.taken_branch(taken_branch),
.branch_to_pc(branch_to_pc),
.ALU_output(ALU_output),
.full_opcode(full_opcode)
);

always @ (posedge clk) begin
    ALU_outputT <= ALU_output;
    PC <= PC_out;
    rs1_valT <= rs1_val; 
    rs2_valT <= rs2_val;
    immT <= imm;
    IMEM_outT<= IMEM_out;
    full_opcodeT <= full_opcode;
    
end

endmodule
