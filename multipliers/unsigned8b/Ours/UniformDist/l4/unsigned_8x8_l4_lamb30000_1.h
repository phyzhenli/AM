// terms: 4
// fval:  203786.25

#include <bitset>
#include <cmath>

using namespace std;

uint16_t unsigned_8x8_l4_lamb30000_1(uint16_t i, uint16_t j) {

bitset<8> x = i;

bitset<8> part1 = j*x[0];
bitset<8> part2 = j*x[1];
bitset<8> part3 = j*x[2];
bitset<8> part4 = j*x[3];

uint16_t tmp_z = 0  + j*x[4]*pow(2, 4) + j*x[5]*pow(2, 5) + j*x[6]*pow(2, 6) + j*x[7]*pow(2, 7);

uint16_t z = tmp_z  + (part2[7]*pow(2, 8)) + (part3[6]|part4[5])*pow(2, 8) + (part3[7]|part4[6])*pow(2, 10) + (part4[7]*pow(2, 10));

return z;

}
