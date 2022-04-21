module TOSAM_h1_t5 (A,B,FinalOUT);
input [7:0]A,B;
output [15:0]FinalOUT;
wire zero,sign;
wire [7:0]KA1,KB1;
wire [2:0]KA,KB;
wire [3:0]shiftL;
wire [4:0]YA,YB;
wire [1:0]c,d;
wire [6:0]FinalOUT1;
wire [20:0]FinalOUT2;
//******************* finding KA and KB ****************************
 assign KA1[7]=A[7];
 assign KA1[6]=(~A[7] && A[6]);
assign KA1[5]=(~A[7] && ~A[6] && A[5]);
assign KA1[4]=(~A[7] && ~A[6] && ~A[5] && A[4]);
assign KA1[3]=(~A[7] && ~A[6] && ~A[5] && ~A[4] && A[3]);
assign KA1[2]=(~A[7] && ~A[6] && ~A[5] && ~A[4] && ~A[3] && A[2]);
assign KA1[1]=(~A[7] && ~A[6] && ~A[5] && ~A[4] && ~A[3] && ~A[2] && A[1]);
assign KA1[0]=(~A[7] && ~A[6] && ~A[5] && ~A[4] && ~A[3] && ~A[2] && ~A[1] && A[0]);
//**********************************************
 assign KB1[7]=B[7];
 assign KB1[6]=(~B[7] && B[6]);
assign KB1[5]=(~B[7] && ~B[6] && B[5]);
assign KB1[4]=(~B[7] && ~B[6] && ~B[5] && B[4]);
assign KB1[3]=(~B[7] && ~B[6] && ~B[5] && ~B[4] && B[3]);
assign KB1[2]=(~B[7] && ~B[6] && ~B[5] && ~B[4] && ~B[3] && B[2]);
assign KB1[1]=(~B[7] && ~B[6] && ~B[5] && ~B[4] && ~B[3] && ~B[2] && B[1]);
assign KB1[0]=(~B[7] && ~B[6] && ~B[5] && ~B[4] && ~B[3] && ~B[2] && ~B[1] && B[0]);
//*****************Generating shifting value*****************************
 assign KA=(KA1[7]) ? 3'd 7 : 
  (KA1[6]) ? 3'd 6 : 
 (KA1[5]) ? 3'd 5 : 
 (KA1[4]) ? 3'd 4 : 
 (KA1[3]) ? 3'd 3 : 
 (KA1[2]) ? 3'd 2 : 
 (KA1[1]) ? 3'd 1 : 3'd 0;
//*********************************************
 assign KB=(KB1[7]) ? 3'd 7 : 
  (KB1[6]) ? 3'd 6 : 
 (KB1[5]) ? 3'd 5 : 
 (KB1[4]) ? 3'd 4 : 
 (KB1[3]) ? 3'd 3 : 
 (KB1[2]) ? 3'd 2 : 
 (KB1[1]) ? 3'd 1 : 3'd 0;
 assign shiftL=KB+KA;
//******************* finding YA (YA=0/...)***The fractional part*************************
 assign YA[4]=(KA1[7] && A[6])|| (KA1[6] && A[5]) || (KA1[5] && A[4]) || (KA1[4] && A[3]) || (KA1[3] && A[2]) || (KA1[2] && A[1]) || (KA1[1] && A[0]) ||  (KA1[1] && A[0]);
assign YA[3]=(KA1[7] && A[5])|| (KA1[6] && A[4]) || (KA1[5] && A[3]) || (KA1[4] && A[2]) || (KA1[3] && A[1]) || (KA1[2] && A[0]) ||  (KA1[2] && A[0]);
assign YA[2]=(KA1[7] && A[4])|| (KA1[6] && A[3]) || (KA1[5] && A[2]) || (KA1[4] && A[1]) || (KA1[3] && A[0]) ||  (KA1[3] && A[0]);
assign YA[1]=(KA1[7] && A[3])|| (KA1[6] && A[2]) || (KA1[5] && A[1]) || (KA1[4] && A[0]) ||  (KA1[4] && A[0]);
assign YA[0]=(KA1[7] && A[2])|| (KA1[6] && A[1]) || (KA1[5] && A[0]) ||  (KA1[5] && A[0]);
//**********************************************
 //******************* finding YB ****************************
 assign YB[4]=(KB1[7] && B[6])|| (KB1[6] && B[5]) || (KB1[5] && B[4]) || (KB1[4] && B[3]) || (KB1[3] && B[2]) || (KB1[2] && B[1]) || (KB1[1] && B[0]) ||  (KB1[1] && B[0]);
assign YB[3]=(KB1[7] && B[5])|| (KB1[6] && B[4]) || (KB1[5] && B[3]) || (KB1[4] && B[2]) || (KB1[3] && B[1]) || (KB1[2] && B[0]) ||  (KB1[2] && B[0]);
assign YB[2]=(KB1[7] && B[4])|| (KB1[6] && B[3]) || (KB1[5] && B[2]) || (KB1[4] && B[1]) || (KB1[3] && B[0]) ||  (KB1[3] && B[0]);
assign YB[1]=(KB1[7] && B[3])|| (KB1[6] && B[2]) || (KB1[5] && B[1]) || (KB1[4] && B[0]) ||  (KB1[4] && B[0]);
assign YB[0]=(KB1[7] && B[2])|| (KB1[6] && B[1]) || (KB1[5] && B[0]) ||  (KB1[5] && B[0]);
assign c= {YA[4:4],1'b 1};
assign d= {YB[4:4],1'b 1};
//*******************Generating zero***************************
 assign zero= ((A==8'd 0)||(B==8'd 0)) ? 1'b 0 : 1'b 1 ;
 //*************************Reduction By Wallace***************************
 //**************************************Generating PPs**************
assign OL0X1C2= c[0] & d[0];
//************************for (n-1)th Column*************
assign OL0X1C3= c[1] & d[0];
assign OL0X2C3= c[0] & d[1];
//************************for (n)th Column*************
assign OL0X1C4= c[1] & d[1];
//******************************for the rest of Columns except for the last one************
//*******************************for the last column of PPS*****************
assign OL0X1C5= YA[4];
assign OL0X2C5= YB[4];
assign OL0X2C4= YA[3];
assign OL0X3C4= YB[3];
assign OL0X3C3= YA[2];
assign OL0X4C3= YB[2];
assign OL0X2C2= YA[1];
assign OL0X3C2= YB[1];
assign OL0X1C1= YA[0];
assign OL0X2C1= YB[0];
assign OL0X1C6= 1'b 1;
//*********************************************END of Generating Partial Products********************************************************
//***********************************Begin of Level 1 ************************************
assign {OL1X1C2,OL1X1C1}=OL0X2C1+OL0X1C1;
assign {OL1X1C3,OL1X2C2}=OL0X3C2+OL0X2C2+OL0X1C2;
assign {OL1X1C4,OL1X2C3}=OL0X4C3+OL0X3C3+OL0X2C3;
assign {OL1X1C5,OL1X2C4}=OL0X3C4+OL0X2C4+OL0X1C4;
assign {OL1X1C6,OL1X2C5}=OL0X2C5+OL0X1C5;
assign FinalOUT1[0]=OL1X1C1;
//***********************************Begin of Level 2 ************************************
assign {OL2X1C3,OL2X1C2}=OL1X2C2+OL1X1C2;
assign {OL2X1C4,OL2X2C3}=OL0X1C3+OL1X2C3+OL1X1C3;
assign {OL2X1C5,OL2X2C4}=OL1X2C4+OL1X1C4;
assign {OL2X1C6,OL2X2C5}=OL1X2C5+OL1X1C5;
assign {OL2X1C7,OL2X2C6}=OL0X1C6+OL1X1C6;
assign FinalOUT1[1]=OL2X1C2;
wire [4:0] O1,O2;
assign O1[0]=OL2X1C3;
assign O2[0]=OL2X2C3;
assign O1[1]=OL2X1C4;
assign O2[1]=OL2X2C4;
assign O1[2]=OL2X1C5;
assign O2[2]=OL2X2C5;
assign O1[3]=OL2X1C6;
assign O2[3]=OL2X2C6;
assign O1[4]=OL2X1C7;
assign O2[4]=1'b 0;
assign FinalOUT1[6:2]=O1+O2;
assign FinalOUT2=FinalOUT1<<shiftL;
assign FinalOUT={16{zero}} & FinalOUT2[20:5];
endmodule
