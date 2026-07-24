

module FIFO(clk,reset,write_en,read_en,data_in,data_out,empty,full);
input clk,reset,write_en,read_en;
input [7:0]data_in;
output reg [7:0]data_out;
output reg empty,full;
reg [7:0] memory [0:15];
reg [3:0] wr_ptr,rd_ptr;
reg [4:0] count; // To track number of elements

//Write pointer
always @(posedge clk or posedge reset)
begin
    if(reset)
        wr_ptr <= 0;
    else if(write_en && !full) begin 
	memory[wr_ptr] <= data_in;
	wr_ptr <= wr_ptr + 1;

	end

end

//Read pointer
always @(posedge clk or posedge reset)
begin
    if(reset)begin
        rd_ptr <= 0;
	data_out <= 0;
    end
    else if(read_en && !empty) begin
	data_out <= memory[rd_ptr];
        rd_ptr <= rd_ptr + 1;
    end
end
//Count elements in FIFO
always @(posedge clk or posedge reset)
begin
    if(reset)
        count <= 0;
    else begin
        case({write_en && !full, read_en && !empty})
            2'b10: count <= count + 1; // Write only
            2'b01: count <= count - 1; // Read only
            default: count <= count;   // Both or neither
        endcase
    end
end

//Empty & Full flag
always @(posedge clk or posedge reset)
begin
    if(reset) begin
        empty <= 1;
	full <= 0;
	end
    else begin
        empty <= (count == 0);
	full <= (count == 16);
	end
end

//memory reset
integer k;
always @(posedge clk or posedge reset)
begin
    if(reset) begin
	for(k=0;k<16;k=k+1) 
		memory[k] <=0;
	end 
end
endmodule
