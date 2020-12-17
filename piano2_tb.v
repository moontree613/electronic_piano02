`timescale 10ns/1ns


module piano2_tb;
	//输入输出
	reg clk,rst,auto;
	reg [1:0]sw;
	reg [6:0]btn;
	wire [7:0]row,col_R,col_G;
	wire freq;
	wire [6:0]seg;
	wire [7:0]cat;
	wire [7:0]data;
	wire E,RS;
	
	//reg [11:0]cnt;
	
//信号初始化
	initial
	begin 
	clk=0;
	rst=1;
	auto=0;
	#1000
	rst=0;
	sw = 2'b11;
	#1000
	btn = 7'b1000_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0100_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0010_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0001_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_100;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_010;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_001;
	#10000000
	btn = 7'b0000_000;
	#10000
	//中音段仿真
	sw = 2'b10;
	#1000
	btn = 7'b1000_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0100_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0010_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0001_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_100;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_010;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_001;
	#10000000
	btn = 7'b0000_000;
	#10000
	//低音段仿真
	sw = 2'b00;
	#1000
	btn = 7'b1000_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0100_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0010_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0001_000;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_100;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_010;
	#10000000
	btn = 7'b0000_000;
	#10000
	btn = 7'b0000_001;
	#10000000
	btn = 7'b0000_000;
	#10000
	auto=1;
	#2;
	end
	
	always #10 clk = ~clk;


 piano2 u1(//clk,rst,row,col_R,col_G,sw,btn,freq,auto,seg,cat
 .clk(clk),
 .rst(rst),
 .row(row),
 .col_R(col_R),
 .col_G(col_G),
 .sw(sw),
 .btn(btn),
 .freq(freq),
 .auto(auto),
 .seg(seg),
 .cat(cat),
 .E(E),
 .RS(RS),
 .data(data)
 );

 endmodule
 