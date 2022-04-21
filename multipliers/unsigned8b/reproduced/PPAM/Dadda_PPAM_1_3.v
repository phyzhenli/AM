module Dadda_PPAM_1_3(A,B,P);

 input [7:0] A,B; 
 output [15:0] P; 

 wire [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7 ; 
 
 wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14;
 
 wire cr7, cr8, cr9, cr10, cr11, cr12, cr13;
 
 wire co1, co2, co3, co4, co5, co6, co7, co8, co9, co10, co11, co12, co13, co14;
 
 
/////////////////////////// Partial Products ////////////////////////////////
////////////////// PP 0////////////////////////////
  AND2 U0 (.A1(A[0]),.A2(B[0]),.Z(pp0[0]));
  AND2 U1 (.A1(A[1]),.A2(B[0]),.Z(pp0[1]));
  AND2 U2 (.A1(A[2]),.A2(B[0]),.Z(pp0[2]));
  AND2 U3 (.A1(A[3]),.A2(B[0]),.Z(pp0[3]));
  AND2 U4 (.A1(A[4]),.A2(B[0]),.Z(pp0[4]));
  AND2 U5 (.A1(A[5]),.A2(B[0]),.Z(pp0[5]));
  AND2 U6 (.A1(A[6]),.A2(B[0]),.Z(pp0[6]));
  AND2 u7 (.A1(A[7]),.A2(B[0]),.Z(pp0[7]));
////////////////// PP 1////////////////////////////
  AND2 U7 (.A1(A[0]),.A2(B[1]),.Z(pp1[0]));
  AND2 U8 (.A1(A[1]),.A2(B[1]),.Z(pp1[1]));
  AND2 U9 (.A1(A[2]),.A2(B[1]),.Z(pp1[2]));
  AND2 U10 (.A1(A[3]),.A2(B[1]),.Z(pp1[3]));
  AND2 U11 (.A1(A[4]),.A2(B[1]),.Z(pp1[4]));
  AND2 U12 (.A1(A[5]),.A2(B[1]),.Z(pp1[5]));
  AND2 U13 (.A1(A[6]),.A2(B[1]),.Z(pp1[6]));
  AND2 u14 (.A1(A[7]),.A2(B[1]),.Z(pp1[7]));
////////////////// PP 2////////////////////////////
  AND2 U14 (.A1(A[0]),.A2(B[2]),.Z(pp2[0]));
  AND2 U15 (.A1(A[1]),.A2(B[2]),.Z(pp2[1]));
  AND2 U16 (.A1(A[2]),.A2(B[2]),.Z(pp2[2]));
  AND2 U17 (.A1(A[3]),.A2(B[2]),.Z(pp2[3]));
  AND2 U18 (.A1(A[4]),.A2(B[2]),.Z(pp2[4]));
  AND2 U19 (.A1(A[5]),.A2(B[2]),.Z(pp2[5]));
  AND2 U20 (.A1(A[6]),.A2(B[2]),.Z(pp2[6]));
  AND2 u21 (.A1(A[7]),.A2(B[2]),.Z(pp2[7]));
////////////////// PP 3////////////////////////////
  AND2 U21 (.A1(A[0]),.A2(B[3]),.Z(pp3[0]));
  AND2 U22 (.A1(A[1]),.A2(B[3]),.Z(pp3[1]));
  AND2 U23 (.A1(A[2]),.A2(B[3]),.Z(pp3[2]));
  AND2 U24 (.A1(A[3]),.A2(B[3]),.Z(pp3[3]));
  AND2 U25 (.A1(A[4]),.A2(B[3]),.Z(pp3[4]));
  AND2 U26 (.A1(A[5]),.A2(B[3]),.Z(pp3[5]));
  AND2 U27 (.A1(A[6]),.A2(B[3]),.Z(pp3[6]));
  AND2 u28 (.A1(A[7]),.A2(B[3]),.Z(pp3[7]));
////////////////// PP 4////////////////////////////
  AND2 U28 (.A1(A[0]),.A2(B[4]),.Z(pp4[0]));
  AND2 U29 (.A1(A[1]),.A2(B[4]),.Z(pp4[1]));
  AND2 U30 (.A1(A[2]),.A2(B[4]),.Z(pp4[2]));
  AND2 U31 (.A1(A[3]),.A2(B[4]),.Z(pp4[3]));
  AND2 U32 (.A1(A[4]),.A2(B[4]),.Z(pp4[4]));
  AND2 U33 (.A1(A[5]),.A2(B[4]),.Z(pp4[5]));
  AND2 U34 (.A1(A[6]),.A2(B[4]),.Z(pp4[6]));
  AND2 u35 (.A1(A[7]),.A2(B[4]),.Z(pp4[7]));
////////////////// PP 5////////////////////////////
  AND2 U35 (.A1(A[0]),.A2(B[5]),.Z(pp5[0]));
  AND2 U36 (.A1(A[1]),.A2(B[5]),.Z(pp5[1]));
  AND2 U37 (.A1(A[2]),.A2(B[5]),.Z(pp5[2]));
  AND2 U38 (.A1(A[3]),.A2(B[5]),.Z(pp5[3]));
  AND2 U39 (.A1(A[4]),.A2(B[5]),.Z(pp5[4]));
  AND2 U40 (.A1(A[5]),.A2(B[5]),.Z(pp5[5]));
  AND2 U41 (.A1(A[6]),.A2(B[5]),.Z(pp5[6]));
  AND2 u41 (.A1(A[7]),.A2(B[5]),.Z(pp5[7]));
////////////////// PP 6////////////////////////////
  AND2 U42 (.A1(A[0]),.A2(B[6]),.Z(pp6[0]));
  AND2 U43 (.A1(A[1]),.A2(B[6]),.Z(pp6[1]));
  AND2 U44 (.A1(A[2]),.A2(B[6]),.Z(pp6[2]));
  AND2 U45 (.A1(A[3]),.A2(B[6]),.Z(pp6[3]));
  AND2 U46 (.A1(A[4]),.A2(B[6]),.Z(pp6[4]));
  AND2 U47 (.A1(A[5]),.A2(B[6]),.Z(pp6[5]));
  AND2 U48 (.A1(A[6]),.A2(B[6]),.Z(pp6[6]));
  AND2 u48 (.A1(A[7]),.A2(B[6]),.Z(pp6[7]));
  ////////////////// PP 7////////////////////////////
  AND2 u49 (.A1(A[0]),.A2(B[7]),.Z(pp7[0]));
  AND2 u50 (.A1(A[1]),.A2(B[7]),.Z(pp7[1]));
  AND2 u51 (.A1(A[2]),.A2(B[7]),.Z(pp7[2]));
  AND2 u52 (.A1(A[3]),.A2(B[7]),.Z(pp7[3]));
  AND2 u53 (.A1(A[4]),.A2(B[7]),.Z(pp7[4]));
  AND2 u54 (.A1(A[5]),.A2(B[7]),.Z(pp7[5]));
  AND2 u55 (.A1(A[6]),.A2(B[7]),.Z(pp7[6]));
  AND2 u56 (.A1(A[7]),.A2(B[7]),.Z(pp7[7]));
////////////////////////////////////// Level 1 /////////////////////
  HA U69 (.A(pp0[7]), .B(pp4[3]), .CO(co1), .S(s1));
  HA U70 (.A(pp4[4]), .B(pp5[3]), .CO(co2), .S(s2));
  HA U71 (.A(pp4[5]), .B(pp5[4]), .CO(co3), .S(s3));
  HA U72 (.A(pp4[6]), .B(pp5[5]), .CO(co4), .S(s4));
  HA U73 (.A(pp4[7]), .B(pp5[6]), .CO(co5), .S(s5));     
////////////////////////////////////// Level 2 /////////////////////
  HA U61 (.A(pp0[5]), .B(pp4[1]), .CO(co6), .S(s6));
  COMP4to2 U62 (.X1(pp0[6]),.X2(pp4[2]),.X3(pp5[1]),.X4(pp6[0]),.Cin(co6),.Cout(co7),.Sum(s7),.Carry(cr7));
  COMP4to2 U63 (.X1(s1),.X2(pp5[2]),.X3(pp6[1]),.X4(pp7[0]),.Cin(co7),.Cout(co8),.Sum(s8),.Carry(cr8));
  COMP4to2 U64 (.X1(s2),.X2(co1),.X3(pp6[2]),.X4(pp7[1]),.Cin(co8),.Cout(co9),.Sum(s9),.Carry(cr9));
  COMP4to2 U65 (.X1(s3),.X2(co2),.X3(pp6[3]),.X4(pp7[2]),.Cin(co9),.Cout(co10),.Sum(s10),.Carry(cr10));
  COMP4to2 U66 (.X1(s4),.X2(co3),.X3(pp6[4]),.X4(pp7[3]),.Cin(co10),.Cout(co11),.Sum(s11),.Carry(cr11));
  COMP4to2 U67 (.X1(s5),.X2(co4),.X3(pp6[5]),.X4(pp7[4]),.Cin(co11),.Cout(co12),.Sum(s12),.Carry(cr12));
  COMP4to2 U68 (.X1(co5),.X2(pp5[7]),.X3(pp6[6]),.X4(pp7[5]),.Cin(co12),.Cout(co13),.Sum(s13),.Carry(cr13));
  FA U74 (.A(pp6[7]), .B(pp7[6]), .CI(co13), .CO(co14), .S(s14));
////////////////////////////////////////////////////////////////// 
   
  assign P = {pp7[7],s14,s13,s12,s11,s10,s9,s8,s7,s6,pp0[4],pp0[3],pp0[2],pp0[1],pp0[0]} + {co14,cr13,cr12,cr11,cr10,cr9,cr8,cr7,1'd0,pp5[0],pp4[0],1'd0,1'd0,1'd0,1'd0} ;
  

endmodule

module AND2 (A1, A2, Z);
  input A1;
  input A2;
  output Z;

  and(Z, A1, A2);

endmodule

module COMP4to2 (X1, X2, X3, X4, Cin, Cout, Sum, Carry);
  
 input X1, X2, X3, X4, Cin; 
 output Cout, Sum, Carry; 
 
 
 assign Sum = X1 ^ X2 ^ X3 ^ X4 ^ Cin;
 assign Carry = ((X1 ^ X2 ^ X3 ^ X4) & Cin) | (~(X1 ^ X2 ^ X3 ^ X4) & X4) ;
 assign Cout = ((X1 ^ X2) & X3) | (~(X1 ^ X2) & X1);

endmodule

module FA (A, B, CI, CO, S);
  input A;
  input B;
  input CI;
  output CO;
  output S;

  or(CO, i_16, i_17);
  and(i_16, A, B);
  and(i_17, CI, i_18);
  or(i_18, A, B);
  xor(S, CI, i_22);
  xor(i_22, A, B);
  
endmodule

module HA (A, B, CO, S);
  input A;
  input B;
  output CO;
  output S;

  and(CO, A, B);
  xor(S, A, B);

endmodule