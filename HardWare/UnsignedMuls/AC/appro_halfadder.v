module appro_halfadder(
    input a,b,
    output carry,sum
    );
    assign carry = a&b;
    assign sum = a|b;
endmodule
