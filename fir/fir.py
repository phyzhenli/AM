import numpy as np
import math
from bitstring import *


def matmul(weights,inputs):

    result = 0
    error = 0
    for i in range(len(weights)):
        tmp_result,tmp_error = appromul(weights[i],inputs[i])
        result +=tmp_result
        error +=tmp_error

    return result

def appromul(weight, input):
    error =0

    tmp_input = pow(2, 14)*input
    tmp_weight = pow(2, 15)*weight
    tmp_result = Baugh_Wooley(round(tmp_input), round(tmp_weight))

    if (tmp_result > pow(pow(2, 15)-1, 2)) | (tmp_result < -pow(pow(2, 15), 2)):
        print(tmp_result, "error")
    
    result = tmp_result / (pow(2, 14)*pow(2, 15))
    error = weight*input - result

    return result, error

def Baugh_Wooley(i, j):
    x = BitArray(int=i, length=16)
    v = []
    v.append(0)
    for cdx in range(15, -1, -1):
        part_pro =  BitArray(int=j*x[cdx], length=16)
        if cdx == 0:
            part_pro.invert()
            part_pro.invert(0)
        else:
            part_pro.invert(0)
        part_pro.reverse()  # reverse the sequence of part_pro
        for bit in part_pro.bin:
            v.append(int(bit))
    v.append(1)
    v.append(1)

    return (
v[1]*pow(2, 0) + (v[2]&v[17])*pow(2, 2) + (v[2]^v[17])*pow(2, 1) + (v[3]&v[18])*pow(2, 3) + (v[3]^v[18])*pow(2, 2) + (v[4]&v[19])*pow(2, 4) + (v[4]^v[19])*pow(2, 3) + (v[5]&v[20])*pow(2, 5) + (v[5]^v[20])*pow(2, 4) + (v[6]&v[21])*pow(2, 6) + (v[6]^v[21])*pow(2, 5) + (v[7]&v[22])*pow(2, 7) + (v[7]^v[22])*pow(2, 6) + (v[8]&v[23])*pow(2, 8) + (v[8]^v[23])*pow(2, 7) + (v[9]&v[24])*pow(2, 9) + (v[9]^v[24])*pow(2, 8) + (v[10]&v[25])*pow(2, 10) + (v[10]^v[25])*pow(2, 9) + (v[11]&v[26])*pow(2, 11) + (v[11]^v[26])*pow(2, 10) + (v[12]&v[27])*pow(2, 12) + (v[12]^v[27])*pow(2, 11) + (v[13]&v[28])*pow(2, 13) + (v[13]^v[28])*pow(2, 12) + (v[14]&v[29])*pow(2, 14) + (v[14]^v[29])*pow(2, 13) + (v[15]&v[30])*pow(2, 15) + (v[15]^v[30])*pow(2, 14) + (v[16]&v[31])*pow(2, 16) + (v[16]^v[31])*pow(2, 15) + (v[32]&v[258])*pow(2, 17) + (v[32]^v[258])*pow(2, 16) + v[33]*pow(2, 2) + (v[34]&v[49])*pow(2, 4) + (v[34]^v[49])*pow(2, 3) + (v[35]&v[50])*pow(2, 5) + (v[35]^v[50])*pow(2, 4) + (v[36]&v[51])*pow(2, 6) + (v[36]^v[51])*pow(2, 5) + (v[37]&v[52])*pow(2, 7) + (v[37]^v[52])*pow(2, 6) + (v[38]&v[53])*pow(2, 8) + (v[38]^v[53])*pow(2, 7) + (v[39]&v[54])*pow(2, 9) + (v[39]^v[54])*pow(2, 8) + (v[40]&v[55])*pow(2, 10) + (v[40]^v[55])*pow(2, 9) + (v[41]&v[56])*pow(2, 11) + (v[41]^v[56])*pow(2, 10) + (v[42]&v[57])*pow(2, 12) + (v[42]^v[57])*pow(2, 11) + (v[43]&v[58])*pow(2, 13) + (v[43]^v[58])*pow(2, 12) + (v[44]&v[59])*pow(2, 14) + (v[44]^v[59])*pow(2, 13) + (v[45]&v[60])*pow(2, 15) + (v[45]^v[60])*pow(2, 14) + (v[46]&v[61])*pow(2, 16) + (v[46]^v[61])*pow(2, 15) + (v[47]&v[62])*pow(2, 17) + (v[47]^v[62])*pow(2, 16) + (v[48]&v[63])*pow(2, 18) + (v[48]^v[63])*pow(2, 17) + v[64]*pow(2, 18) + v[65]*pow(2, 4) + (v[66]&v[81])*pow(2, 6) + (v[66]^v[81])*pow(2, 5) + (v[67]&v[82])*pow(2, 7) + (v[67]^v[82])*pow(2, 6) + (v[68]&v[83])*pow(2, 8) + (v[68]^v[83])*pow(2, 7) + (v[69]&v[84])*pow(2, 9) + (v[69]^v[84])*pow(2, 8) + (v[70]&v[85])*pow(2, 10) + (v[70]^v[85])*pow(2, 9) + (v[71]&v[86])*pow(2, 11) + (v[71]^v[86])*pow(2, 10) + (v[72]&v[87])*pow(2, 12) + (v[72]^v[87])*pow(2, 11) + (v[73]&v[88])*pow(2, 13) + (v[73]^v[88])*pow(2, 12) + (v[74]&v[89])*pow(2, 14) + (v[74]^v[89])*pow(2, 13) + (v[75]&v[90])*pow(2, 15) + (v[75]^v[90])*pow(2, 14) + (v[76]&v[91])*pow(2, 16) + (v[76]^v[91])*pow(2, 15) + (v[77]&v[92])*pow(2, 17) + (v[77]^v[92])*pow(2, 16) + (v[78]&v[93])*pow(2, 18) + (v[78]^v[93])*pow(2, 17) + (v[79]&v[94])*pow(2, 19) + (v[79]^v[94])*pow(2, 18) + (v[80]&v[95])*pow(2, 20) + (v[80]^v[95])*pow(2, 19) + v[96]*pow(2, 20) + 
v[97]*pow(2,6) + v[98]*pow(2,7) + v[99]*pow(2,8) + v[100]*pow(2,9) + v[101]*pow(2,10) + v[102]*pow(2,11) + v[103]*pow(2,12) + v[104]*pow(2,13) + v[105]*pow(2,14) + v[106]*pow(2,15) + v[107]*pow(2,16) + v[108]*pow(2,17) + v[109]*pow(2,18) + v[110]*pow(2,19) + v[111]*pow(2,20) + v[112]*pow(2,21) + v[113]*pow(2,7) + v[114]*pow(2,8) + v[115]*pow(2,9) + v[116]*pow(2,10) + v[117]*pow(2,11) + v[118]*pow(2,12) + v[119]*pow(2,13) + v[120]*pow(2,14) + v[121]*pow(2,15) + v[122]*pow(2,16) + v[123]*pow(2,17) + v[124]*pow(2,18) + v[125]*pow(2,19) + v[126]*pow(2,20) + v[127]*pow(2,21) + v[128]*pow(2,22) + v[129]*pow(2,8) + v[130]*pow(2,9) + v[131]*pow(2,10) + v[132]*pow(2,11) + v[133]*pow(2,12) + v[134]*pow(2,13) + v[135]*pow(2,14) + v[136]*pow(2,15) + v[137]*pow(2,16) + v[138]*pow(2,17) + v[139]*pow(2,18) + v[140]*pow(2,19) + v[141]*pow(2,20) + v[142]*pow(2,21) + v[143]*pow(2,22) + v[144]*pow(2,23) + v[145]*pow(2,9) + v[146]*pow(2,10) + v[147]*pow(2,11) + v[148]*pow(2,12) + v[149]*pow(2,13) + v[150]*pow(2,14) + v[151]*pow(2,15) + v[152]*pow(2,16) + v[153]*pow(2,17) + v[154]*pow(2,18) + v[155]*pow(2,19) + v[156]*pow(2,20) + v[157]*pow(2,21) + v[158]*pow(2,22) + v[159]*pow(2,23) + v[160]*pow(2,24) + v[161]*pow(2,10) + v[162]*pow(2,11) + v[163]*pow(2,12) + v[164]*pow(2,13) + v[165]*pow(2,14) + v[166]*pow(2,15) + v[167]*pow(2,16) + v[168]*pow(2,17) + v[169]*pow(2,18) + v[170]*pow(2,19) + v[171]*pow(2,20) + v[172]*pow(2,21) + v[173]*pow(2,22) + v[174]*pow(2,23) + v[175]*pow(2,24) + v[176]*pow(2,25) + v[177]*pow(2,11) + v[178]*pow(2,12) + v[179]*pow(2,13) + v[180]*pow(2,14) + v[181]*pow(2,15) + v[182]*pow(2,16) + v[183]*pow(2,17) + v[184]*pow(2,18) + v[185]*pow(2,19) + v[186]*pow(2,20) + v[187]*pow(2,21) + v[188]*pow(2,22) + v[189]*pow(2,23) + v[190]*pow(2,24) + v[191]*pow(2,25) + v[192]*pow(2,26) + v[193]*pow(2,12) + v[194]*pow(2,13) + v[195]*pow(2,14) + v[196]*pow(2,15) + v[197]*pow(2,16) + v[198]*pow(2,17) + v[199]*pow(2,18) + v[200]*pow(2,19) + v[201]*pow(2,20) + v[202]*pow(2,21) + v[203]*pow(2,22) + v[204]*pow(2,23) + v[205]*pow(2,24) + v[206]*pow(2,25) + v[207]*pow(2,26) + v[208]*pow(2,27) + v[209]*pow(2,13) + v[210]*pow(2,14) + v[211]*pow(2,15) + v[212]*pow(2,16) + v[213]*pow(2,17) + v[214]*pow(2,18) + v[215]*pow(2,19) + v[216]*pow(2,20) + v[217]*pow(2,21) + v[218]*pow(2,22) + v[219]*pow(2,23) + v[220]*pow(2,24) + v[221]*pow(2,25) + v[222]*pow(2,26) + v[223]*pow(2,27) + v[224]*pow(2,28) + v[225]*pow(2,14) + v[226]*pow(2,15) + v[227]*pow(2,16) + v[228]*pow(2,17) + v[229]*pow(2,18) + v[230]*pow(2,19) + v[231]*pow(2,20) + v[232]*pow(2,21) + v[233]*pow(2,22) + v[234]*pow(2,23) + v[235]*pow(2,24) + v[236]*pow(2,25) + v[237]*pow(2,26) + v[238]*pow(2,27) + v[239]*pow(2,28) + v[240]*pow(2,29) + v[241]*pow(2,15) + v[242]*pow(2,16) + v[243]*pow(2,17) + v[244]*pow(2,18) + v[245]*pow(2,19) + v[246]*pow(2,20) + v[247]*pow(2,21) + v[248]*pow(2,22) + v[249]*pow(2,23) + v[250]*pow(2,24) + v[251]*pow(2,25) + v[252]*pow(2,26) + v[253]*pow(2,27) + v[254]*pow(2,28) + v[255]*pow(2,29) + v[256]*pow(2,30) - v[257]*pow(2,31) )

def lmsFunc(xn, dn, M, mu,sn):
    itr = len(xn)
    en = np.zeros((itr, 1))
    W = np.zeros((M, itr))
    Ps = np.zeros((itr,1))
    Pn = np.zeros((itr,1))
    snr = np.zeros((itr,1))
    error = np.zeros((itr, 1))
    tmp_yn = np.zeros((itr, 1))

    en_app = np.zeros((itr, 1))
    W_app = np.zeros((M, itr))
    Ps_app = np.zeros((itr, 1))
    Pn_app = np.zeros((itr, 1))
    snr_app = np.zeros((itr, 1))
    error_app = np.zeros((itr, 1))
    tmp_yn_app =np.zeros((itr, 1))


    for k in range(M, itr):
        if k == 20:
            x = xn[k -1::-1]
        else:
            x = xn[k - 1:k - M -1:-1]

        y = np.dot(W[:, k - 1], x)
        y_app = matmul(W_app[:, k - 1], x)

        en[k] = dn[k] - y
        en_app[k] = dn[k] - y_app
        W[:, k] = W[:,k - 1] + 2 * mu * en[k] * x
        W_app[:, k] = W_app[:, k - 1] + 2 * mu * en_app[k] * x

        tmp_yn[k] = dn[k] - np.dot(W[:, k], x)
        tmp_yn_app[k] = dn[k] - np.dot(W_app[:, k], x)

        error[k] = sn[k] - en[k]
        error_app[k] = sn[k] - en_app[k]
        Ps[k] = ((k - M) * Ps[k - 1] + math.pow(tmp_yn[k], 2)) / len(sn[M - 1:k])
        Pn[k] = ((k - M) * Pn[k - 1] + math.pow((tmp_yn[k] - en[k]), 2)) / len(sn[M - 1:k])
        snr[k] = 10 * math.log(Ps[k] / Pn[k], 10)

        Ps_app[k] = ((k -M) * Ps_app[k - 1] + math.pow(tmp_yn[k], 2)) / len(sn[M-1:k])
        Pn_app[k] = ((k -M) * Pn_app[k - 1] + math.pow((tmp_yn_app[k] - en_app[k]),2)) / len(sn[M-1:k])
        snr_app[k] = 10 * math.log(Ps_app[k] / Pn_app[k], 10)


    yn = np.ones(xn.shape) * np.nan
    for k in range(M, len(xn) ):
        if k == 20:
            x = xn[k :0:-1]
        else:
            x = xn[k -1:k - M - 1:-1]
        yn[k] = dn[k]-np.dot(W[:, 999], x)

    yn_app = np.ones(xn.shape) * np.nan
    for k in range(M, len(xn)):
        if k == 20:
            x = xn[k:0:-1]
        else:
            x = xn[k - 1:k - M - 1:-1]
        yn_app[k] = dn[k] - matmul(W[:, 999], x)

    return yn, yn_app,W, en,en_app,snr,snr_app,error,error_app


if __name__ == '__main__':
    fs = 1
    f0 = 0.02
    n = 1000
    t = np.arange(n)/fs
    xs = 5*np.cos(2*np.pi*f0*t)
    noise = 1*np.cos(2*np.pi*10*f0*t)       #source of noise

    M = 20
    xn = noise
    dn = xs+0.5*np.cos(2*np.pi*10*f0*t+np.pi/4)       #add noise
    mu = 0.001
    sn = xs
    yn, yn_app,W, en,en_app,snr,snr_app ,error,error_app= lmsFunc(xn, dn, M, mu, sn)

    print(snr_app[999])

