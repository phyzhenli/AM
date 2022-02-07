module appro_fulladder(
    input a,b,c,
    output carry,sum
    );
    assign carry = (a&c)|(b&c);
    assign sum = (a|b)^c;
endmodule
