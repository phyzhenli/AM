// terms: 29
// fval:  328374.25

#include <bitset>
#include <cmath>

using namespace std;

uint16_t unsigned_8x8_l8_lamb10000_7(uint16_t i, uint16_t j) {

bitset<8> x = i;

bitset<8> part1 = j*x[0];
bitset<8> part2 = j*x[1];
bitset<8> part3 = j*x[2];
bitset<8> part4 = j*x[3];
bitset<8> part5 = j*x[4];
bitset<8> part6 = j*x[5];
bitset<8> part7 = j*x[6];
bitset<8> part8 = j*x[7];

uint16_t tmp_z = 0 ;

uint16_t z = tmp_z  + (part1[7]|part2[6])*pow(2, 8) + (part2[7]*pow(2, 8)) + (part3[5]|part4[4])*pow(2, 8) + (part3[6]|part4[5])*pow(2, 8) + (part3[7]&part4[6])*pow(2, 9) + (part3[7]|part4[6])*pow(2, 9) + (part4[7]*pow(2, 10)) + (part5[3]|part6[2])*pow(2, 8) + (part5[4]|part6[3])*pow(2, 8) + (part5[5]&part6[4])*pow(2, 9) + (part5[5]|part6[4])*pow(2, 9) + (part5[6]&part6[5])*pow(2, 10) + (part5[6]|part6[5])*pow(2, 10) + (part5[7]&part6[6])*pow(2, 12) + (part5[7]^part6[6])*pow(2, 11) + (part6[7]*pow(2, 12)) + (part7[1]|part8[0])*pow(2, 8) + (part7[2]|part8[1])*pow(2, 8) + (part7[3]&part8[2])*pow(2, 9) + (part7[3]|part8[2])*pow(2, 9) + (part7[4]&part8[3])*pow(2, 10) + (part7[4]|part8[3])*pow(2, 10) + (part7[5]&part8[4])*pow(2, 12) + (part7[5]^part8[4])*pow(2, 11) + (part7[6]&part8[5])*pow(2, 12) + (part7[6]|part8[5])*pow(2, 12) + (part7[7]&part8[6])*pow(2, 13) + (part7[7]|part8[6])*pow(2, 13) + (part8[7]*pow(2, 14));

return z;

}
