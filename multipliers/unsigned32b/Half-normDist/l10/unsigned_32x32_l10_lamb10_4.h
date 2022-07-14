// terms: 106
// fval:  7835169.462

#include <bitset>
#include <cmath>

using namespace std;

uint64_t unsigned_32x32_l10_lamb10_4(uint64_t i, uint64_t j) {

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

uint64_t z = tmp_z + (part1[1]&part2[0])*pow(2, 1) + (part1[1]^part2[0])*pow(2, 2) + (part1[2]^part2[1])*pow(2, 2) + (part1[3]&part2[2])*pow(2, 4) + (part1[7]^part2[6])*pow(2, 8) + (part1[10]^part2[9])*pow(2, 10) + (part1[12]|part2[11])*pow(2, 13) + (part1[12]^part2[11])*pow(2, 13) + (part1[14]|part2[13])*pow(2, 14) + (part1[16]&part2[15])*pow(2, 17) + (part1[18]&part2[17])*pow(2, 18) + (part1[18]|part2[17])*pow(2, 18) + (part1[19]&part2[18])*pow(2, 19) + (part1[19]|part2[18])*pow(2, 19) + (part1[21]|part2[20])*pow(2, 21) + (part1[22]|part2[21])*pow(2, 23) + (part1[23]|part2[22])*pow(2, 23) + (part1[23]^part2[22])*pow(2, 24) + (part1[26]^part2[25])*pow(2, 27) + (part1[30]^part2[29])*pow(2, 30) + (part3[1]&part4[0])*pow(2, 4) + (part3[2]|part4[1])*pow(2, 5) + (part3[3]&part4[2])*pow(2, 5) + (part3[3]|part4[2])*pow(2, 6) + (part3[3]^part4[2])*pow(2, 6) + (part3[4]&part4[3])*pow(2, 6) + (part3[4]|part4[3])*pow(2, 6) + (part3[4]|part4[3])*pow(2, 7) + (part3[5]&part4[4])*pow(2, 8) + (part3[6]^part4[5])*pow(2, 9) + (part3[9]&part4[8])*pow(2, 11) + (part3[9]&part4[8])*pow(2, 12) + (part3[10]&part4[9])*pow(2, 13) + (part3[14]^part4[13])*pow(2, 17) + (part3[15]^part4[14])*pow(2, 17) + (part3[15]^part4[14])*pow(2, 18) + (part3[16]|part4[15])*pow(2, 18) + (part3[17]&part4[16])*pow(2, 20) + (part3[19]^part4[18])*pow(2, 21) + (part3[21]^part4[20])*pow(2, 24) + (part3[23]&part4[22])*pow(2, 25) + (part3[23]^part4[22])*pow(2, 25) + (part3[26]|part4[25])*pow(2, 29) + (part3[30]&part4[29])*pow(2, 33) + (part5[0]*pow(2, 4)) + (part5[1]&part6[0])*pow(2, 5) + (part5[2]|part6[1])*pow(2, 6) + (part5[3]&part6[2])*pow(2, 7) + (part5[3]^part6[2])*pow(2, 7) + (part5[6]^part6[5])*pow(2, 10) + (part5[7]&part6[6])*pow(2, 11) + (part5[8]^part6[7])*pow(2, 13) + (part5[12]&part6[11])*pow(2, 17) + (part5[13]&part6[12])*pow(2, 17) + (part5[14]&part6[13])*pow(2, 18) + (part5[16]&part6[15])*pow(2, 21) + (part5[17]|part6[16])*pow(2, 21) + (part5[18]|part6[17])*pow(2, 22) + (part5[20]|part6[19])*pow(2, 25) + (part5[26]&part6[25])*pow(2, 30) + (part5[26]&part6[25])*pow(2, 31) + (part5[30]^part6[29])*pow(2, 34) + (part7[1]&part8[0])*pow(2, 8) + (part7[3]&part8[2])*pow(2, 9) + (part7[3]|part8[2])*pow(2, 9) + (part7[6]&part8[5])*pow(2, 12) + (part7[11]&part8[10])*pow(2, 17) + (part7[11]&part8[10])*pow(2, 18) + (part7[11]^part8[10])*pow(2, 18) + (part7[13]|part8[12])*pow(2, 19) + (part7[16]|part8[15])*pow(2, 23) + (part7[18]|part8[17])*pow(2, 24) + (part7[18]|part8[17])*pow(2, 25) + (part7[18]^part8[17])*pow(2, 25) + (part7[21]&part8[20])*pow(2, 27) + (part7[21]^part8[20])*pow(2, 28) + (part7[23]^part8[22])*pow(2, 30) + (part7[24]&part8[23])*pow(2, 30) + (part7[24]&part8[23])*pow(2, 31) + (part7[25]^part8[24])*pow(2, 32) + (part7[27]^part8[26])*pow(2, 34) + (part7[29]^part8[28])*pow(2, 36) + (part7[30]|part8[29])*pow(2, 37) + (part9[2]&part10[1])*pow(2, 11) + (part9[3]|part10[2])*pow(2, 12) + (part9[8]&part10[7])*pow(2, 16) + (part9[11]^part10[10])*pow(2, 20) + (part9[12]&part10[11])*pow(2, 21) + (part9[13]&part10[12])*pow(2, 21) + (part9[14]&part10[13])*pow(2, 23) + (part9[15]|part10[14])*pow(2, 23) + (part9[15]|part10[14])*pow(2, 24) + (part9[17]&part10[16])*pow(2, 25) + (part9[17]|part10[16])*pow(2, 25) + (part9[17]|part10[16])*pow(2, 26) + (part9[17]^part10[16])*pow(2, 26) + (part9[18]^part10[17])*pow(2, 27) + (part9[20]&part10[19])*pow(2, 28) + (part9[21]&part10[20])*pow(2, 29) + (part9[22]&part10[21])*pow(2, 31) + (part9[22]^part10[21])*pow(2, 30) + (part9[23]&part10[22])*pow(2, 31) + (part9[27]&part10[26])*pow(2, 35) + (part9[28]|part10[27])*pow(2, 36) + (part9[29]^part10[28])*pow(2, 37) + (part9[31]|part10[30])*pow(2, 40);

return z;

}
