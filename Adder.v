module CLA_4b_Block(A, B, CIN, SUM, PG, GG);
  input[3:0] A, B;
  input CIN;
  output[3:0] SUM;
  output PG, GG;
  wire[3:0] P, G;
  wire C1, C2, C3;
  assign P = A ^ B;
  assign G = A & B;
  assign C1 = G[0] | (P[0] & CIN);
  assign C2 = G[1] | (P[1] & C1);
  assign C3 = G[2] | (P[2] & C2);
  assign SUM = P ^ {C3, C2, C1, CIN};
  assign GG = (G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]));
  assign PG = (&P);
  

endmodule

module CLA_16b_Block(A, B, CIN, SUM, COUT);
  input[15:0] A, B;
  input CIN;
  output[15:0] SUM;
  output COUT;
  wire PG0, PG4, PG8, PG12; 
  wire GG0, GG4, GG8, GG12;
  wire block1_cin, block2_cin, block3_cin;
  assign block1_cin = (GG0 | (PG0 & CIN));
  assign block2_cin = (GG4 | (PG4 & block1_cin));
  assign block3_cin = (GG8 | (PG8 & block2_cin));
  assign COUT = (GG12 | (PG12 & block3_cin));
  CLA_4b_Block block0(A[3:0], B[3:0], CIN, SUM[3:0], PG0, GG0);
  CLA_4b_Block block1(A[7:4], B[7:4], block1_cin, SUM[7:4], PG4, GG4);
  CLA_4b_Block block2(A[11:8], B[11:8], block2_cin, SUM[11:8], PG8, GG8);
  CLA_4b_Block block3(A[15:12], B[15:12], block3_cin, SUM[15:12], PG12, GG12);
 // always @(A or B or CIN)
  //  begin
    //$display("A = %b, %d B = %b, %d CIN = %d \n", A, A, B, B, CIN);
    //#5 $display("Total = %d, %b", {COUT, SUM}, {COUT, SUM});
 //   end
endmodule
