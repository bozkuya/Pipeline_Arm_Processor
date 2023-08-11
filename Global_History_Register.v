module Global_History_Register (
  input wire taken, // Indicates if the branch was taken or not
  input wire clk,   // Clock signal
  input wire reset, // Reset signal
  input wire shift, // Shift signal
  output reg [2:0] DATA // 3-bit GHR
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      DATA <= 3'b000; // On reset, clear the GHR
    end else if (shift) begin
      DATA <= {DATA[1:0], taken}; // Shift left and append the 'taken' signal at the end
    end // No operation if shift is low, DATA remains the same
  end

endmodule
