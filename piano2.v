module piano2 (clk,rst,row,col_R,col_G,sw,btn,freq,auto,seg,cat,E,RS,data);
 
	input clk,rst,auto;	//输入时钟，复位按钮
	input [1:0]sw;
	input [6:0]btn;
	
	
	output [7:0] row;
	output [7:0] col_R;
	output [7:0] col_G;
	output reg freq;//给蜂鸣器的发声频率
	output wire [6:0]seg;//数码管阳极
	output reg [7:0]cat;//数码管阴极
	output E,RS;
	output [7:0] data;
	wire beep[20:0];	
	
	wire freq_temp;
	reg [23:0]tone;
	reg  [2:0] cnt ;//传递给扫描变量scan的计数器，不应过快或者过慢
	reg [13:0] cnt_scan;//用于产生扫描频率——3,051hz,2^14分频
	

	//自动播放使用的声明
	//	reg   [17:0]TONE[13:0];//存储乐章频率
		reg   [6:0]	btn_auto[91:0];//数组预存演奏顺序，模拟btn
		reg   [1:0]	sw_auto[91:0];//模拟sw
		reg   [23:0] cnt2 ;//用于由50Mhzclk产生发声频率的计数器
		reg   [7:0] cnt_auto;//自动播放节拍频率2.98hz
		reg   [6:0] BTN;
		reg   [1:0] SW;
		initial 
		begin
		btn_auto[0]=7'b0000_010;sw_auto[0]=2'b00;//6b
		btn_auto[1]=7'b1000_000;sw_auto[1]=2'b10;//1
		btn_auto[2]=7'b0010_000;sw_auto[2]=2'b10;//3
		btn_auto[3]=7'b1000_000;sw_auto[3]=2'b10;//1
		btn_auto[4]=7'b0100_000;sw_auto[4]=2'b10;//2
		
		btn_auto[5]=7'b0100_000;sw_auto[5]=2'b10;//延音2
		
		btn_auto[6]=7'b1000_000;sw_auto[6]=2'b10;//1
		btn_auto[7]=7'b0000_001;sw_auto[7]=2'b00;//7b
		btn_auto[8]=7'b0010_000;sw_auto[8]=2'b10;//3
		
		btn_auto[9]=7'b0010_000;sw_auto[9]=2'b10;//3
		btn_auto[10]=7'b0100_000;sw_auto[10]=2'b10;//2
		btn_auto[11]=7'b0100_000;sw_auto[11]=2'b10;//2
		//第一节
		btn_auto[12]=7'b0000_010;sw_auto[12]=2'b00;//6b
		btn_auto[13]=7'b0000_010;sw_auto[13]=2'b00;//
		btn_auto[14]=7'b0000_000;sw_auto[14]=2'b10;//休止
		btn_auto[15]=7'b0000_000;sw_auto[15]=2'b10;//
		
		btn_auto[16]=7'b1000_000;sw_auto[16]=2'b10;//1
		btn_auto[17]=7'b0010_000;sw_auto[17]=2'b10;//3
		btn_auto[18]=7'b0000_100;sw_auto[18]=2'b10;//5
		btn_auto[19]=7'b0000_100;sw_auto[19]=2'b10;//5
		
		btn_auto[20]=7'b0000_010;sw_auto[20]=2'b10;//6
		btn_auto[21]=7'b0000_010;sw_auto[21]=2'b10;//
		btn_auto[22]=7'b0000_100;sw_auto[22]=2'b10;//5
		btn_auto[23]=7'b0001_000;sw_auto[23]=2'b10;//4
		
		btn_auto[24]=7'b0010_000;sw_auto[24]=2'b10;//3
		btn_auto[25]=7'b0010_000;sw_auto[25]=2'b10;//
		btn_auto[26]=7'b0000_000;sw_auto[26]=2'b10;//休止
		btn_auto[27]=7'b0000_000;sw_auto[27]=2'b10;//
		//重复1
		btn_auto[28]=7'b0000_100;sw_auto[28]=2'b10;//夜色
		btn_auto[29]=7'b0000_100;sw_auto[29]=2'b10;
		
		//btn_auto[28]=7'b1100_000;sw_auto[28]=2'b10;//夜色
		//btn_auto[29]=7'b1100_000;sw_auto[29]=2'b10;
		//btn_auto[30]=7'b0000_110;sw_auto[30]=2'b10;//多美好#5
		//btn_auto[31]=7'b0000_110;sw_auto[31]=2'b10;//#5
		btn_auto[30]=7'b0000_010;sw_auto[30]=2'b10;//多美好#5
		btn_auto[31]=7'b0000_010;sw_auto[31]=2'b10;//#5
		
		btn_auto[32]=7'b0000_001;sw_auto[32]=2'b10;//7
		btn_auto[33]=7'b0000_010;sw_auto[33]=2'b10;//6
		btn_auto[34]=7'b0010_000;sw_auto[34]=2'b10;//3
		btn_auto[35]=7'b0010_000;sw_auto[35]=2'b10;//-
		
		btn_auto[36]=7'b0010_000;sw_auto[36]=2'b10;//3
		btn_auto[37]=7'b0000_001;sw_auto[37]=2'b00;//7b
		btn_auto[38]=7'b0000_001;sw_auto[38]=2'b00;//-
		btn_auto[39]=7'b0000_010;sw_auto[39]=2'b00;//6b
		
		btn_auto[40]=7'b0010_000;sw_auto[40]=2'b10;//3
		btn_auto[41]=7'b0100_000;sw_auto[41]=2'b10;//2
		btn_auto[42]=7'b0001_000;sw_auto[42]=2'b10;//4
		btn_auto[43]=7'b0001_000;sw_auto[43]=2'b10;//-
		
		btn_auto[44]=7'b0001_000;sw_auto[44]=2'b10;//4
		btn_auto[45]=7'b0000_000;sw_auto[45]=2'b10;//0休止符
		btn_auto[46]=7'b0000_100;sw_auto[46]=2'b10;//5
		btn_auto[47]=7'b0001_000;sw_auto[47]=2'b10;//4
		
		btn_auto[48]=7'b0010_000;sw_auto[48]=2'b10;//3
		btn_auto[49]=7'b0010_000;sw_auto[49]=2'b10;//-
		btn_auto[50]=7'b0100_000;sw_auto[50]=2'b10;//2
		btn_auto[51]=7'b1000_000;sw_auto[51]=2'b10;//1
		
		btn_auto[52]=7'b0010_000;sw_auto[52]=2'b10;//3
		btn_auto[53]=7'b0010_000;sw_auto[53]=2'b10;//-
		btn_auto[54]=7'b0100_000;sw_auto[54]=2'b10;//2
		btn_auto[55]=7'b0100_000;sw_auto[55]=2'b10;//-
		
		btn_auto[56]=7'b0000_010;sw_auto[56]=2'b00;//6b
		btn_auto[57]=7'b0000_010;sw_auto[57]=2'b00;//-
		btn_auto[58]=7'b0000_000;sw_auto[58]=2'b10;//
		btn_auto[59]=7'b0000_000;sw_auto[59]=2'b10;//
		//重复1结束
		//重复2（高八度）
		btn_auto[60]=7'b0000_100;sw_auto[60]=2'b11;//夜色
		btn_auto[61]=7'b0000_100;sw_auto[61]=2'b11;
		//btn_auto[62]=7'b0000_110;sw_auto[62]=2'b11;//多美好#5
		//btn_auto[63]=7'b0000_110;sw_auto[63]=2'b11;//#5
		btn_auto[62]=7'b0000_010;sw_auto[62]=2'b11;//多美好#5
		btn_auto[63]=7'b0000_010;sw_auto[63]=2'b11;//#5
		
		btn_auto[64]=7'b0000_001;sw_auto[64]=2'b11;//7
		btn_auto[65]=7'b0000_010;sw_auto[65]=2'b11;//6
		btn_auto[66]=7'b0010_000;sw_auto[66]=2'b11;//3
		btn_auto[67]=7'b0010_000;sw_auto[67]=2'b11;//-
		
		btn_auto[68]=7'b0010_000;sw_auto[68]=2'b11;//3
		btn_auto[69]=7'b0000_001;sw_auto[69]=2'b10;//7b
		btn_auto[70]=7'b0000_001;sw_auto[70]=2'b10;//-
		btn_auto[71]=7'b0000_010;sw_auto[71]=2'b10;//6b
		
		btn_auto[72]=7'b0010_000;sw_auto[72]=2'b11;//3
		btn_auto[73]=7'b0100_000;sw_auto[73]=2'b11;//2
		btn_auto[74]=7'b0001_000;sw_auto[74]=2'b11;//4
		btn_auto[75]=7'b0001_000;sw_auto[75]=2'b11;//-
		
		btn_auto[76]=7'b0001_000;sw_auto[75]=2'b11;//4
		btn_auto[77]=7'b0000_000;sw_auto[76]=2'b11;//0休止符
		btn_auto[78]=7'b0000_100;sw_auto[78]=2'b11;//5
		btn_auto[79]=7'b0001_000;sw_auto[79]=2'b11;//4
		
		btn_auto[80]=7'b0010_000;sw_auto[80]=2'b11;//3
		btn_auto[81]=7'b0010_000;sw_auto[81]=2'b11;//-
		btn_auto[82]=7'b0100_000;sw_auto[82]=2'b11;//2
		btn_auto[83]=7'b1000_000;sw_auto[83]=2'b11;//1
		
		btn_auto[84]=7'b0010_000;sw_auto[84]=2'b11;//3
		btn_auto[85]=7'b0010_000;sw_auto[85]=2'b11;//-
		btn_auto[86]=7'b0100_000;sw_auto[86]=2'b11;//2
		btn_auto[87]=7'b0100_000;sw_auto[87]=2'b11;//-
		
		btn_auto[88]=7'b0000_010;sw_auto[88]=2'b10;//6b
		btn_auto[89]=7'b0000_010;sw_auto[89]=2'b10;//-
		btn_auto[90]=7'b0000_000;sw_auto[90]=2'b11;//
		btn_auto[91]=7'b0000_000;sw_auto[91]=2'b11;//
		//重复2结束
		
		cnt_scan = 0;
		cnt2 = 0;
		cnt_auto <= 0;
		cnt <= 0;
		tone <= 0;
		cat<= 8'b0111_1111;
		end//初始化
	
		decode38_row u1 ( //行扫描                                  
			.scan(cnt),                 //例化的输入端口连接到cnt，输出端口连接到row，扫描频率scan为  
			.led(row)
			);
		decode38_col u2 ( //列扫描                                  
		.scan(cnt),                  //例化的输入端口连接到cnt，输出端口连接到col_R、col_G，根据当前的BTN和SW状态显示不同的图像
			.led_R(col_R),
			.led_G(col_G),
			.btn(BTN),
			.sw(SW)
			);	
		seg s1(//数码管显示
			.clk(clk),
			.btn(BTN),
			.seg(seg)
			);
			
		LCD l1(
		.btn(BTN),
		.sw(SW),
		.clk(clk),
		.rst(rst),
		.E(E),
		.RS(RS),
		.data(data)
		);//lcd显示
			
			
		divide03 #(.WIDTH(32)) u111 (         
								.clk(clk),
								.rst_n(rst),
								.N(tone/2),
								.clkout(freq_temp)
								);//主发声分频器，通过检测7位btn状态，传入不同的分频参数，实现音调变化，减少逻辑门的使用
	
						
						
	always@(posedge clk)
		begin
			if(!auto)
			begin
			BTN<=btn;
			SW<=sw;
			end
				//定义扫描频率——100hz
				begin		
										if (rst)
											begin
											cnt_auto <= 0;
											cnt <= 0;
											end
										else
											cnt_scan <= cnt_scan +1;
										if(cnt_scan==0)
										begin
										cnt <= cnt +1;
										end
				end
			//freq<=freq_temp;
			case(SW)
				2'b00://低音
						case(BTN)
						7'b1000_000:begin tone<=191109;freq<=freq_temp;end//  50Mhz÷分频系数191109=261.63hz=bdo
						
						7'b0100_000:begin tone<=170259;freq<=freq_temp;end//  bri  分频系数<=170259
					
						7'b0010_000:begin tone<=151685;freq<=freq_temp;end//  bmi  分频系数<=151685
						
						7'b0001_000:begin tone<=143172;freq<=freq_temp;end//  bfa  分频系数<=143172
						
						7'b0000_100:begin tone<=127554;freq<=freq_temp;end//  bso  分频系数<=127554
						
						7'b0000_010:begin tone<=113636;freq<=freq_temp;end//  bla  分频系数<=113636
						
						7'b0000_001:begin tone<=101239;freq<=freq_temp;end//  bxi  分频系数<=101239
						
						default:;//同时按下多个音符的情况
						endcase
				2'b11://高音
						case(BTN)
						7'b1000_000:begin tone<=47778;freq<=freq_temp;end//#do——95557
							
						7'b0100_000:begin tone<=42566;freq<=freq_temp;end//#ri——95557
							
						7'b0010_000:begin tone<=37922;freq<=freq_temp;end//#mi——95557
							
						7'b0001_000:begin tone<=35793;freq<=freq_temp;end//#fa——95557
							
						7'b0000_100:begin tone<=31888;freq<=freq_temp;end//#so——95557
							
						7'b0000_010:begin tone<=28409;freq<=freq_temp;end//#la——95557
							
						7'b0000_001:begin tone<=25310;freq<=freq_temp;end//#xi——95557
						
						7'b0000_110:begin tone<=30048;freq<=freq_temp;end//#5 5.5 #so——30048升so音在乐谱中有使用
							
						default:;//同时按下多个音符的情况
						endcase
				
				default://中音
						case(BTN)
						7'b1000_000:begin tone<=95557;freq<=freq_temp;end//do——95557
							
						7'b0100_000:begin tone<=85131;freq<=freq_temp;end//ri——85131
							
						7'b0010_000:begin tone<=75844;freq<=freq_temp;end//mi——75844
							
						7'b0001_000:begin tone<=71586;freq<=freq_temp;end//fa——71586
							
						7'b0000_100:begin tone<=63776;freq<=freq_temp;end//so——63776
							
						7'b0000_010:begin tone<=56818;freq<=freq_temp;end//la——56818
							
						7'b0000_001:begin tone<=50620;freq<=freq_temp;end//xi——50620
						
						7'b0000_110:begin tone<=60097;freq<=freq_temp;end//#5 5.5 #so——60097升so音在乐谱中有使用
						
						7'b1100_000:begin tone<=67456;freq<=freq_temp;end//#5 5.5 #so——60097升so音在乐谱中有使用·
						
						7'b1100_111:begin tone<=63775;freq<=freq_temp;end//#5 5.5 #so——60097升so音在乐谱中有使用
							
						default:;//同时按下多个音符的情况
						endcase
			endcase
			//自动播放
				if(auto)
							begin
										if (rst)//复位
											begin
											cnt2 <= 0;
											cnt_auto <= 0;
											end
										else//产生自动播放节拍频率2.98hz
											cnt2 <= cnt2 +1;
										if(cnt2==0)
										begin//以2.98hz的频率遍历数组，自动播放音乐
										BTN <= btn_auto[cnt_auto];
										SW <= sw_auto[cnt_auto];
										if(cnt_auto==91/*61*/) cnt_auto <= 0;//所有音符播放完毕重新开始
										else cnt_auto <= cnt_auto +1;
										end
								end
			
		end
			

 
        endmodule
		  
		  		
		/*btn_auto[0]=7'b0000_010;sw_auto[0]=2'b00;//6b
		btn_auto[1]=7'b0000_010;sw_auto[1]=2'b00;//1
		btn_auto[2]=7'b0000_010;sw_auto[2]=2'b00;//3
		btn_auto[3]=7'b0000_001;sw_auto[3]=2'b00;//1
		btn_auto[4]=7'b1000_000;sw_auto[4]=2'b10;//2
		
		btn_auto[5]=7'b1000_000;sw_auto[5]=2'b10;//延音2
		
		btn_auto[6]=7'b1000_000;sw_auto[6]=2'b10;//1
		btn_auto[7]=7'b0000_010;sw_auto[7]=2'b00;//7b
		btn_auto[8]=7'b1000_000;sw_auto[8]=2'b10;//3
		
		btn_auto[9]=7'b1000_000;sw_auto[9]=2'b10;//3
		btn_auto[10]=7'b0000_001;sw_auto[10]=2'b00;//2
		btn_auto[11]=7'b0000_010;sw_auto[11]=2'b00;//2
		//第一节
		btn_auto[12]=7'b0000_001;sw_auto[12]=2'b00;//6b
		btn_auto[13]=7'b0000_001;sw_auto[13]=2'b00;//
		btn_auto[14]=7'b0010_000;sw_auto[14]=2'b00;//休止
		btn_auto[15]=7'b0000_000;sw_auto[15]=2'b10;//
		
		btn_auto[16]=7'b1000_001;sw_auto[16]=2'b00;//1
		btn_auto[17]=7'b0000_001;sw_auto[17]=2'b00;//3
		btn_auto[18]=7'b0000_001;sw_auto[18]=2'b00;//5
		btn_auto[19]=7'b1000_000;sw_auto[19]=2'b10;//5
		
		btn_auto[20]=7'b0100_000;sw_auto[20]=2'b10;//6
		btn_auto[21]=7'b0100_000;sw_auto[21]=2'b10;//
		btn_auto[22]=7'b0100_000;sw_auto[22]=2'b10;//5
		btn_auto[23]=7'b0000_001;sw_auto[23]=2'b00;//4
		
		btn_auto[24]=7'b0100_000;sw_auto[24]=2'b10;//3
		btn_auto[25]=7'b0100_000;sw_auto[25]=2'b10;//
		btn_auto[26]=7'b1000_000;sw_auto[26]=2'b10;//休止
		btn_auto[27]=7'b0000_001;sw_auto[27]=2'b00;//
		//重复1
		btn_auto[28]=7'b0000_010;sw_auto[28]=2'b00;//夜色
		btn_auto[29]=7'b0000_010;sw_auto[29]=2'b00;
		//btn_auto[28]=7'b1100_000;sw_auto[28]=2'b10;//夜色
		//btn_auto[29]=7'b1100_000;sw_auto[29]=2'b10;
		//btn_auto[30]=7'b0000_110;sw_auto[30]=2'b10;//多美好#5
		//btn_auto[31]=7'b0000_110;sw_auto[31]=2'b10;//#5
		btn_auto[30]=7'b0010_000;sw_auto[30]=2'b10;//多美好#5
		btn_auto[31]=7'b0010_000;sw_auto[31]=2'b10;//#5
		
		btn_auto[32]=7'b0000_010;sw_auto[32]=2'b10;//7
		btn_auto[33]=7'b0000_010;sw_auto[33]=2'b10;//6
		btn_auto[34]=7'b0000_100;sw_auto[34]=2'b10;//3
		btn_auto[35]=7'b0000_100;sw_auto[35]=2'b10;//-
		
		btn_auto[36]=7'b0000_010;sw_auto[36]=2'b10;//3
		btn_auto[37]=7'b0000_100;sw_auto[37]=2'b10;//7b
		btn_auto[38]=7'b0001_000;sw_auto[38]=2'b10;//-
		btn_auto[39]=7'b0001_000;sw_auto[39]=2'b10;//6b
		
		btn_auto[40]=7'b0010_000;sw_auto[40]=2'b10;//3
		btn_auto[41]=7'b0100_000;sw_auto[41]=2'b10;//2
		btn_auto[42]=7'b0010_000;sw_auto[42]=2'b10;//4
		btn_auto[43]=7'b0010_000;sw_auto[43]=2'b10;//-
		
		btn_auto[44]=7'b0000_010;sw_auto[44]=2'b00;//4
		btn_auto[45]=7'b0000_010;sw_auto[45]=2'b00;//0休止符
		btn_auto[46]=7'b0000_000;sw_auto[46]=2'b10;//5
		btn_auto[47]=7'b0001_000;sw_auto[47]=2'b10;//4
		
		btn_auto[48]=7'b0001_000;sw_auto[48]=2'b10;//3
		btn_auto[49]=7'b0100_000;sw_auto[49]=2'b10;//-
		btn_auto[50]=7'b0001_000;sw_auto[50]=2'b10;//2
		btn_auto[51]=7'b0001_000;sw_auto[51]=2'b10;//1
		
		btn_auto[52]=7'b0001_000;sw_auto[52]=2'b10;//3
		btn_auto[53]=7'b1000_000;sw_auto[53]=2'b10;//-
		btn_auto[54]=7'b0000_001;sw_auto[54]=2'b00;//2
		btn_auto[55]=7'b0010_000;sw_auto[55]=2'b00;//-
		
		btn_auto[56]=7'b1000_000;sw_auto[56]=2'b10;//6b
		btn_auto[57]=7'b0000_001;sw_auto[57]=2'b00;//-
		btn_auto[58]=7'b0000_010;sw_auto[58]=2'b00;//
		btn_auto[59]=7'b0000_010;sw_auto[59]=2'b00;//
		//重复1结束
		//重复2（高八度）
		btn_auto[60]=7'b0000_000;sw_auto[60]=2'b11;//夜色
		btn_auto[61]=7'b0000_000;sw_auto[61]=2'b11;*/
		