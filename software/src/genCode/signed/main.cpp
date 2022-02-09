#include <iostream>
#include <fstream>
#include <cmath>

using namespace std;

void generate(const int& bit, const int& i, const string& s, int &index, const int& mb, const int& numb, const int& loc, ofstream& write) {

    for (int m = mb; m < mb +floor(log(numb)/log(2)) +1; ++m) {
        write << "n(" << index << ",1) = (-1)*(";
        if (s == ",") for (int j = 0; j < numb-1; ++j) write << "xor(";
        for (int j = 0; j < numb; ++j) {
            if (j == 0) write << "f(1,"  << loc+i           << ")";
            else {
                write << s << "f(1," << loc+i+j*(bit-1) << ")";
                if (s == ",") write << ")";
            }
        }
        write << ")*(2^" << m << ");" << endl;
        index++;
    }
}


void output(const int &b, const int &e, int &index, const int &bit, ofstream &write) {
    int d = e - b;
    int loc = (b-1)*bit;

    // row b, columns 1-bit
    for (int i = 1; i < bit+1; ++i) {
        int mb = b-1+(i-1);
        int numb;

        if (i == 1) {
            write << "n(" << index << ",1) = (-1)*" << "f(1," << loc+i << ")*(2^" << mb << ");" << endl;
            index++;
        }
        else { 
            if (i < 1+d +1) numb = i;
            else numb = 1+d;
            // 与
            generate(bit, i, "&", index, mb, numb, loc, write);
            // 或
            generate(bit, i, "|", index, mb, numb, loc, write);
            // 异或
            generate(bit, i, ",", index, mb, numb, loc, write);
        }
    }

    // columns e-b
    for (int c = b + 1; c < e; ++c) {
        int mb = (bit-1)+(c-1);
        int numb = e - c + 1;
        
        // AND
        for (int m = mb; m < mb +floor(log(numb)/log(2)) +1; ++m) {
            write << "n(" << index << ",1) = (-1)*(";
            for (int j = 0; j < numb; ++j) {
                if (j == 0) write << "f(1,"  << c*bit           << ")";
                else        write << "&f(1," << c*bit+j*(bit-1) << ")";
            }
            write << ")*(2^" << m << ");" << endl;
            index++;
        }
        // OR
        for (int m = mb; m < mb +floor(log(numb)/log(2)) +1; ++m) {
            write << "n(" << index << ",1) = (-1)*(";
            for (int j = 0; j < numb; ++j) {
                if (j == 0) write << "f(1,"  << c*bit           << ")";
                else        write << "|f(1," << c*bit+j*(bit-1) << ")";
            }
            write << ")*(2^" << m << ");" << endl;
            index++;
        }
        // XOR
        for (int m = mb; m < mb +floor(log(numb)/log(2)) +1; ++m) {
            write << "n(" << index << ",1) = (-1)*(";
            for (int j = 0; j < numb-1; ++j) write << "xor(";
            for (int j = 0; j < numb; ++j) {
                if (j == 0) write << "f(1,"  << c*bit           << ")";
                else        write << ",f(1," << c*bit+j*(bit-1) << "))";
            }
            write << ")*(2^" << m << ");" << endl;
            index++;
        }
    }

    // for signed multipliers
    if (b == 1) {
        write << "n(" << index << ",1) = (-1)*(" << "f(1," << e*bit << ")&f(1," << bit*bit+2 << "))*(2^" << (bit-1)+(e-1) << ");" << endl; index++;
        write << "n(" << index << ",1) = (-1)*(" << "f(1," << e*bit << ")&f(1," << bit*bit+2 << "))*(2^" << (bit-1)+(e-1)+1 << ");" << endl; index++;
        
        write << "n(" << index << ",1) = (-1)*(" << "f(1," << e*bit << ")|f(1," << bit*bit+2 << "))*(2^" << (bit-1)+(e-1) << ");" << endl; index++;
        write << "n(" << index << ",1) = (-1)*(" << "f(1," << e*bit << ")|f(1," << bit*bit+2 << "))*(2^" << (bit-1)+(e-1)+1 << ");" << endl; index++;
        write << "n(" << index << ",1) = (-1)*(xor(" << "f(1," << e*bit << "),f(1," << bit*bit+2 << ")))*(2^" << (bit-1)+(e-1) << ");" << endl; index++;
        write << "n(" << index << ",1) = (-1)*(xor(" << "f(1," << e*bit << "),f(1," << bit*bit+2 << ")))*(2^" << (bit-1)+(e-1)+1 << ");" << endl; index++;
    }
    else {
        write << "n(" << index << ",1) = (-1)*" << "f(1," << e*bit <<")*(2^" << (bit-1)+(e-1) <<");" << endl; index++;
    }
}

int main()
{
    int bit = 16;
    int index = 2;

    string s = "sbit16_level1_level8";
    ofstream write(s.c_str());

    output(1,2,index,bit,write);
    output(3,4,index,bit,write);
    output(5,6,index,bit,write);
    output(7,8,index,bit,write);
    // output(9,10,index,bit,write);

    write.close();

    return 0;
}