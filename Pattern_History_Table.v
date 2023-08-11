module Pattern_History_Table (
  input wire [2:0] GHR,    // 3-bit Global History Register
  input wire taken,        // Indicates if the branch was taken or not
  input wire clk,          // Clock signal
  input wire reset,        // Reset signal
  input wire update,       // Update signal
  output reg predicted     // Predicted outcome of the branch
);

  // 8-element PHT
  reg [0:7] PHT;
  
  integer index;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      PHT <= 8'b00000000; // On reset, clear the PHT
    end
    else if (update) begin
      index = GHR; // Convert GHR to an integer to use as an index
      PHT[index] <= taken; // Update the PHT with the outcome of the branch
    end
    else begin
      index = GHR;
      predicted <= PHT[index]; // Predict the outcome of the branch based on the PHT
    end
  end

endmodule
