module divide03 #
(								//parameter是verilog里参数定义
parameter	WIDTH	=	32		//计数器的位数，计数的最大值为 2**(WIDTH-1)
)
(
input		clk,		//clk频率50MHz
input		rst_n,		//复位信号，高有效，
input  	[31:0]N,				//分频系数，确保 N<2**(WIDTH-1)，否则计数会溢出
output	reg	clkout		//输出信号，连接到蜂鸣器beep
);
 
reg	[WIDTH-1:0]	cnt_p;	//WIDTH位，计数器	
reg 	[31:0]n; //自动复位，temp变量n用于检测分频系数是否变化（音调变化）
 
always @(posedge clk)	
	begin	
		n<=N;
		
		if(rst_n)
			begin
			cnt_p <= 1'b0;
			clkout <= 1'b0;
			end
		
		if(cnt_p == (N-1))
			begin
			cnt_p <= 1'b0;
			clkout <= ~clkout;
			end
		else if(N!=n)//当输入的分频系数变化（音调变化）时自动复位重新计数，否则仿真时将出错
		cnt_p <= 1'b0;
		else
			begin	
			cnt_p <= cnt_p + 1'b1;		//计数器一直计数，当计数到N-1的时候清零，这是一个模N的计数器
			end
	end
endmodule