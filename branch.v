module branch (
  input wire [31:0] PC,         // Input PC
  input wire [31:0] new_BTA,    // New BTA to be stored
  input wire clk,               // Clock signal
  input wire reset,             // Reset signal
  input wire update,            // Flag to update the BTB
  output wire hit,              // Flag indicating a hit in the BTB
  output reg [31:0] predicted_PC // Predicted PC for next fetch stage
);

  // Parameter for the BTB size
  parameter BTB_SIZE = 3;

  // BTB Entries
  reg [31:0] BTB_PC [0:BTB_SIZE-1];
  reg [31:0] BTB_BTA [0:BTB_SIZE-1];
  
  // Valid bit for each BTB entry
  reg [BTB_SIZE-1:0] valid;
  
  // LRU counter
  reg [$clog2(BTB_SIZE)-1:0] LRU;
  reg [BTB_SIZE-1:0] hit_array;

  integer i;
  
  // BTB operation
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      valid <= 0;
      LRU <= 0;
      hit_array <= 0;
    end
    else begin
      for(i = 0; i < BTB_SIZE; i = i + 1) begin
        if(valid[i] && BTB_PC[i] == PC) begin
          hit_array[i] <= 1;
          predicted_PC <= BTB_BTA[i];
          if(update) begin
            LRU <= i;
          end
        end
        else begin
          hit_array[i] <= 0;
        end
      end
      if(update && !hit) begin
        BTB_PC[LRU] <= PC;
        BTB_BTA[LRU] <= new_BTA;
        valid[LRU] <= 1;
        LRU <= (LRU + 1) % BTB_SIZE;
      end
    end
  end

  // Assign hit wire to logical OR of hit_array
  assign hit = |hit_array;

endmodule
