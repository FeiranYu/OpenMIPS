`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 16:19:10
// Design Name: 
// Module Name: inst_rom
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
`include"OpenMIPS.vh"

module inst_rom(
    input wire ce,
    input wire [`InstAddrBus] addr,
    output reg[`InstBus]    inst
    );
    
    //����һ�����飬��С��InstMemNum,Ԫ�ؿ����InstBus
    reg[`InstBus] inst_mem[0:`InstMemNum-1];
    
    //ʹ���ļ�inst_rom.data��ʼ��ָ��洢��
    initial $readmemh("inst_rom.data",inst_mem);
    
    //����λ�ź���Чʱ����������ĵ�ַ������ָ��洢��ROM�ж�Ӧ��Ԫ��
    always@(*)begin
        if(ce==`ChipDisable) begin
            inst<=`ZeroWord;
        end else begin
            inst<=inst_mem[addr[`InstMemNumLog2+1:2]];
        end
     end
endmodule
