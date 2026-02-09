module tb_clock;
  logic clk = 0;
  logic rst_n;
  logic [5:0] sec;
  logic [5:0] min;

  // Clock generation
  always #5 clk = ~clk;

  // Instantiate Design
  digital_clock dut (.*);

  // Coverage Group
  covergroup cg_clock @(posedge clk);
    // Task 3: Verify the transition sec: 59 => 0
    cp_sec_rollover: coverpoint sec {
      bins rollover = (59 => 0);
    }

    // Task 3: Verify min increments when sec wraps
    cp_min: coverpoint min;
    
    // Cross coverage ensures min was X and then X+1 during a sec rollover
    cross_min_inc: cross cp_sec_rollover, cp_min;
  endgroup

  cg_clock cvg;

  initial begin
    cvg = new();
    
    // Reset sequence
    rst_n = 0;
    #15 rst_n = 1;

    // We need to run long enough to see at least one rollover (60 cycles)
    // To be safe and see multiple, let's run for 700 units
    repeat (70) @(posedge clk);

    $display("--- Clock Test Finished ---");
    $display("Rollover Coverage: %0.2f%%", cvg.cp_sec_rollover.get_inst_coverage());
    $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_clock);
  end
endmodule