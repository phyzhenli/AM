module Appro_multi(
    input  [7:0]a,
    input  [7:0]b,
    output [15:0]  result 
    );
wire a00,a01,a02,a03,a04,a05,a06,a07;
wire a10,a11,a12,a13,a14,a15,a16,a17;
wire a20,a21,a22,a23,a24,a25,a26,a27;
wire a30,a31,a32,a33,a34,a35,a36,a37;
wire a40,a41,a42,a43,a44,a45,a46,a47;
wire a50,a51,a52,a53,a54,a55,a56,a57;
wire a60,a61,a62,a63,a64,a65,a66,a67;
wire a70,a71,a72,a73,a74,a75,a76,a77;
//-----stage1
assign a00=a[0]&b[0];
assign a01=a[0]&b[1];
assign a02=a[0]&b[2];
assign a03=a[0]&b[3];
assign a04=a[0]&b[4];
assign a05=a[0]&b[5];
assign a06=a[0]&b[6];
assign a07=a[0]&b[7];

assign a10=a[1]&b[0];
assign a11=a[1]&b[1];
assign a12=a[1]&b[2];
assign a13=a[1]&b[3];
assign a14=a[1]&b[4];
assign a15=a[1]&b[5];
assign a16=a[1]&b[6];
assign a17=a[1]&b[7];

assign a20=a[2]&b[0];
assign a21=a[2]&b[1];
assign a22=a[2]&b[2];
assign a23=a[2]&b[3];
assign a24=a[2]&b[4];
assign a25=a[2]&b[5];
assign a26=a[2]&b[6];
assign a27=a[2]&b[7];

assign a30=a[3]&b[0];
assign a31=a[3]&b[1];
assign a32=a[3]&b[2];
assign a33=a[3]&b[3];
assign a34=a[3]&b[4];
assign a35=a[3]&b[5];
assign a36=a[3]&b[6];
assign a37=a[3]&b[7];

assign a40=a[4]&b[0];
assign a41=a[4]&b[1];
assign a42=a[4]&b[2];
assign a43=a[4]&b[3];
assign a44=a[4]&b[4];
assign a45=a[4]&b[5];
assign a46=a[4]&b[6];
assign a47=a[4]&b[7];


assign a50=a[5]&b[0];
assign a51=a[5]&b[1];
assign a52=a[5]&b[2];
assign a53=a[5]&b[3];
assign a54=a[5]&b[4];
assign a55=a[5]&b[5];
assign a56=a[5]&b[6];
assign a57=a[5]&b[7];

assign a60=a[6]&b[0];
assign a61=a[6]&b[1];
assign a62=a[6]&b[2];
assign a63=a[6]&b[3];
assign a64=a[6]&b[4];
assign a65=a[6]&b[5];
assign a66=a[6]&b[6];
assign a67=a[6]&b[7];

assign a70=a[7]&b[0];
assign a71=a[7]&b[1];
assign a72=a[7]&b[2];
assign a73=a[7]&b[3];
assign a74=a[7]&b[4];
assign a75=a[7]&b[5];
assign a76=a[7]&b[6];
assign a77=a[7]&b[7];

//-----stage2
wire p03,p04,p05,p06,p07,p12,p13,p14,p15,p16,p17,p23,p24,p25,p26,p27;
wire p34,p35,p36,p37,p45,p46,p47,p56;
wire g03,g04,g05,g06,g07,g12,g13,g14,g15,g16,g17,g23,g24,g25,g26,g27;
wire g34,g35,g36,g37,g45,g46,g47,g56;

assign p03=a03|a30;
assign p04=a04|a40;
assign p05=a05|a50;
assign p06=a06|a60;
assign p07=a07|a70;
assign p12=a12|a21;
assign p13=a13|a31;
assign p14=a14|a41;
assign p15=a15|a51;
assign p16=a16|a61;
assign p17=a17|a71;
assign p23=a23|a32;
assign p24=a24|a42;
assign p25=a25|a52;
assign p26=a26|a62;
assign p27=a27|a72;
assign p34=a34|a43;
assign p35=a35|a53;
assign p36=a36|a63;
assign p37=a37|a73;
assign p45=a45|a54;
assign p46=a46|a64;
assign p47=a47|a74;
assign p56=a56|a65;

assign g03=a03&a30;
assign g04=a04&a40;
assign g05=a05&a50;
assign g06=a06&a60;
assign g07=a07&a70;
assign g12=a12&a21;
assign g13=a13&a31;
assign g14=a14&a41;
assign g15=a15&a51;
assign g16=a16&a61;
assign g17=a17&a71;
assign g23=a23&a32;
assign g24=a24&a42;
assign g25=a25&a52;
assign g26=a26&a62;
assign g27=a27&a72;
assign g34=a34&a43;
assign g35=a35&a53;
assign g36=a36&a63;
assign g37=a37&a73;
assign g45=a45&a54;
assign g46=a46&a64;
assign g47=a47&a74;
assign g56=a56&a65;

//-----stage3
wire S4,S5,S6,S7,S8,S9,S10,S11,S12;
wire C4,C5,C6,C7,C8,C9,C10,C11,C12;
wire G3,G4,G5,G6,G7,G8,G9,G10,G11;

appro_halfadder mh1(.a(p04),.b(p13),.carry(C4),.sum(S4));
appro_halfadder mh2(.a(p47),.b(p56),.carry(C11),.sum(S11));
appro_halfadder mh3(.a(a57),.b(a75),.carry(C12),.sum(S12));

appro_fulladder mf1(.a(p05),.b(p14),.c(p23),.carry(C5),.sum(S5));
appro_fulladder mf2(.a(p27),.b(p36),.c(p45),.carry(C9),.sum(S9));
appro_fulladder mf3(.a(p37),.b(p46),.c(a55),.carry(C10),.sum(S10));

appro_42 com1(.a(p06),.b(p15),.c(p24),.d(a33),.carry(C6),.sum(S6));
appro_42 com2(.a(p07),.b(p16),.c(p25),.d(p34),.carry(C7),.sum(S7));
appro_42 com3(.a(p17),.b(p26),.c(p35),.d(a44),.carry(C8),.sum(S8));

assign G3 = g03&g12;
assign G4 = g04&g13;
assign G5 = g05&g14&g23;
assign G6 = g06&g15&g24;
assign G7 = g07&g16&g25&g34;
assign G8 = g17&g26&g35;
assign G9 = g27&g36&g45;
assign G10 = g37&g46;
assign G11 = g47&g56;

//-----stage4
wire [14:0]x;
wire [14:0]y;
appro_fulladder mf4(.a(p03),.b(p12),.c(G3),.carry(x[4]),.sum(y[3]));
appro_fulladder mf5(.a(S4),.b(a22),.c(G4),.carry(x[5]),.sum(y[4]));
appro_fulladder mf6(.a(S5),.b(G5),.c(C4),.carry(x[6]),.sum(y[5]));
appro_fulladder mf7(.a(S6),.b(G6),.c(C5),.carry(x[7]),.sum(y[6]));
appro_fulladder mf8(.a(S7),.b(G7),.c(C6),.carry(x[8]),.sum(y[7]));
appro_fulladder mf9(.a(S8),.b(G8),.c(C7),.carry(x[9]),.sum(y[8]));
appro_fulladder mf10(.a(S9),.b(G9),.c(C8),.carry(x[10]),.sum(y[9]));
appro_fulladder mf11(.a(S10),.b(G10),.c(C9),.carry(x[11]),.sum(y[10]));
appro_fulladder mf12(.a(S11),.b(G11),.c(C10),.carry(x[12]),.sum(y[11]));
appro_fulladder mf13(.a(S12),.b(C11),.c(a66),.carry(x[13]),.sum(y[12]));
appro_fulladder mf14(.a(a76),.b(a67),.c(C12),.carry(x[14]),.sum(y[13]));

//assign x[0] = a00;
//assign x[1] = a10;
//assign y[0] = 1'b0;
//assign y[1] = a01;
//assign x[14] = a77;
//
assign x[0] = a00;
assign x[1] = a10|a01;
assign y[0] = 1'b0;
assign y[1] = 1'b0;
assign x[2] = a10&a01;
assign y[14] = a77;
appro_fulladder mf15(.a(a20),.b(a02),.c(a11),.carry(x[3]),.sum(y[2]));

//-----stage5
assign result = x + y; 

endmodule
