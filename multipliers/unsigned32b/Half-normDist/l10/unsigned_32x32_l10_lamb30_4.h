// terms: 47
// fval:  7835515.2747

#include <bitset>
#include <cmath>

using namespace std;

uint64_t unsigned_32x32_l10_lamb30_4(uint64_t i, uint64_t j) {

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

uint64_t z = tmp_z + (part1[5]&part2[4])*pow(2, 5) + (part1[13]&part2[12])*pow(2, 14) + (part1[13]^part2[12])*pow(2, 14) + (part1[22]|part2[21])*pow(2, 22) + (part1[25]|part2[24])*pow(2, 25) + (part1[25]^part2[24])*pow(2, 26) + (part1[29]&part2[28])*pow(2, 30) + (part3[2]|part4[1])*pow(2, 5) + (part3[7]|part4[6])*pow(2, 9) + (part3[10]^part4[9])*pow(2, 13) + (part3[11]^part4[10])*pow(2, 13) + (part3[13]&part4[12])*pow(2, 15) + (part3[14]&part4[13])*pow(2, 17) + (part3[18]^part4[17])*pow(2, 20) + (part3[23]^part4[22])*pow(2, 25) + (part5[3]^part6[2])*pow(2, 8) + (part5[7]&part6[6])*pow(2, 12) + (part5[8]|part6[7])*pow(2, 13) + (part5[9]^part6[8])*pow(2, 13) + (part5[9]^part6[8])*pow(2, 14) + (part5[10]^part6[9])*pow(2, 15) + (part5[11]&part6[10])*pow(2, 16) + (part5[12]|part6[11])*pow(2, 17) + (part5[19]|part6[18])*pow(2, 24) + (part5[26]&part6[25])*pow(2, 31) + (part5[27]|part6[26])*pow(2, 32) + (part5[28]&part6[27])*pow(2, 32) + (part5[28]|part6[27])*pow(2, 33) + (part5[30]^part6[29])*pow(2, 35) + (part5[31]|part6[30])*pow(2, 35) + (part6[31]*pow(2, 36)) + (part7[1]&part8[0])*pow(2, 7) + (part7[7]|part8[6])*pow(2, 14) + (part7[8]|part8[7])*pow(2, 14) + (part7[13]^part8[12])*pow(2, 20) + (part7[14]^part8[13])*pow(2, 21) + (part7[19]|part8[18])*pow(2, 25) + (part7[27]&part8[26])*pow(2, 34) + (part7[27]^part8[26])*pow(2, 34) + (part7[29]^part8[28])*pow(2, 36) + (part9[2]&part10[1])*pow(2, 10) + (part9[3]|part10[2])*pow(2, 11) + (part9[8]&part10[7])*pow(2, 17) + (part9[8]|part10[7])*pow(2, 16) + (part9[14]&part10[13])*pow(2, 23) + (part9[20]^part10[19])*pow(2, 29) + (part9[30]^part10[29])*pow(2, 39);

return z;

}
