// terms: 40
// fval:  7835303.5015

#include <bitset>
#include <cmath>

using namespace std;

uint64_t unsigned_32x32_l10_lamb30_0(uint64_t i, uint64_t j) {

bitset<32> x = i;

bitset<32> part1 = j*x[0];
bitset<32> part2 = j*x[1];
bitset<32> part3 = j*x[2];
bitset<32> part4 = j*x[3];
bitset<32> part5 = j*x[4];
bitset<32> part6 = j*x[5];
bitset<32> part7 = j*x[6];
bitset<32> part8 = j*x[7];
bitset<32> part9 = j*x[8];
bitset<32> part10 = j*x[9];
bitset<32> part11 = j*x[10];
bitset<32> part12 = j*x[11];
bitset<32> part13 = j*x[12];
bitset<32> part14 = j*x[13];
bitset<32> part15 = j*x[14];
bitset<32> part16 = j*x[15];
bitset<32> part17 = j*x[16];
bitset<32> part18 = j*x[17];
bitset<32> part19 = j*x[18];
bitset<32> part20 = j*x[19];
bitset<32> part21 = j*x[20];
bitset<32> part22 = j*x[21];
bitset<32> part23 = j*x[22];
bitset<32> part24 = j*x[23];
bitset<32> part25 = j*x[24];
bitset<32> part26 = j*x[25];
bitset<32> part27 = j*x[26];
bitset<32> part28 = j*x[27];
bitset<32> part29 = j*x[28];
bitset<32> part30 = j*x[29];
bitset<32> part31 = j*x[30];
bitset<32> part32 = j*x[31];

uint64_t tmp_z =  j*x[10]*pow(2, 10) + j*x[11]*pow(2, 11) + j*x[12]*pow(2, 12) + j*x[13]*pow(2, 13) + j*x[14]*pow(2, 14) + j*x[15]*pow(2, 15) + j*x[16]*pow(2, 16) + j*x[17]*pow(2, 17) + j*x[18]*pow(2, 18) + j*x[19]*pow(2, 19) + j*x[20]*pow(2, 20) + j*x[21]*pow(2, 21) + j*x[22]*pow(2, 22) + j*x[23]*pow(2, 23) + j*x[24]*pow(2, 24) + j*x[25]*pow(2, 25) + j*x[26]*pow(2, 26) + j*x[27]*pow(2, 27) + j*x[28]*pow(2, 28) + j*x[29]*pow(2, 29) + j*x[30]*pow(2, 30) + j*x[31]*pow(2, 31);

uint64_t z = tmp_z + (part1[4]|part2[3])*pow(2, 4) + (part1[4]|part2[3])*pow(2, 5) + (part1[9]|part2[8])*pow(2, 9) + (part1[11]&part2[10])*pow(2, 11) + (part1[16]|part2[15])*pow(2, 17) + (part1[23]&part2[22])*pow(2, 23) + (part1[25]&part2[24])*pow(2, 26) + (part1[29]|part2[28])*pow(2, 30) + (part1[30]^part2[29])*pow(2, 31) + (part3[1]&part4[0])*pow(2, 4) + (part3[2]|part4[1])*pow(2, 5) + (part3[8]&part4[7])*pow(2, 10) + (part3[12]&part4[11])*pow(2, 15) + (part3[19]^part4[18])*pow(2, 22) + (part3[26]^part4[25])*pow(2, 29) + (part3[29]&part4[28])*pow(2, 31) + (part3[30]^part4[29])*pow(2, 32) + (part3[31]&part4[30])*pow(2, 33) + (part5[2]&part6[1])*pow(2, 6) + (part5[17]^part6[16])*pow(2, 21) + (part5[22]^part6[21])*pow(2, 26) + (part5[26]^part6[25])*pow(2, 30) + (part5[27]&part6[26])*pow(2, 32) + (part5[27]^part6[26])*pow(2, 32) + (part5[31]^part6[30])*pow(2, 36) + (part7[6]&part8[5])*pow(2, 13) + (part7[11]&part8[10])*pow(2, 17) + (part7[13]^part8[12])*pow(2, 19) + (part7[15]|part8[14])*pow(2, 22) + (part7[21]|part8[20])*pow(2, 28) + (part7[22]|part8[21])*pow(2, 28) + (part7[25]|part8[24])*pow(2, 32) + (part7[26]^part8[25])*pow(2, 32) + (part7[27]|part8[26])*pow(2, 34) + (part7[30]&part8[29])*pow(2, 36) + (part9[0]*pow(2, 8)) + (part9[3]|part10[2])*pow(2, 12) + (part9[5]|part10[4])*pow(2, 14) + (part9[12]|part10[11])*pow(2, 20) + (part9[25]&part10[24])*pow(2, 34);

return z;

}
