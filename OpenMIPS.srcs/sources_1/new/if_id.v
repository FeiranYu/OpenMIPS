`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/09 23:06:44
// Design Name: 
// Module Name: if_id
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
`include "OpenMIPS.vh"

module if_id(
    input wire clk,
    input wire rst,
    
    input wire [5:0] stall,

    input wire flush,
    
    //����ȡַ�׶ε��źţ����к궨��InstBus��ʾָ����,Ϊ32
    input wire [`InstAddrBus]       if_pc,
    input wire [`InstBus]           if_inst,
    
    //��Ӧ����׶ε��ź�
    output reg[`InstAddrBus]        id_pc,
    output reg[`InstBus]            id_inst
    );
    
    always@(posedge clk)begin
        if(rst==`RstEnable) begin
            id_pc<=`ZeroWord;   //��λ��ʱ��pcΪ0
            id_inst<=`ZeroWord; //��λ��ʱ��ָ��ҲΪ0��ʵ�ʾ��ǿ�ָ��
        end else if(flush==1'b1)begin
            //flush==1��ʾ�쳣������Ҫ�����ˮ��
            //���Ը�λid_pc,id_inst�Ĵ�����ֵ
            id_pc<=`ZeroWord;
            id_inst<=`ZeroWord;
        end else if(stall[1]==`Stop && stall[2]==`NoStop)begin
            id_pc<=`ZeroWord;
            id_inst<=`ZeroWord;
        end else if(stall[1]==`NoStop)begin
            id_pc<=if_pc;       //����ʱ�����´���ȡֵ�׶ε�ֵ
            id_inst<=if_inst;
        end
    end
    
endmodule
