#include <fstream>
#include <iostream>
#include <map>
#include <vector>
#include <regex>


using namespace std;

void generate(const int& bit, const vector<string>& vx, const vector<string>& vm, const regex& AND, const regex& OR, const regex& XOR, const regex& POW, const regex& IDX, ofstream& outfilef, ofstream& outfilev)
{
    map<string, vector<string>> verilog;  // for verilog

    for (int i = 0; i < vx.size(); ++i) {
        if (vx[i] == "1") {
            smatch match_POW;
            regex_search(vm[i], match_POW, POW);

            if (!(regex_search(vm[i], AND) || regex_search(vm[i], OR) || regex_search(vm[i], XOR))) {
                smatch match_IDX;
                regex_search(vm[i], match_IDX, IDX);
                outfilef << "v[" << match_IDX[1] << "]" << "*pow(2, " << match_POW[1] << ") + ";
                verilog[match_POW[1]].push_back("part" + to_string((stoi(match_IDX[1])-1)/bit+1) + "[" + to_string((stoi(match_IDX[1])-1)%bit) + "]");
            }
            else {
                    vector<string> numb;
                    string s; //  for verilog
                    for (sregex_iterator iter(vm[i].begin(), vm[i].end(), IDX), end; iter != end; ++iter)
                        numb.push_back(iter->str(1));

                    for (auto iter = numb.begin(); iter != numb.end(); ++iter) {
                        if (iter == numb.begin()) {
                            outfilef << "(v[" << *iter << "]";
                            s += ("part" + to_string((stoi(*iter)-1)/bit+1) + "[" + to_string((stoi(*iter)-1)%bit) + "]");
                        }
                        else {
                            if (regex_search(vm[i], AND)) {
                                outfilef << "&";
                                s += "&";
                            }
                            if (regex_search(vm[i], OR)) {
                                outfilef << "|";
                                s += "|";
                            }
                            if (regex_search(vm[i], XOR)) {
                                outfilef << "^";
                                s += "^";
                            }
                            outfilef << "v[" << *iter << "]";
                            if (*iter != to_string(bit*bit+2))
                                s += ("part" + to_string((stoi(*iter)-1)/bit+1) + "[" + to_string((stoi(*iter)-1)%bit) + "]");
                            else
                                s += "(1'b1)";
                        }
                    }
                    outfilef << ")" << "*pow(2, " << match_POW[1] << ") + ";
                    verilog[match_POW[1]].push_back(s);  // for verilog
                }
        }
    }

    // generate verilog
    // find depth and insert 0
    vector<string>::size_type depth = 0;
    for (auto iter = verilog.begin(); iter != verilog.end(); ++iter)
        depth = max(depth, iter->second.size());
    for (auto iter = verilog.begin(); iter != verilog.end(); ++iter)
        while (iter->second.size() != depth)
            iter->second.push_back("0");
    // find width
    int width = 0;
    for (auto iter = verilog.begin(); iter != verilog.end(); ++iter)
        width = max(width, stoi(iter->first));

    // wire
    for (auto i = 0; i < depth; ++i) {
        outfilev << "wire [" << width << ":0] new_part" << i+1 << ";" << endl;
    }
    outfilev << endl;

    for (int i = 0; i < depth; ++i) {
        for (int j = 0; j < width+1; ++j)
            if (verilog[to_string(j)].empty())
                outfilev << "assign new_part" << i+1 << "[" << j << "] = 0;" << endl;
            else
                outfilev << "assign new_part" << i+1 << "[" << j << "] = " << verilog[to_string(j)][i] << ";" << endl;
        outfilev << endl;
    }

    // Unsigned 8-bit
    outfilev << "assign z = {part7, 6'b0} + {part8, 7'b0}";
    outfilev << "assign z = {part5, 4'b0} + {part6, 5'b0} + {part7, 6'b0} + {part8, 7'b0}";
    for (auto i = 0; i < depth; ++i) {
        outfilev << " + new_part" << i+1;
    }
    outfilev << ";" << endl;
    // End Unsigned 8-bit

    // Signed 16-bit
    // outfilev << "assign z = {part7, 6'b0} + {part8, 7'b0} + {part9, 8'b0} + {part10, 9'b0} + {part11, 10'b0} + {part12, 11'b0} + {part13, 12'b0} + {part14, 13'b0} + {part15, 14'b0} + {part16, 15'b0}";
    // for (auto i = 0; i < depth; ++i) {
    //     outfilev << " + new_part" << i+1;
    // }
    // outfilev << ";" << endl;
    // End Signed 16-bit

}


int main() {

    ifstream infilex(""); // the compression result
    ifstream infilem(""); // the file from 'gencode'

    string sx;
    vector<string> vx;

    while(getline(infilex, sx)) {
        if (!sx.empty())
            vx.push_back(sx);
    }

    string sm;
    vector<string> vm;
    while(getline(infilem, sm)) {
        if(!sm.empty())
            vm.push_back(sm);
    }

    regex AND("&");
    regex OR("\\|");
    regex XOR("xor");
    regex POW(R"(2\^(\d+))");
    regex IDX(R"(idx\,(\d+))");
    regex NOT(R"(\~)");

    ofstream outfilef("x_testformul");
    ofstream outfilev("x_testverilog");

    int bit = 8;
    // int bit = 16;

    generate(bit, vx, vm, AND, OR, XOR, POW, IDX, outfilef, outfilev);

    outfilef << endl;
    
    return 0;
}