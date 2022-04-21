module TOSAM_h0_t2 (A,B,FinalOUT);
input [7:0]A,B;
output [15:0]FinalOUT;
wire zero,sign;
wire [7:0]KA1,KB1;
wire [2:0]KA,KB;
wire [3:0]shiftL;
wire [1:0]YA,YB;
wire [3:0]FinalOUT1;
wire [17:0]FinalOUT2;
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
 assign YA[1]=(KA1[7] && A[6])|| (KA1[6] && A[5]) || (KA1[5] && A[4]) || (KA1[4] && A[3]) || (KA1[3] && A[2]) || (KA1[2] && A[1]) || (KA1[1] && A[0]) ||  (KA1[1] && A[0]);
assign YA[0]=(KA1[7] && A[5])|| (KA1[6] && A[4]) || (KA1[5] && A[3]) || (KA1[4] && A[2]) || (KA1[3] && A[1]) || (KA1[2] && A[0]) ||  (KA1[2] && A[0]);
//**********************************************
 //******************* finding YB ****************************
 assign YB[1]=(KB1[7] && B[6])|| (KB1[6] && B[5]) || (KB1[5] && B[4]) || (KB1[4] && B[3]) || (KB1[3] && B[2]) || (KB1[2] && B[1]) || (KB1[1] && B[0]) ||  (KB1[1] && B[0]);
assign YB[0]=(KB1[7] && B[5])|| (KB1[6] && B[4]) || (KB1[5] && B[3]) || (KB1[4] && B[2]) || (KB1[3] && B[1]) || (KB1[2] && B[0]) ||  (KB1[2] && B[0]);

//*******************Generating zero***************************
assign zero= ((A==8'd 0)||(B==8'd 0)) ? 1'b 0 : 1'b 1 ;
 //*************************Reduction By Wallace***************************
wire carry1,carry2;
assign {carry1,FinalOUT1[0]}=YA[0]+YB[0]+1'b 1;
assign {carry2,FinalOUT1[1]}=YA[1]+YB[1]+carry1;
assign {FinalOUT1[3],FinalOUT1[2]}=1'b 1+carry2;
assign FinalOUT2=FinalOUT1<<shiftL;
assign FinalOUT={16{zero}} & FinalOUT2[17:2];
//assign FinalOUT=FinalOUT2[17:2];
endmodule
