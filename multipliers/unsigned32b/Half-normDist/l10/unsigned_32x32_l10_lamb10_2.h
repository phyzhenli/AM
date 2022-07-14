// terms: 104
// fval:  7835146.1259

#include <bitset>
#include <cmath>

using namespace std;

uint64_t unsigned_32x32_l10_lamb10_2(uint64_t i, uint64_t j) {

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

uint64_t z = tmp_z + (part1[1]&part2[0])*pow(2, 2) + (part1[2]&part2[1])*pow(2, 3) + (part1[4]&part2[3])*pow(2, 5) + (part1[5]|part2[4])*pow(2, 5) + (part1[5]^part2[4])*pow(2, 5) + (part1[7]&part2[6])*pow(2, 7) + (part1[8]|part2[7])*pow(2, 8) + (part1[11]&part2[10])*pow(2, 12) + (part1[11]|part2[10])*pow(2, 12) + (part1[12]&part2[11])*pow(2, 13) + (part1[13]|part2[12])*pow(2, 13) + (part1[13]|part2[12])*pow(2, 14) + (part1[14]&part2[13])*pow(2, 15) + (part1[18]&part2[17])*pow(2, 19) + (part1[22]|part2[21])*pow(2, 22) + (part1[23]|part2[22])*pow(2, 23) + (part1[23]^part2[22])*pow(2, 23) + (part1[24]^part2[23])*pow(2, 24) + (part1[26]^part2[25])*pow(2, 27) + (part1[28]^part2[27])*pow(2, 29) + (part1[30]|part2[29])*pow(2, 30) + (part1[31]^part2[30])*pow(2, 32) + (part3[2]&part4[1])*pow(2, 4) + (part3[7]&part4[6])*pow(2, 10) + (part3[8]|part4[7])*pow(2, 10) + (part3[9]&part4[8])*pow(2, 12) + (part3[10]|part4[9])*pow(2, 13) + (part3[11]&part4[10])*pow(2, 13) + (part3[12]^part4[11])*pow(2, 14) + (part3[18]^part4[17])*pow(2, 20) + (part3[19]&part4[18])*pow(2, 22) + (part3[22]^part4[21])*pow(2, 24) + (part3[23]&part4[22])*pow(2, 26) + (part3[24]&part4[23])*pow(2, 27) + (part3[26]^part4[25])*pow(2, 28) + (part3[27]|part4[26])*pow(2, 29) + (part3[29]|part4[28])*pow(2, 32) + (part3[31]^part4[30])*pow(2, 33) + (part5[1]&part6[0])*pow(2, 5) + (part5[1]&part6[0])*pow(2, 6) + (part5[3]^part6[2])*pow(2, 8) + (part5[5]&part6[4])*pow(2, 10) + (part5[5]^part6[4])*pow(2, 10) + (part5[7]|part6[6])*pow(2, 11) + (part5[8]|part6[7])*pow(2, 13) + (part5[11]&part6[10])*pow(2, 15) + (part5[11]&part6[10])*pow(2, 16) + (part5[12]&part6[11])*pow(2, 17) + (part5[15]^part6[14])*pow(2, 20) + (part5[16]^part6[15])*pow(2, 20) + (part5[17]&part6[16])*pow(2, 22) + (part5[17]^part6[16])*pow(2, 21) + (part5[17]^part6[16])*pow(2, 22) + (part5[18]&part6[17])*pow(2, 23) + (part5[20]|part6[19])*pow(2, 24) + (part5[20]|part6[19])*pow(2, 25) + (part5[21]|part6[20])*pow(2, 25) + (part5[22]&part6[21])*pow(2, 26) + (part5[23]^part6[22])*pow(2, 27) + (part5[24]|part6[23])*pow(2, 28) + (part5[24]^part6[23])*pow(2, 29) + (part5[26]|part6[25])*pow(2, 31) + (part5[27]|part6[26])*pow(2, 32) + (part5[29]&part6[28])*pow(2, 33) + (part5[29]&part6[28])*pow(2, 34) + (part5[31]&part6[30])*pow(2, 35) + (part5[31]|part6[30])*pow(2, 35) + (part5[31]^part6[30])*pow(2, 36) + (part7[1]|part8[0])*pow(2, 8) + (part7[2]|part8[1])*pow(2, 9) + (part7[3]^part8[2])*pow(2, 10) + (part7[5]&part8[4])*pow(2, 12) + (part7[6]^part8[5])*pow(2, 13) + (part7[8]|part8[7])*pow(2, 15) + (part7[9]^part8[8])*pow(2, 15) + (part7[16]&part8[15])*pow(2, 22) + (part7[16]&part8[15])*pow(2, 23) + (part7[16]|part8[15])*pow(2, 23) + (part7[19]^part8[18])*pow(2, 25) + (part7[21]|part8[20])*pow(2, 27) + (part7[22]&part8[21])*pow(2, 28) + (part7[22]^part8[21])*pow(2, 28) + (part7[25]&part8[24])*pow(2, 32) + (part7[25]^part8[24])*pow(2, 31) + (part7[26]&part8[25])*pow(2, 33) + (part7[26]^part8[25])*pow(2, 32) + (part7[28]^part8[27])*pow(2, 34) + (part7[29]|part8[28])*pow(2, 35) + (part7[30]^part8[29])*pow(2, 36) + (part7[31]|part8[30])*pow(2, 37) + (part9[0]*pow(2, 8)) + (part9[1]&part10[0])*pow(2, 10) + (part9[2]&part10[1])*pow(2, 11) + (part9[9]|part10[8])*pow(2, 17) + (part9[10]^part10[9])*pow(2, 18) + (part9[10]^part10[9])*pow(2, 19) + (part9[13]&part10[12])*pow(2, 21) + (part9[13]^part10[12])*pow(2, 22) + (part9[16]^part10[15])*pow(2, 24) + (part9[20]^part10[19])*pow(2, 29) + (part9[21]&part10[20])*pow(2, 29) + (part9[22]^part10[21])*pow(2, 30) + (part9[26]&part10[25])*pow(2, 34) + (part9[31]|part10[30])*pow(2, 39);

return z;

}
