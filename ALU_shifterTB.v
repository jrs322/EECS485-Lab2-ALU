module Testbench();
  reg[15:0] A;
  reg[3:0] shift_cnt;
  reg[2:0] ctrl;
  wire[15:0] out;
  while (ctrl != 3'b111)begin
    for(integer i = 0; i < 16; i = i +1) begin
      if(ctrl == 3'b000 & out != A<<shift_cnt)
        $display("error in ctrl 000");
      else if(ctrl == 3'b001 & out != A>>shift_cnt)
        $display("error in ctrl 001");
      else if(ctrl == 3'b010 & out != A<<<shift_cnt)
        $display("error in ctrl 010");
      else if(ctrl == 3'b011 & out != A>>>shift_cnt)
        $display("error in ctrl 011");
    end
    ctrl = ctrl + 1'b1;
  end
  
endmodule
