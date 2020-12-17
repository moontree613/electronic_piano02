module decode38_row (scan,led);
 
	input [2:0] scan;						//扫描参量scan，频率3,125,000hz
	output [7:0] led;						//输出行译码信号
 
        reg [7:0] led;              //定义led为reg型变量，在always过程块中只能对reg型变量赋值
 
        //always过程块，括号中scan为敏感变量，当scan变化一次执行一次always中所有语句，否则保持不变
	always @ (scan)
	begin
		case(scan)                                               
			3'b000:	led=8'b0111_1111;  //从0——最下一行开始扫描   
			3'b001:	led=8'b1011_1111;                     
			3'b010:	led=8'b1101_1111;
			3'b011:	led=8'b1110_1111;
			3'b100:	led=8'b1111_0111;
			3'b101:	led=8'b1111_1011;
			3'b110:	led=8'b1111_1101;
			3'b111:	led=8'b1111_1110;
			default: ;
		endcase
	end
 
endmodule