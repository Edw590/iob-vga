`timescale 1ns / 1ps

module vga_tb;
   
   parameter clk_frequency = 100e6; //100 MHz
   parameter clk_per = 1e9/clk_frequency;

   // Inputs
   reg 			 	clk;
   reg 			 	rst;
   reg [11:0]  	rgb;
      
   // Outputs
   reg [9:0]  		pixel_x;
   reg [9:0]  		pixel_y;
   reg 			 	v_sync;
   reg 			 	h_sync;
   reg [3:0]  		Red;
   reg [3:0]  		Green;
   reg [3:0]  		Blue;

				
   initial begin

      `ifdef VCD
            $dumpfile("uut.vcd");
            $dumpvars;
      `endif

      // Initialize Inputs
      clk = 1;
      rst = 1;

      pixel_x = 0;
      pixel_y = 0;
	  	  
      $display("VGA init");
      
      // deassert hard reset
      #100 @(posedge clk) #1 rst = 0;

      #clk_per;      
      $display("Test completed successfully.");
      #(2000000*clk_per) $finish;

   end // initial begin

   initial begin
      forever begin
         #10 $display("Pixel x: %d\nPixel y: %d", pixel_x, pixel_y);
      end
   end

   // Instantiate the Unit Under Test (UUT)
   iob_vga uut
     (
      .clk(clk),
      .rst(rst),
      .rgb(rgb),
      .v_sync(v_sync),
      .h_sync(h_sync),
      .Red(Red),
      .Green(Green),
      .Blue(Blue),
      .pixel_x(pixel_x),
      .pixel_y(pixel_y)
      );

   // system clock
   always #(clk_per/2) clk = ~clk;

endmodule // vga_tb
