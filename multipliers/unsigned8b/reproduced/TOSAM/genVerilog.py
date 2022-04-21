import math
import os

def genVerilog(h ,t, wA, wB, filename):

    if t < 2 or t >= wA or t >= wB:
        print("ERROR: 2 <= t <= min(wA, wB)")
        exit()

    with open(filename,'w') as f:

        print("module " + filename[:-2] + " (A,B,FinalOUT);", file = f)
        print(file = f)
        print("input [" + str(wA-1) + ":0] A;", file = f)
        print("input [" + str(wB-1) + ":0] B;", file = f)
        print("output [" + str(wA+wB-1) + ":0] FinalOUT;", file = f)
        print("wire zero;", file = f)
        print("wire [" + str(wA-1) + ":0] KA1;", file = f)
        print("wire [" + str(wB-1) + ":0] KB1;", file = f)
        print("wire [" + str(math.ceil(math.log2(wA)) - 1) + ":0] KA;", file = f)
        print("wire [" + str(math.ceil(math.log2(wB)) - 1) + ":0] KB;", file = f)
        print("wire [" + str(((wA-1)+(wB-1)).bit_length() - 1) + ":0] shiftL;", file = f)
        print("wire [" + str(t-1) + ":0] YAt;", file = f)
        print("wire [" + str(t-1) + ":0] YBt;", file = f)
        print("wire [" + str(max(2*(h+1)+1, t+1)) + ":0] FinalOUT1;", file = f)
        print("wire [" + str(max(2*(h+1)+1, t+1) + (wA-1) + (wB-1)) + ":0] FinalOUT2;", file = f)
        print(file = f)
        print("///////////////////// finding KA and KB /////////////////////", file = f)
        for i in range(wA):
            print("assign KA1[" + str(i) + "] = ", end="", file = f)
            for j in range(i, wA):
                if j == i:
                    print("A[" + str(i) + "]", end="", file = f)
                else:
                    print( " && ~A[" + str(j) + "]" , end="", file = f)
            print(";", file = f)
        print(file = f)
        for i in range(wB):
            print("assign KB1[" + str(i) + "] = ", end="", file = f)
            for j in range(i, wB):
                if j == i:
                    print("B[" + str(i) + "]", end="", file = f)
                else:
                    print( " && ~B[" + str(j) + "]" , end="", file = f)
            print(";", file = f)
        print(file = f)
        print("///////////////////// Generating shifting value /////////////////////", file = f)
        print("assign KA = ", end="", file = f)
        for i in range(wA):
            if i == wA-1:
                print("KA1[" + str(i) + "] ? 3'd " + str(i) + " : 3'd 0;", file = f)
            else:
                print("KA1[" + str(i) + "] ? 3'd " + str(i) + " : ", end="", file = f)
        print("assign KB = ", end="", file = f)
        for i in range(wB):
            if i == wB-1:
                print("KB1[" + str(i) + "] ? 3'd " + str(i) + " : 3'd 0;", file = f)
            else:
                print("KB1[" + str(i) + "] ? 3'd " + str(i) + " : ", end="", file = f)
        print("assign shiftL = KB + KA;", file = f)

        print(file = f)
        print("///////////////////// finding YAt and YBt ***The fractional part /////////////////////", file = f)
        for i in range(t):
            print("assign YAt[" + str(i) + "] = ", end="", file = f)
            for j in range(wA-t+i):
                if j == 0:
                    print("(KA1[" + str(t-i) + "] && A[" + str(j) + "])", end="", file = f)
                else:
                    print(" || (KA1[" + str(t-i+j) + "] && A[" + str(j) + "])", end="", file = f)
            print(";", file = f)
        print(file = f)
        for i in range(t):
            print("assign YBt[" + str(i) + "] = ", end="", file = f)
            for j in range(wB-t+i):
                if j == 0:
                    print("(KB1[" + str(t-i) + "] && B[" + str(j) + "])", end="", file = f)
                else:
                    print(" || (KB1[" + str(t-i+j) + "] && B[" + str(j) + "])", end="", file = f)
            print(";", file = f)
        print(file = f)
        print("///////////////////// Generating zero /////////////////////", file = f)
        print("assign zero = ( (A == " + str(wA) + "'d 0) || (B == " + str(wB) + "'d 0) ) ? 1'b 0 : 1'b 1 ;", file = f)
        print(file = f)

        if (h != 0):
            print("///////////////////// h != 0 /////////////////////", file = f)

            print("///////////////////// finding YAx and YBx ***The fractional part /////////////////////", file = f)
            print("wire [" + str(h-1) + ":0] YAx;", file = f)
            print("wire [" + str(h-1) + ":0] YBx;", file = f)
            for i in range(h):
                print("assign YAx[" + str(i) + "] = ", end="", file = f)
                for j in range(wA-h+i):
                    if j == 0:
                        print("(KA1[" + str(h-i) + "] && A[" + str(j) + "])", end="", file = f)
                    else:
                        print(" || (KA1[" + str(h-i+j) + "] && A[" + str(j) + "])", end="", file = f)
                print(";", file = f)
            print(file = f)
            for i in range(h):
                print("assign YBx[" + str(i) + "] = ", end="", file = f)
                for j in range(wB-h+i):
                    if j == 0:
                        print("(KB1[" + str(h-i) + "] && B[" + str(j) + "])", end="", file = f)
                    else:
                        print(" || (KB1[" + str(h-i+j) + "] && B[" + str(j) + "])", end="", file = f)
                print(";", file = f)
            print(file = f)

            print("///////////////////// Small multiplier /////////////////////", file = f)
            print("wire [" + str(2*(h+1)-1) + ":0] tmp =  {YAx, 1'b 1} * {YBx, 1'b 1};", file = f)
            if 2*(h+1) == t:
                print("///////////////////// 2*(h+1) == t /////////////////////", file = f)
                print("assign FinalOUT1 = {1'b 0, YAt} + {1'b 0, YBt} + {1'b 1, tmp};", file = f)
            if 2*(h+1) < t:
                print("///////////////////// 2*(h+1) < t /////////////////////", file = f)
                print("assign FinalOUT1 = {1'b 0, YAt} + {1'b 0, YBt} + {1'b 1, tmp, " + str(t-2*(h+1)) + "'b ", end="", file = f)
                for i in range(t-2*(h+1)):
                    print(0, end="", file = f)
                print("};", file = f)
            if 2*(h+1) > t:
                print("///////////////////// 2*(h+1) > t /////////////////////", file = f)
                print("assign FinalOUT1 = {1'b 1, tmp} + {1'b 0, YAt, " + str(2*(h+1)-t) + "'b ", end="", file = f)
                for i in range(2*(h+1)-t):
                    print(0, end="", file = f)
                print("} + {1'b 0, YBt, " + str(2*(h+1)-t) + "'b ", end="", file = f)
                for i in range(2*(h+1)-t):
                    print(0, end="", file = f)
                print("};", file = f)

        if h == 0:
            print("///////////////////// h = 0 /////////////////////", file = f)
            if t == 2:
                print("///////////////////// t = 2 /////////////////////", file = f)
                print("assign FinalOUT1 = {1'b 0, YAt} + {1'b 0, YBt} + {1'b 1, 1'b 0, 1'b 1};", file = f)
            else:
                print("assign FinalOUT1 = {1'b 0, YAt} + {1'b 0, YBt} + {1'b 1, 1'b 0, 1'b 1, " + str(t-2) + "'b ", end="", file = f)
                for i in range(t-2):
                    print(0, end="", file = f)
                print("};", file = f)
            print(file = f)

        print("assign FinalOUT2 = FinalOUT1 << shiftL;", file = f)
        print("assign FinalOUT = {16{zero}} & FinalOUT2[" + str(max(2*(h+1)+1, t+1) + (wA-1) + (wB-1)) + ":" + str(max(2*(h+1)+1, t+1) + (wA-1) + (wB-1) - (wA+wB-1) ) + "];", file = f)
        print(file = f)
        print("endmodule", file = f)


for i in range(3, 6):
    for j in range(3, 8):
        TOSAM = "TOSAM_h"+str(i)+"_t"+str(j)
        # genVerilog(i, j, 8, 8, TOSAM+".v")
        print(TOSAM)
        # command = "docker cp " + TOSAM + ".v e6:/root/Desktop/dc1/src/"
        command = "docker cp e6:/root/Desktop/" + TOSAM + ".txt ./"
        # command = "del " + TOSAM
        os.system(command)