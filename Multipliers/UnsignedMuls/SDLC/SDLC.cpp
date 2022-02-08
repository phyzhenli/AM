#include <bitset>
#include <vector>
#include <cmath>
#include <iostream>
#include <string>
#include <fstream>
#include <random>
#include <time.h>

using namespace std;

int func(int& i, int& j, const int& bit) {

    const int bitw = 8;


    vector<int> v;
    bitset<bitw> x = i;
    for (int cdx = 0; cdx < bit; ++cdx) {
        bitset<bitw> part_pro = j*x[cdx];
        for (int count = 0; count < bit; ++count)
            v.push_back(part_pro[count]);
    }
    v.insert(v.begin(), 0);

// v[1]*pow(2,0) + v[2]*pow(2,1) + v[3]*pow(2,2) + v[4]*pow(2,3) + v[5]*pow(2,4) + v[6]*pow(2,5) + v[7]*pow(2,6) + v[8]*pow(2,7) + v[9]*pow(2,1) + v[10]*pow(2,2) + v[11]*pow(2,3) + v[12]*pow(2,4) + v[13]*pow(2,5) + v[14]*pow(2,6) + v[15]*pow(2,7) + v[16]*pow(2,8) + v[17]*pow(2,2) + v[18]*pow(2,3) + v[19]*pow(2,4) + v[20]*pow(2,5) + v[21]*pow(2,6) + v[22]*pow(2,7) + v[23]*pow(2,8) + v[24]*pow(2,9) + v[25]*pow(2,3) + v[26]*pow(2,4) + v[27]*pow(2,5) + v[28]*pow(2,6) + v[29]*pow(2,7) + v[30]*pow(2,8) + v[31]*pow(2,9) + v[32]*pow(2,10) + v[33]*pow(2,4) + v[34]*pow(2,5) + v[35]*pow(2,6) + v[36]*pow(2,7) + v[37]*pow(2,8) + v[38]*pow(2,9) + v[39]*pow(2,10) + v[40]*pow(2,11) + v[41]*pow(2,5) + v[42]*pow(2,6) + v[43]*pow(2,7) + v[44]*pow(2,8) + v[45]*pow(2,9) + v[46]*pow(2,10) + v[47]*pow(2,11) + v[48]*pow(2,12) + v[49]*pow(2,6) + v[50]*pow(2,7) + v[51]*pow(2,8) + v[52]*pow(2,9) + v[53]*pow(2,10) + v[54]*pow(2,11) + v[55]*pow(2,12) + v[56]*pow(2,13) + v[57]*pow(2,7) + v[58]*pow(2,8) + v[59]*pow(2,9) + v[60]*pow(2,10) + v[61]*pow(2,11) + v[62]*pow(2,12) + v[63]*pow(2,13) + v[64]*pow(2,14)

    return 
v[1]*pow(2, 0) + (v[2]|v[9])*pow(2, 1) + (v[3]|v[10])*pow(2, 2) + (v[4]|v[11])*pow(2, 3) + (v[5]|v[12])*pow(2, 4) + (v[6]|v[13])*pow(2, 5) + (v[7]|v[14])*pow(2, 6) + (v[8]|v[15])*pow(2, 7) + v[16]*pow(2, 8) + v[17]*pow(2, 2) + (v[18]|v[25])*pow(2, 3) + (v[19]|v[26])*pow(2, 4) + (v[20]|v[27])*pow(2, 5) + (v[21]|v[28])*pow(2, 6) + (v[22]|v[29])*pow(2, 7) + (v[23]|v[30])*pow(2, 8) + (v[24])*pow(2, 9) + (v[31])*pow(2, 9) + v[32]*pow(2, 10) + v[33]*pow(2, 4) + (v[34]|v[41])*pow(2, 5) + (v[35]|v[42])*pow(2, 6) + (v[36]|v[43])*pow(2, 7) + (v[37]|v[44])*pow(2, 8) + (v[38]|v[45])*pow(2, 9) + (v[39])*pow(2, 10) + (v[46])*pow(2, 10) + (v[40])*pow(2, 11)  + (v[47])*pow(2, 11) + v[48]*pow(2, 12) + v[49]*pow(2, 6) + (v[50]|v[57])*pow(2, 7) + (v[51]|v[58])*pow(2, 8) + (v[52]|v[59])*pow(2, 9) + (v[53]|v[60])*pow(2, 10) + (v[54])*pow(2, 11)  + (v[61])*pow(2, 11) + (v[55])*pow(2, 12) + (v[62])*pow(2, 12) + (v[56])*pow(2, 13) + (v[63])*pow(2, 13) + v[64]*pow(2, 14);
}


int main()
{
    const int bit = 8;

    string s = "test.txt";
    ofstream outfile(s.c_str());

    double error = 0;
    for (int i = 0; i < pow(2, bit); ++i) {
        for (int j = 0; j < pow(2, bit); ++j) {
            error += pow(i*j - func(i, j, bit), 2);
                outfile << func(i, j, bit) << " ";

            if (func(i, j, bit) > 65025)
                cout << "大于65025" << endl;

        }
        outfile << endl;
    }
    cout << error << endl;
}