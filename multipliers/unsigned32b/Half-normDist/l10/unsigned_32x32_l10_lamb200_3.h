// terms: 6
// fval:  7835303.4941

#include <bitset>
#include <cmath>

using namespace std;

uint64_t unsigned_32x32_l10_lamb200_3(uint64_t i, uint64_t j) {

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

uint64_t z = tmp_z + (part1[27]|part2[26])*pow(2, 27) + (part3[31]&part4[30])*pow(2, 33) + (part5[7]^part6[6])*pow(2, 11) + (part7[22]|part8[21])*pow(2, 28) + (part7[28]^part8[27])*pow(2, 35) + (part7[30]^part8[29])*pow(2, 37);

return z;

}
