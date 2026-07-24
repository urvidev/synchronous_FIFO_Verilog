
module FIFO_TB();
reg clk,reset,write_en,read_en;
reg [7:0]data_in;
wire [7:0]data_out;
wire empty,full;

FIFO dut(clk,reset,write_en,read_en,data_in,data_out,empty,full);

initial begin
clk=0;
forever #5 clk=~clk;
end
initial begin
$monitor("time=%0t | datain= %d | dataout = %d |empty=%d|full=%d",$time,data_in,data_out,empty,full);
end
integer k; 
initial begin
reset=1;
write_en=0;
read_en=0;
data_in=0;
#15;
reset=0;
for (k=0;k<16;k=k+1) begin
write_en=1;
data_in=k; #10;
end
write_en=0;
data_in=0;
#10;
read_en=1;
#170;
$finish;
end

endmodule
