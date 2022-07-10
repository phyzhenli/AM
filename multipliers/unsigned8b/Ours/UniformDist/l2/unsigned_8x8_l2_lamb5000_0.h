// terms: 2
// fval:  15755.25

#include <bitset>
#include <cmath>

using namespace std;

uint16_t unsigned_8x8_l2_lamb5000_0(uint16_t i, uint16_t j) {

bitset<8> x = i;

bitset<8> part1 = j*x[0];
bitset<8> part2 = j*x[1];

uint16_t tmp_z = 0  + j*x[2]*pow(2, 2) + j*x[3]*pow(2, 3) + j*x[4]*pow(2, 4) + j*x[5]*pow(2, 5) + j*x[6]*pow(2, 6) + j*x[7]*pow(2, 7);

uint16_t z = tmp_z  + (part1[7]|part2[6])*pow(2, 8) + (part2[7]*pow(2, 8));

return z;

}
