module decode38_col 

(scan,led_R,led_G,btn,sw);
 
	input [2:0] scan;//输入的扫描变量，和行扫描保持一致
	input [6:0]btn;//按钮信号
	input [1:0]sw;//拨管开关信号
	
	output [7:0] led_R;						//输出列译码信号
	output [7:0] led_G;
 
        reg [7:0] led_R;//定义为reg型变量，在always过程块中只能对reg型变量赋值
		  reg [7:0] led_G;
		  reg [7:0]image_R7;
		  reg [7:0]image_R6;
		  reg [7:0]image_R5;
		  reg [7:0]image_R4;
		  reg [7:0]image_R3;
		  reg [7:0]image_R2;
		  reg [7:0]image_R1;
		  reg [7:0]image_R0;
		  reg [7:0]image_G7;
		  reg [7:0]image_G6;
		  reg [7:0]image_G5;
		  reg [7:0]image_G4;
		  reg [7:0]image_G3;
		  reg [7:0]image_G2;
		  reg [7:0]image_G1;
		  reg [7:0]image_G0;

 
        //always过程块，括号中scan为敏感变量，当scan变化一次执行一次always中所有语句，否则保持不变
	always @ (scan)
	begin
		case(sw)//先判断拨码开关状态
					2'b00:begin //低音
							image_R7<=0;//低音只显示绿色led
							image_R6<=0;
							image_R5<=0;
							image_R4<=0;
							image_R3<=0;
							image_R2<=0;
							image_R1<=0;
							image_R0<=0;
							case(btn)//判断按钮状态
								7'b1000_000:begin image_G7<=8'b0111_1110;image_G6<=8'b0111_1110;image_G5<=8'b0011_1110;image_G4<=8'b0001_1110;
														image_G3<=8'b0000_1110;image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
									
								7'b0100_000:begin image_G7<=8'b1011_1110;image_G6<=8'b0011_1110;image_G5<=8'b0011_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
								
								7'b0010_000:begin image_G7<=8'b1101_1110;image_G6<=8'b0101_1110;image_G5<=8'b0001_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
									
								7'b0001_000:begin image_G7<=8'b1110_1110;image_G6<=8'b0110_1110;image_G5<=8'b0010_1110;image_G4<=8'b0000_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
								
								7'b0000_100:begin image_G7<=8'b1111_0110;image_G6<=8'b0111_0110;image_G5<=8'b0011_0110;image_G4<=8'b0001_0110;
														image_G3<=8'b0000_0110;image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
								
								7'b0000_010:begin image_G7<=8'b1111_1010;image_G6<=8'b0111_1010;image_G5<=8'b0011_1010;image_G4<=8'b0001_1010;
														image_G3<=8'b0000_1010;image_G2<=8'b0000_0010;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
									
								7'b0000_001:begin image_G7<=8'b1111_1100;image_G6<=8'b0111_1100;image_G5<=8'b0011_1100;image_G4<=8'b0001_1100;
														image_G3<=8'b0000_1100;image_G2<=8'b0000_0100;image_G1<=8'b0000_0000;image_G0<=8'b0000_0000;end
								
								7'b0000_000:begin image_G7<=8'b1111_1110;image_G6<=8'b0111_1110;image_G5<=8'b0011_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end //复位
								default:;
							endcase
							end
							
					2'b11:begin //高音
							case(btn)//高音显示黄色和绿色led
								7'b1000_000:begin image_R7<=8'b0111_1110;image_R6<=8'b0111_1110;image_R5<=8'b0011_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b0111_1110;image_G6<=8'b0111_1110;image_G5<=8'b0011_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
									
								7'b0100_000:begin image_R7<=8'b1011_1110;image_R6<=8'b0011_1110;image_R5<=8'b0011_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b1011_1110;image_G6<=8'b0011_1110;image_G5<=8'b0011_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
								
								7'b0010_000:begin image_R7<=8'b1101_1110;image_R6<=8'b0101_1110;image_R5<=8'b0001_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b1101_1110;image_G6<=8'b0101_1110;image_G5<=8'b0001_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
									
								7'b0001_000:begin image_R7<=8'b1110_1110;image_R6<=8'b0110_1110;image_R5<=8'b0010_1110;image_R4<=8'b0000_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b1110_1110;image_G6<=8'b0110_1110;image_G5<=8'b0010_1110;image_G4<=8'b0000_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
								
								7'b0000_100:begin image_R7<=8'b1111_0110;image_R6<=8'b0111_0110;image_R5<=8'b0011_0110;image_R4<=8'b0001_0110;
														image_R3<=8'b0000_0110;image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b1111_0110;image_G6<=8'b0111_0110;image_G5<=8'b0011_0110;image_G4<=8'b0001_0110;
														image_G3<=8'b0000_0110;image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
								
								7'b0000_010:begin image_R7<=8'b1111_1010;image_R6<=8'b0111_1010;image_R5<=8'b0011_1010;image_R4<=8'b0001_1010;
														image_R3<=8'b0000_1010;image_R2<=8'b0000_0010;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b1111_1010;image_G6<=8'b0111_1010;image_G5<=8'b0011_1010;image_G4<=8'b0001_1010;
														image_G3<=8'b0000_1010;image_G2<=8'b0000_0010;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end
									
								7'b0000_001:begin image_R7<=8'b1111_1100;image_R6<=8'b0111_1100;image_R5<=8'b0011_1100;image_R4<=8'b0001_1100;
														image_R3<=8'b0000_1100;image_R2<=8'b0000_0100;image_R1<=8'b0000_0000;image_R0<=8'b0000_0000;
														image_G7<=8'b1111_1100;image_G6<=8'b0111_1100;image_G5<=8'b0011_1100;image_G4<=8'b0001_1100;
														image_G3<=8'b0000_1100;image_G2<=8'b0000_0100;image_G1<=8'b0000_0000;image_G0<=8'b0000_0000;end
								
								7'b0000_000:begin image_R7<=8'b1111_1110;image_R6<=8'b0111_1110;image_R5<=8'b0011_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;
														image_G7<=8'b1111_1110;image_G6<=8'b0111_1110;image_G5<=8'b0011_1110;image_G4<=8'b0001_1110;image_G3<=8'b0000_1110;
														image_G2<=8'b0000_0110;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;end //复位
								7'b0000_110:begin image_G7<=8'b1111_1010;image_G6<=8'b0111_1010;image_G5<=8'b0011_1010;image_G4<=8'b0001_1010;image_G3<=8'b0000_1010;
														image_G2<=8'b0000_0010;image_G1<=8'b0000_0010;image_G0<=8'b0000_0000;
														image_R7<=8'b1111_1010;image_R6<=8'b0111_1010;image_R5<=8'b0011_1010;image_R4<=8'b0001_1010;image_R3<=8'b0000_1010;
														image_R2<=8'b0000_0010;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end //复位
								default:;
							endcase
							end
							
					default:begin //中音
							image_G7<=0;
							image_G6<=0;
							image_G5<=0;
							image_G4<=0;
							image_G3<=0;
							image_G2<=0;
							image_G1<=0;
							image_G0<=0;
							case(btn)//中音只显示红色led
								7'b1000_000:begin image_R7<=8'b0111_1110;image_R6<=8'b0111_1110;image_R5<=8'b0011_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end
									
								7'b0100_000:begin image_R7<=8'b1011_1110;image_R6<=8'b0011_1110;image_R5<=8'b0011_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end
								
								7'b0010_000:begin image_R7<=8'b1101_1110;image_R6<=8'b0101_1110;image_R5<=8'b0001_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end
									
								7'b0001_000:begin image_R7<=8'b1110_1110;image_R6<=8'b0110_1110;image_R5<=8'b0010_1110;image_R4<=8'b0000_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end
								
								7'b0000_100:begin image_R7<=8'b1111_0110;image_R6<=8'b0111_0110;image_R5<=8'b0011_0110;image_R4<=8'b0001_0110;
														image_R3<=8'b0000_0110;image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end
								
								7'b0000_010:begin image_R7<=8'b1111_1010;image_R6<=8'b0111_1010;image_R5<=8'b0011_1010;image_R4<=8'b0001_1010;
														image_R3<=8'b0000_1010;image_R2<=8'b0000_0010;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end
									
								7'b0000_001:begin image_R7<=8'b1111_1100;image_R6<=8'b0111_1100;image_R5<=8'b0011_1100;image_R4<=8'b0001_1100;
														image_R3<=8'b0000_1100;image_R2<=8'b0000_0100;image_R1<=8'b0000_0000;image_R0<=8'b0000_0000;end
								
								7'b0000_000:begin image_R7<=8'b1111_1110;image_R6<=8'b0111_1110;image_R5<=8'b0011_1110;image_R4<=8'b0001_1110;image_R3<=8'b0000_1110;
														image_R2<=8'b0000_0110;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end //复位
								7'b0000_110:begin image_R7<=8'b1111_1010;image_R6<=8'b0111_1010;image_R5<=8'b0011_1010;image_R4<=8'b0001_1010;image_R3<=8'b0000_1010;
														image_R2<=8'b0000_0010;image_R1<=8'b0000_0010;image_R0<=8'b0000_0000;end //复位
								default:;
							endcase
							end
		endcase
		
		
		case(scan)  //扫描参数scan和行扫描同步                                              					
			3'b000:		led_R<=image_R0; 
			3'b001:		led_R<=image_R1;
			3'b010:		led_R<=image_R2;	
			3'b011:		led_R<=image_R3;	
			3'b100:		led_R<=image_R4;
			3'b101:		led_R<=image_R5;	
			3'b110: 		led_R<=image_R6;	
			3'b111:		led_R<=image_R7;		
			default: ;
		endcase
		case(scan)                                                
			3'b000:			led_G<=image_G0;  
			3'b001:	   	led_G<=image_G1;  
			3'b010:			led_G<=image_G2;
			3'b011:			led_G<=image_G3;
			3'b100:			led_G<=image_G4;
			3'b101:			led_G<=image_G5;
			3'b110: 			led_G<=image_G6;
			3'b111:	 		led_G<=image_G7;
			default: ;
		endcase
	end
	
endmodule
