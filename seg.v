module seg (
input		clk,		//clk频率为50MHz
input		[6:0]btn,		//传入按钮状态参数
output	 reg [6:0]seg		//输出信号，连接到数码管管脚
);

always @(posedge clk )	
	begin		
					case(btn)
					7'b1000_000:seg <= 7'b000_0110;//1
					7'b0100_000:seg <= 7'b101_1011;//2
					7'b0010_000:seg <= 7'b100_1111;//3
					7'b0001_000:seg <= 7'b110_0110;//4
					7'b0000_100:seg <= 7'b110_1101;//5
					7'b0000_010:seg <= 7'b111_1101;//6
					7'b0000_001:seg <= 7'b000_0111;//7
					default:		seg <= 7'b000_0000;//不按或者多按则不显示
					endcase
				end

endmodule