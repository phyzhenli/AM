module appro_42(
    input a,b,c,d,
    output carry,sum
    );
    assign carry = (a&b)|(c&d);
    assign sum = (a^b)|(c^d)|(a&b&c&d);
endmodule
