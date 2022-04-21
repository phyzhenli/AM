import math
import os


def genVerilog(j, k, wA, wB, filename, compEnable):

    if k < 1 or k >= (wB-1):
        print("ERROR: k!")
        exit()

    with open(filename,'w') as f:

        print("module " + filename[:-2] + " (A, B, FinalOUT);", file = f)
        print(file = f)
        print("input [" + str(wA-1) + ":0] A;", file = f)
        print("input [" + str(wB-1) + ":0] B;", file = f)
        print("output [" + str(wA+wB-1) + ":0] FinalOUT;", file = f)
        print(file = f)

        if compEnable:
            print("///////////////////// Add compatator /////////////////////", file = f)
            # print("if (A > B) begin", file = f)
            # print("  {A, B} = {B, A};", file = f)
            # print("end", file = f)
            # print("assign {A, B} = A > B ? {B, A} : {A, B};", file = f)
            wA = wB = max(wA, wB)
            print("wire [" + str(wA-1) + ":0] AA = A > B ? B : A;", file = f)
            print("wire [" + str(wB-1) + ":0] BB = A > B ? A : B;", file = f)
        else:
            print("wire [" + str(wA-1) + ":0] AA = A;", file = f)
            print("wire [" + str(wB-1) + ":0] BB = B;", file = f)
        print(file = f)

        for i in range(wB):
            print("wire [" + str(wA-1) + ":0] part" + str(i) + " =  AA & { " + str(wA) + "{BB[" + str(i) + "]} };", file = f)
        print(file = f)

        print("assign FinalOUT = ", end = "", file = f)
        outStr = ""
        for i in range(wB):
            if i < j or i > (j+k-1):
                if i == 0:
                    outStr += "part0 + ";
                else:
                    outStr += "{part" + str(i) + ", " + str(i) + "'d 0} + "
        print(outStr[:-3] + ";", file = f)
        print(file = f)

        print("endmodule", file = f)


for i in range(0, 3):
    for j in range(1, 4):
        PPAM = "PPAM_j"+str(i)+"_k"+str(j)
        # genVerilog(i, j, 8, 8, PPAM+".v", 0)
        print(PPAM)
        # genVerilog(i, j, 8, 8, PPAM+"_c.v", 1)
        print(PPAM+"_c")

        # command = "docker cp " + PPAM + ".v e6:/root/Desktop/dc1/src/"
        command = "docker cp e6:/root/Desktop/" + PPAM + ".txt ./"
        os.system(command)
        # command = "docker cp " + PPAM + "_c.v e6:/root/Desktop/dc1/src/"
        command = "docker cp e6:/root/Desktop/" + PPAM + "_c.txt ./"
        os.system(command)
        
        # command = "del " + PPAM
