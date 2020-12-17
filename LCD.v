module LCD(/*state*/btn,sw,clk,rst,E,RS,data);//signal1,

input clk,rst;//signal1
input [6:0]btn;
input [1:0]sw;

output E;
output reg RS;
output reg[7:0]data;

reg [127:0]r1;
reg [127:0]r2;
reg [19:0]count1;
reg [19:0]count2;
//reg [24:0]count;

wire clk1;
wire[127:0]row1;
wire[127:0]row2;

parameter T2=100000;//输入50Mhz;
parameter T1=20000;//50M÷50;
parameter IDLE=8'h00;//利用格雷码书写状态机的40种状态
parameter SET_FUNCTION=8'h01;
parameter DISP_OFF=8'h03;
parameter DISP_CLEAR=8'h02;
parameter ENTRY_MODE=8'h06;
parameter DISP_ON=8'h07;
parameter ROW1_ADDR=8'h05;
parameter ROW1_0=8'h04;
parameter ROW1_1=8'h0C;
parameter ROW1_2=8'h0D;
parameter ROW1_3=8'h0F;
parameter ROW1_4=8'h0E;
parameter ROW1_5=8'h0A;
parameter ROW1_6=8'h0B;
parameter ROW1_7=8'h09;
parameter ROW1_8=8'h08;
parameter ROW1_9=8'h18;
parameter ROW1_A=8'h19;
parameter ROW1_B=8'h1B;
parameter ROW1_C=8'h1A;
parameter ROW1_D=8'h1E;
parameter ROW1_E=8'h1F;
parameter ROW1_F=8'h1D;
parameter ROW2_ADDR=8'h1C;
parameter ROW2_0=8'h14;
parameter ROW2_1=8'h15;
parameter ROW2_2=8'h17;
parameter ROW2_3=8'h16;
parameter ROW2_4=8'h12;
parameter ROW2_5=8'h13;
parameter ROW2_6=8'h11;
parameter ROW2_7=8'h10;
parameter ROW2_8=8'h30;
parameter ROW2_9=8'h31;
parameter ROW2_A=8'h33;
parameter ROW2_B=8'h32;
parameter ROW2_C=8'h36;
parameter ROW2_D=8'h37;
parameter ROW2_E=8'h35;
parameter ROW2_F=8'h34;

assign row1 =r1;//连续赋值第一行显示的内容(16个字符)
assign row2 =r2;//第二行显示的内容(16个字符)

/*reg [23:0]m;
initial m=50; */
//计数部分

/*always @(posedge clk1 or posedge rst) //设置一个计数器，让这个计数器收到开始信号signal1的控制。这里计数器的作用是为了LCD在一定时间内工作
  begin                    
    if(rst)
	   count<=25'b0;
	 else //if(signal1)
	   count<=count+1;
  end*/

/*divide03 #(.WIDTH(32)) //时钟分频例化,分出扫描4Hz
	               d4(         
			 .clk(clk),
			 .rst_n(rst),
			 .N(m/2),		 
		    .clkout(clk1)

			     );	*/

//计数部分结束，初始部分开始
				  
always@(posedge /*clk*/clk or posedge rst)//需要20ms以达上电稳定(初始化)
    if(rst)
        count1<=1'b0;
    else if(count1==T1-1'b1)
        count1<=count1;
    else
        count1<=count1+1'b1 ;

wire delay_done=(count1==T1-1'b1)?1'b1:1'b0;//上电延时完毕

always@(posedge /*clk*/clk or posedge rst)  //上电延时完成后，进入工作周期
    if(rst)
        count2<=1'b0;
    else if(delay_done)
        if(count2==T2-1'b1)
            count2<=1'b0;
    else
        count2<=count2+1'b1;
    else
        count2<=1'b0;

assign E=(count2>(T2-1'b1)/2)?1'b0:1'b1;//使能端,每个工作周期一次下降沿,执行一次命令
wire a=(count2==T2-1'b1)?1'b1:1'b0;//每到一个工作周期,a置高一周期

reg[5:0]n;//now当前状态
reg[5:0]f;//future下一状态

always@(posedge clk/*clk1*/ or posedge rst)
    if(rst)
        n<=IDLE;
    else if(a)//每一个工作周期改变一次状态
        n<=f;
    else
        n<=n;

always@(*)  //任何一个输入信号或电平发生变化时，该语句下方的模块将被执行
    case (n)
        IDLE:f=SET_FUNCTION;
        SET_FUNCTION:f=DISP_OFF;
        DISP_OFF:f=DISP_CLEAR;
        DISP_CLEAR:f=ENTRY_MODE;
        ENTRY_MODE:f=DISP_ON;
        DISP_ON:f=ROW1_ADDR;
        ROW1_ADDR:f=ROW1_0;
        ROW1_0:f=ROW1_1;
        ROW1_1:f=ROW1_2;
        ROW1_2:f=ROW1_3;
        ROW1_3:f=ROW1_4;
        ROW1_4:f=ROW1_5;
        ROW1_5:f=ROW1_6;
        ROW1_6:f=ROW1_7;
        ROW1_7:f=ROW1_8;
        ROW1_8:f=ROW1_9;
        ROW1_9:f=ROW1_A;
        ROW1_A:f=ROW1_B;
        ROW1_B:f=ROW1_C;
        ROW1_C:f=ROW1_D;
        ROW1_D:f=ROW1_E;
        ROW1_E:f=ROW1_F;
        ROW1_F:f=ROW2_ADDR;
        ROW2_ADDR:f=ROW2_0;
        ROW2_0:f=ROW2_1;
        ROW2_1:f=ROW2_2;
        ROW2_2:f=ROW2_3;
        ROW2_3:f=ROW2_4;
        ROW2_4:f=ROW2_5;
        ROW2_5:f=ROW2_6;
        ROW2_6:f=ROW2_7;
        ROW2_7:f=ROW2_8;
        ROW2_8:f=ROW2_9;
        ROW2_9:f=ROW2_A;
        ROW2_A:f=ROW2_B;
        ROW2_B:f=ROW2_C;
        ROW2_C:f=ROW2_D;
        ROW2_D:f=ROW2_E;
        ROW2_E:f=ROW2_F;
        ROW2_F:f=ROW1_ADDR;//循环到1-1进行扫描显示
        default:;
    endcase
	 
always@(posedge /*clk*/clk or posedge rst)
    if(rst)
        RS<=1'b0;//为0时输入指令,为1时输入数据
    else if(a)
        //当状态为七个指令任意一个,将RS置为指令输入状态
        if((f==SET_FUNCTION)||(f==DISP_OFF)||(f==DISP_CLEAR)||(f==ENTRY_MODE)||(f==DISP_ON)||(f==ROW1_ADDR)||(f==ROW2_ADDR))
            RS<=1'b0; 
        else
            RS<=1'b1;
        else
            RS<=RS;

always@(posedge /*clk*/clk or posedge rst)
    if(rst)
        data<=1'b0;
    else if(a)
        case(f)
            IDLE:data<=8'hxx;
            SET_FUNCTION:data<=8'h38;//8'b0011_1000,工作方式设置:DL=1(DB4,8位数据接口),N=1(DB3,两行显示),L=0(DB2,5x8点阵显示).
            DISP_OFF:data<=8'h08;//8'b0000_1000,显示开关设置:D=0(DB2,显示关),C=0(DB1,光标不显示),D=0(DB0,光标不闪烁)
            DISP_CLEAR:data<=8'h01;//8'b0000_0001,清屏
            ENTRY_MODE:data<=8'h06;//8'b0000_0110,进入模式设置:I/D=1(DB1,写入新数据光标右移),S=0(DB0,显示不移动)
            DISP_ON:data<=8'h0c;//8'b0000_1100,显示开关设置:D=1(DB2,显示开),C=0(DB1,光标不显示),D=0(DB0,光标不闪烁)
            ROW1_ADDR:data<=8'h80;//8'b1000_0000,设置DDRAM地址:00H->1-1,第一行第一位
            //将输入的row1以每8-bit拆分,分配给对应的显示位
            ROW1_0: data <=row1[127:120];
            ROW1_1: data <=row1[119:112];
            ROW1_2: data <=row1[111:104];
            ROW1_3: data <=row1[103: 96];
            ROW1_4: data <=row1[ 95: 88];
            ROW1_5: data <=row1[ 87: 80];
            ROW1_6: data <=row1[ 79: 72];
            ROW1_7: data <=row1[ 71: 64];
            ROW1_8: data <=row1[ 63: 56];
            ROW1_9: data <=row1[ 55: 48];
            ROW1_A: data <=row1[ 47: 40];
            ROW1_B: data <=row1[ 39: 32];
            ROW1_C: data <=row1[ 31: 24];
            ROW1_D: data <=row1[ 23: 16];
            ROW1_E: data <=row1[ 15:  8];
            ROW1_F: data <=row1[  7:  0];
            ROW2_ADDR: data <=8'hc0;//8'b1100_0000,设置DDRAM地址:40H->2-1,第二行第一位
            ROW2_0: data <=row2[127:120];
            ROW2_1: data <=row2[119:112];
            ROW2_2: data <=row2[111:104];
            ROW2_3: data <=row2[103: 96];
            ROW2_4: data <=row2[ 95: 88];
            ROW2_5: data <=row2[ 87: 80];
            ROW2_6: data <=row2[ 79: 72];
            ROW2_7: data <=row2[ 71: 64];
            ROW2_8: data <=row2[ 63: 56];
            ROW2_9: data <=row2[ 55: 48];
            ROW2_A: data <=row2[ 47: 40];
            ROW2_B: data <=row2[ 39: 32];
            ROW2_C: data <=row2[ 31: 24];
            ROW2_D: data <=row2[ 23: 16];
            ROW2_E: data <=row2[ 15:  8];
            ROW2_F: data <=row2[  7:  0];
        endcase
    else
        data <= data;

always @(posedge clk)
     //if(count<25'd128)
		    begin
			 case(sw)
			 2'b00: r2<="         low pitch   ";
			 2'b11: r2<="          high pitch  ";
			 default:r2<="               middle pitch";
			 endcase
		
			 case(btn)//8'd0
			 7'b1000_000:begin
			 r1<="      DO     ";
			 end
			 7'b0100_000:begin
			 r1<="      RI     ";
			 end
			 7'b0010_000:begin
			 r1<="      MI     ";
			 end
			 7'b0001_000:begin
			 r1<="      FA     ";
			 end
			 7'b0000_100:begin
			 r1<="      SO     ";
			 end
			 7'b0000_010:begin
			 r1<="      LA     ";
			 end
			 7'b0000_001:begin
			 r1<="      XI     ";
			 end
			 default:     begin
			 r1<="                ";
			 end
		    endcase
			 end
endmodule
