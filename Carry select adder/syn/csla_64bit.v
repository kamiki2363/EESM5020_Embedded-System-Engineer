// =============================================================================
// Filename: csla_adder_64bit.v
// -----------------------------------------------------------------------------
// This file implements a Square Root 64-bit Carry-Select (CSL) adder.
// =============================================================================


// ----------------------------------------------------
// Part I: 64-bit CSL adder
// ----------------------------------------------------
// TODO: please implement 64-bit CSL adder here, with 4bit 1st-stage.

module csla_64bit(
	input wire	[63:0]	a,		// operator 1
	input wire	[63:0]	b, 		// operator 2
	input wire			cin, 	// carry in

	output wire	[63:0]	sum,	// sum
	output wire			cout	// carry out
);

wire [63:0] add1 ;
wire [63:0] add2 ;
assign add1 = a ;
assign add2 = b ; 

wire [8*2-1:0] mid_c ;  //guessed carries out
wire [127:0] mid_sum ;   // guessed sum
wire [8:0] selected_c ; // selected carries out
wire [64-1:0] selected_sum ; // selected sum


RCadder #(.N(4)) bit64_RCadder1_i1(.add1(add1[3:0]),.add2(add2[3:0]),.cin(cin),.result(selected_sum[3:0]),.cout(selected_c[0]));

RCadder #(.N(4)) bit64_RCadder1_i2(.add1(add1[7:4]),.add2(add2[7:4]),.cin(1'b0),.result(mid_sum[11:8]),.cout(mid_c[0]));
RCadder #(.N(4)) bit64_RCadder2_i2(.add1(add1[7:4]),.add2(add2[7:4]),.cin(1'b1),.result(mid_sum[15:12]),.cout(mid_c[1]));
bit5mux #(.N(4)) bit64_bit5mux_i2(.in0({mid_sum[11:8],mid_c[0]}),.in1({mid_sum[15:12],mid_c[1]}),.sel(selected_c[0]),.ou1({selected_sum[7:4],selected_c[1]}));

RCadder #(.N(5)) bit64_RCadder1_i3(.add1(add1[12:8]),.add2(add2[12:8]),.cin(1'b0),.result(mid_sum[20:16]),.cout(mid_c[2]));
RCadder #(.N(5)) bit64_RCadder2_i3(.add1(add1[12:8]),.add2(add2[12:8]),.cin(1'b1),.result(mid_sum[25:21]),.cout(mid_c[3]));
bit5mux #(.N(5)) bit64_bit5mux_i3(.in0({mid_sum[20:16],mid_c[2]}),.in1({mid_sum[25:21],mid_c[3]}),.sel(selected_c[1]),.ou1({selected_sum[12:8],selected_c[2]}));

RCadder #(.N(6)) bit64_RCadder1_i4(.add1(add1[18:13]),.add2(add2[18:13]),.cin(1'b0),.result(mid_sum[31:26]),.cout(mid_c[4]));
RCadder #(.N(6)) bit64_RCadder2_i4(.add1(add1[18:13]),.add2(add2[18:13]),.cin(1'b1),.result(mid_sum[37:32]),.cout(mid_c[5]));
bit5mux #(.N(6)) bit64_bit5mux_i4(.in0({mid_sum[31:26],mid_c[4]}),.in1({mid_sum[37:32],mid_c[5]}),.sel(selected_c[2]),.ou1({selected_sum[18:13],selected_c[3]}));

RCadder #(.N(7)) bit64_RCadder1_i5(.add1(add1[25:19]),.add2(add2[25:19]),.cin(1'b0),.result(mid_sum[44:38]),.cout(mid_c[6]));
RCadder #(.N(7)) bit64_RCadder2_i5(.add1(add1[25:19]),.add2(add2[25:19]),.cin(1'b1),.result(mid_sum[51:45]),.cout(mid_c[7]));
bit5mux #(.N(7)) bit64_bit5mux_i5(.in0({mid_sum[44:38],mid_c[6]}),.in1({mid_sum[51:45],mid_c[7]}),.sel(selected_c[3]),.ou1({selected_sum[25:19],selected_c[4]}));

RCadder #(.N(8)) bit64_RCadder1_i6(.add1(add1[33:26]),.add2(add2[33:26]),.cin(1'b0),.result(mid_sum[59:52]),.cout(mid_c[8]));
RCadder #(.N(8)) bit64_RCadder2_i6(.add1(add1[33:26]),.add2(add2[33:26]),.cin(1'b1),.result(mid_sum[67:60]),.cout(mid_c[9]));
bit5mux #(.N(8)) bit64_bit5mux_i6(.in0({mid_sum[59:52],mid_c[8]}),.in1({mid_sum[67:60],mid_c[9]}),.sel(selected_c[4]),.ou1({selected_sum[33:26],selected_c[5]}));

RCadder #(.N(9)) bit64_RCadder1_i7(.add1(add1[42:34]),.add2(add2[42:34]),.cin(1'b0),.result(mid_sum[76:68]),.cout(mid_c[10]));
RCadder #(.N(9)) bit64_RCadder2_i7(.add1(add1[42:34]),.add2(add2[42:34]),.cin(1'b1),.result(mid_sum[85:77]),.cout(mid_c[11]));
bit5mux #(.N(9)) bit64_bit5mux_i7(.in0({mid_sum[76:68],mid_c[10]}),.in1({mid_sum[85:77],mid_c[11]}),.sel(selected_c[5]),.ou1({selected_sum[42:34],selected_c[6]}));

RCadder #(.N(10)) bit64_RCadder1_i8(.add1(add1[52:43]),.add2(add2[52:43]),.cin(1'b0),.result(mid_sum[95:86]),.cout(mid_c[12]));
RCadder #(.N(10)) bit64_RCadder2_i8(.add1(add1[52:43]),.add2(add2[52:43]),.cin(1'b1),.result(mid_sum[105:96]),.cout(mid_c[13]));
bit5mux #(.N(10)) bit64_bit5mux_i8(.in0({mid_sum[95:86],mid_c[12]}),.in1({mid_sum[105:96],mid_c[13]}),.sel(selected_c[6]),.ou1({selected_sum[52:43],selected_c[7]}));

RCadder #(.N(11)) bit64_RCadder1_i9(.add1(add1[63:53]),.add2(add2[63:53]),.cin(1'b0),.result(mid_sum[116:106]),.cout(mid_c[14]));
RCadder #(.N(11)) bit64_RCadder2_i9(.add1(add1[63:53]),.add2(add2[63:53]),.cin(1'b1),.result(mid_sum[127:117]),.cout(mid_c[15]));
bit5mux #(.N(11)) bit64_bit5mux_i9(.in0({mid_sum[116:106],mid_c[14]}),.in1({mid_sum[127:117],mid_c[15]}),.sel(selected_c[7]),.ou1({selected_sum[63:53],selected_c[8]}));

assign cout = selected_c[8];
assign sum = selected_sum;

endmodule 
// ----------------------------------------------------


// ----------------------------------------------------
// Part II: 16-bit Square Root CSL adder
// ----------------------------------------------------
//module csla_16bit(
//	input wire	[15:0]	a,		// operator 1
//	input wire	[15:0]	b, 		// operator 2
//	input wire			cin, 	// carry in

//	output wire	[15:0]	sum,	// sum
//	output wire			cout	// carry out
//);
//wire [15:0] add1;
//wire [15:0] add2;
//assign a = add1;
//assign b = add2; 

//wire [4*2-1:0] mid_c;  //guessed carries out
//wire [31:0] mid_sum;   // guessed sum
//wire [4:0] selected_c; // selected carries out
//wire [16-1:0] selected_sum; // selected sum


//RCadder #(.N(2)) bit16_RCadder1_i1(.add1(add1[1:0]),.add2(add2[1:0]),.cin(cin),.result(mid_sum[1:0]),.cout(selected_c[0]));

//RCadder #(.N(2)) bit16_RCadder1_i2(.add1(add1[3:2]),.add2(add2[3:2]),.cin(1'b0),.result(mid_sum[5:4]),.cout(mid_c[0]));
//RCadder #(.N(2)) bit16_RCadder2_i2(.add1(add1[3:2]),.add2(add2[3:2]),.cin(1'b1),.result(mid_sum[7:6]),.cout(mid_c[1]));
//bit5mux #(.N(2)) bit16_bit5mux_i2(.in0({mid_sum[5:4],mid_c[0]}),.in1({mid_sum[7:6],mid_c[1]}),.sel(selected_c[0]),.ou1({selected_sum[3:2],selected_c[1]}));

//RCadder #(.N(3)) bit16_RCadder1_i3(.add1(add1[6:4]),.add2(add2[6:4]),.cin(1'b0),.result(mid_sum[10:8]),.cout(mid_c[2]));
//RCadder #(.N(3)) bit16_RCadder2_i3(.add1(add1[6:4]),.add2(add2[6:4]),.cin(1'b1),.result(mid_sum[13:11]),.cout(mid_c[3]));
//bit5mux #(.N(3)) bit16_bit5mux_i3(.in0({mid_sum[10:8],mid_c[2]}),.in1({mid_sum[13:11],mid_c[3]}),.sel(selected_c[1]),.ou1({selected_sum[6:4],selected_c[2]}));

//RCadder #(.N(4)) bit16_RCadder1_i4(.add1(add1[10:7]),.add2(add2[10:7]),.cin(1'b0),.result(mid_sum[17:14]),.cout(mid_c[4]));
//RCadder #(.N(4)) bit16_RCadder2_i4(.add1(add1[10:7]),.add2(add2[10:7]),.cin(1'b1),.result(mid_sum[21:18]),.cout(mid_c[5]));
//bit5mux #(.N(4)) bit16_bit5mux_i4(.in0({mid_sum[17:14],mid_c[4]}),.in1({mid_sum[21:18],mid_c[5]}),.sel(selected_c[2]),.ou1({selected_sum[10:7],selected_c[3]}));

//RCadder #(.N(5)) bit16_RCadder1_i5(.add1(add1[15:11]),.add2(add2[15:11]),.cin(1'b0),.result(mid_sum[26:22]),.cout(mid_c[6]));
//RCadder #(.N(5)) bit16_RCadder2_i5(.add1(add1[15:11]),.add2(add2[15:11]),.cin(1'b1),.result(mid_sum[31:27]),.cout(mid_c[7]));
//bit5mux #(.N(5)) bit16_bit5mux_i5(.in0({mid_sum[26:22],mid_c[6]}),.in1({mid_sum[31:27],mid_c[7]}),.sel(selected_c[3]),.ou1({selected_sum[15:11],selected_c[4]}));

//assign cout = selected_c[4];
//assign sum = selected_sum;

//endmodule

// ----------------------------------------------------
// Part III: N-bit Ripple Carry Adder by generator
// ----------------------------------------------------
module RCadder#(parameter N =3 ) (

  input wire  [N-1:0]         add1,     //adder1
  input wire  [N-1:0]         add2,      //adder2
  input wire cin,                       //carry input

  output wire  [N-1:0]         result,     //sum
  output wire              cout     //carry output
);

wire [N-1:0] p, g ; //internal variables
wire [N:0] c_mid; //carry
assign c_mid[0] = cin;
assign cout = c_mid[N];
assign p = add1^add2;
assign g = add1&add2;

genvar i;
generate

	for(i=0;i<N;i=i+1) begin: block
	bit1adder bit1adder_module(.g(g[i]),.p(p[i]),.cin(c_mid[i]),.sum(result[i]),.count(c_mid[i+1]));
	end
endgenerate



endmodule
// ----------------------------------------------------
// Part IV: N-bit multiplexer
// ----------------------------------------------------
module bit5mux#(parameter N =3) (
input wire [N:0] in1,in0, // 2-way inputs
input wire sel,             // select

output reg [N:0] ou1      //outputs
    );
always@(*) begin
case (sel)
	1'b0:ou1 = in0;
	1'b1:ou1 = in1;
endcase
end

endmodule
// ----------------------------------------------------
// Part V: 1-bit Full Adder
// ----------------------------------------------------
module bit1adder(
input wire g,  // generate
input wire p,  // propagate
input wire cin,  // carry in

output wire sum, // sum
output wire count // carry out
    );


assign sum	 = p^cin;
assign count = g|(cin&p);

endmodule
