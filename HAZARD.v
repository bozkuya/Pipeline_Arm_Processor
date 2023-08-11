module HAZARD(
  input  clk,
  input  reset,
  input  MemtoRegE,
  input  RegwriteW ,
  input  RegwriteM ,
  input  CondEx,
  input  PCSrcD,
  input  PCSrcE,
  input  PCSrcM,
  input  PCSrcW,
  input  BranchE,
  output  reg BranchTakenE,
  input  [31:0] RA1E,    // destination register from EX stage
  input  [31:0] WA3M,
  input  [31:0] RA2E,
  input  [31:0] WA3W,
  input  [31:0] WA3E,
  input  [31:0] RA1D,
  input  [31:0] RA2D,  // destination register from MEM stage

  output reg FlashD,
  output reg FlashE,
  output reg StallD,
  output reg StallF,
  
  output  reg PCWrPendingF,
  
  output  reg LDRStall,
  output reg [1:0] ForwardAE,
  output reg [1:0] ForwardBE,
  output  reg Match_12D_E,
  output wire Match_1E_M,
  output wire Match_1E_W,
  output wire Match_2E_M,
  output wire Match_2E_W
);



assign Match_1E_M = ( RA1E == WA3M);
assign Match_1E_W = (RA1E == WA3W);
assign Match_2E_M = (RA2E == WA3M);
assign Match_2E_W = (RA2E == WA3W);

always @(*) begin
if (Match_1E_M*RegwriteM)
begin
ForwardAE=2'b10;
end
else if(Match_1E_W*RegwriteW)

begin
ForwardAE=2'b01;
end

else 
ForwardAE=2'b00;

end


always @(*) begin
if(Match_2E_M*RegwriteM)
begin
ForwardBE=2'b10;
end

else if(Match_2E_W*RegwriteW)
begin
ForwardBE=2'b01;
end

else 
ForwardBE=2'b00;

end

always @(*) begin
 Match_12D_E = (RA1D == WA3E) + (RA2D == WA3E);
 LDRStall = Match_12D_E * MemtoRegE;
 BranchTakenE = BranchE * CondEx;

 PCWrPendingF = PCSrcD + PCSrcE + PCSrcM;
StallF = LDRStall + PCWrPendingF;
StallD = LDRStall;
FlashD = PCWrPendingF + PCSrcW + BranchTakenE;
FlashE = LDRStall + BranchTakenE;
end

endmodule
