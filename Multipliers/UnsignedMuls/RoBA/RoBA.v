module RoBA(
    input  [7:0] A,
    input  [7:0] B,
    output [15:0] R
);


wire [8:0] Ar;
wire [8:0] Br;
assign Ar[0]=A[0]&((~A[1])&(~A[2])&(~A[3])&(~A[4])&(~A[5])&(~A[6])&(~A[7]));
assign Ar[1]=A[1]&((~A[2])&(~A[3])&(~A[4])&(~A[5])&(~A[6])&(~A[7]));
assign Ar[2]=A[2]&(~A[1])&((~A[3])&(~A[4])&(~A[5])&(~A[6])&(~A[7]));
assign Ar[3]=(((~A[3])&A[2]&A[1])|(A[3]&(~A[2])))&((~A[4])&(~A[5])&(~A[6])&(~A[7]));
assign Ar[4]=(((~A[4])&A[3]&A[2])|(A[4]&(~A[3])))&((~A[5])&(~A[6])&(~A[7]));
assign Ar[5]=(((~A[5])&A[4]&A[3])|(A[5]&(~A[4])))&((~A[6])&(~A[7]));
assign Ar[6]=((~A[6])&A[5]&A[4])|(A[6]&(~A[5])&(~A[7]));
assign Ar[7]=((~A[7])&A[6]&A[5])|(A[7]&(~A[6]));
assign Ar[8]=A[7]&A[6];

assign Br[0]=B[0]&((~B[1])&(~B[2])&(~B[3])&(~B[4])&(~B[5])&(~B[6])&(~B[7]));
assign Br[1]=B[1]&((~B[2])&(~B[3])&(~B[4])&(~B[5])&(~B[6])&(~B[7]));
assign Br[2]=B[2]&(~B[1])&((~B[3])&(~B[4])&(~B[5])&(~B[6])&(~B[7]));
assign Br[3]=(((~B[3])&B[2]&B[1])|(B[3]&(~B[2])))&((~B[4])&(~B[5])&(~B[6])&(~B[7]));
assign Br[4]=(((~B[4])&B[3]&B[2])|(B[4]&(~B[3])))&((~B[5])&(~B[6])&(~B[7]));
assign Br[5]=(((~B[5])&B[4]&B[3])|(B[5]&(~B[4])))&((~B[6])&(~B[7]));
assign Br[6]=((~B[6])&B[5]&B[4])|(B[6]&(~B[5])&(~B[7]));
assign Br[7]=((~B[7])&B[6]&B[5])|(B[7]&(~B[6]));
assign Br[8]=B[7]&B[6];

reg [15:0] ArxB;
reg [15:0] BrxA;
reg [15:0] ArxBr;

always @(*) begin
    case(Ar)
    9 'b000000000: ArxB = B;
    9 'b000000001: ArxB = B;
    9 'b000000010: ArxB = B << 1;
    9 'b000000100: ArxB = B << 2;
    9 'b000001000: ArxB = B << 3;
    9 'b000010000: ArxB = B << 4;
    9 'b000100000: ArxB = B << 5;
    9 'b001000000: ArxB = B << 6;
    9 'b010000000: ArxB = B << 7;
    9 'b100000000: ArxB = B << 8;
    default: ArxB = 0;
    endcase

    case(Br)
    9 'b000000000: BrxA = A;
    9 'b000000001: BrxA = A;
    9 'b000000010: BrxA = A << 1;
    9 'b000000100: BrxA = A << 2;
    9 'b000001000: BrxA = A << 3;
    9 'b000010000: BrxA = A << 4;
    9 'b000100000: BrxA = A << 5;
    9 'b001000000: BrxA = A << 6;
    9 'b010000000: BrxA = A << 7;
    9 'b100000000: BrxA = A << 8;
    default: BrxA = 0;
    endcase

    case (Ar)
    9 'b000000000: ArxBr = Br;
    9 'b000000001: ArxBr = Br;
    9 'b000000010: ArxBr = Br << 1;
    9 'b000000100: ArxBr = Br << 2;
    9 'b000001000: ArxBr = Br << 3;
    9 'b000010000: ArxBr = Br << 4;
    9 'b000100000: ArxBr = Br << 5;
    9 'b001000000: ArxBr = Br << 6;
    9 'b010000000: ArxBr = Br << 7;
    9 'b100000000: ArxBr = Br << 8;
    default: ArxBr = 0;
    endcase

end

wire [15:0] P = ArxB + BrxA;
wire [15:0] Z = ArxBr;


assign R = (P ^ Z) & (((P << 1) ^ (P ^ Z)) | (( P & Z) << 1));

endmodule