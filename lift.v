module lift (clk,rst,ra,rb,rc,rd,floor);
input clk,rst,ra,rb,rc,rd;
output reg [1:0] floor=0 ;
`ifdef SINGLESTATEMACHINE
enum {A,BU,BD,CU,CD,D} state;
`ifdef M1
assign a2bu=!ra && rb;
assign a2cu= !ra && !rb && rc;
assign a2d= !ra && !rb && !rc &&rd;

assign bu2a= ra && !rb &&!rc &&!rd;
assign bu2cu = !rb && rc;
assign bu2d =  !rb && !rc &&  rd;

assign bd2a=ra &&!rb;
assign bd2cu=!ra && !rb && rc;
assign bd2d= !rb && !rc && rd;

assign cu2a = ra && !rb && !rc && !rd;
assign cu2bd =rb && !rc && !rd;
assign cu2d = !rc && rd;

assign cd2a =ra && !rb && !rc;
assign cd2bd = rb && !rc;
assign cd2d =!ra && !rb && !rc && rd;

assign d2a =ra && !rb &&!rc && !rd;
assign d2bd =  rb && !rc && !rd;
assign d2cd =rc && !rd;
always @(negedge clk or posedge rst)
begin
if (rst) state<=A;
else 
case (state)
A : if(ra) state<=A;
	else if (a2bu) state<=BU;
	else if (a2cu) state<=CU;
	else if (a2d) state<=D;
	else state<=state;
BU : if(rb) state<=BU;
    else if (bu2a) state<=A;
	else if (bu2cu) state<=CU;
	else if (bu2d) state<=D;
	else state<=state;
BD: if(rb) state<=BD;
    else if (bd2a) state<=A;
	else if (bd2cu) state<=CU;
	else if (bd2d) state<=D;
	else state<=state;
CD : if(rc) state<=CD;
	 else if (cd2a) state<=A;
	 else if (cd2bd) state<=BD;
	 else if (cd2d) state<=D;
	 else state<=state;
CU : if(rc) state<=CU;
	 else if (cu2a) state<=A;
	 else if (cu2bd) state<=BD;
	 else if (cu2d) state<=D;
	 else state<=state;
D : if (rd) state<=D;
    else if (d2a) state<=A;
	else if (d2cd) state<=CD;
	else if (d2bd) state<=BD;
	else state<=state;
endcase
end
`endif

`ifdef M2 
always @ (negedge clk or posedge rst)
begin
if(rst) state<=A;
else
case (state)
A : casex({ra,rb,rc,rd})
    4'b1xxx: state<=A;
	4'b01xx: state<=BU;
	4'b001x: state<=CU;
	4'b0001: state<=D;
	4'b0000: state<=state;
	endcase
BU : casex({rb,rc,rd,ra})
    4'b1xxx: state<=BU;
	4'b01xx: state<=CU;
	4'b001x: state<=D;
	4'b0001: state<=A;
	4'b0000: state<=state;
	endcase
BD : casex({rb,ra,rc,rd})
    4'b1xxx: state<=BD;
	4'b01xx: state<=A;
	4'b001x: state<=CU;
	4'b0001: state<=D;
	4'b0000: state<=state;
	endcase
CU : casex({rc,rd,rb,ra})
    4'b1xxx: state<=CU;
	4'b01xx: state<=D;
	4'b001x: state<=BD;
	4'b0001: state<=A;
	4'b0000: state<=state;
	4'b0000: state<=state;
	endcase
CD : casex({rc,rb,ra,rd})
    4'b1xxx: state<=CD;
	4'b01xx: state<=BD;
	4'b001x: state<=A;
	4'b0001: state<=D;
	4'b0000: state<=state;
	endcase
D : casex({rd,rc,rb,ra})
    4'b1xxx: state<=D;
	4'b01xx: state<=CD;
	4'b001x: state<=BD;
	4'b0001: state<=A;
	4'b0000: state<=state;
	endcase
endcase
end
`endif
`ifdef M3 
always @(negedge clk or posedge rst)
begin
if (rst) state<=A;
else
case(state)
A: case(1)
   ra:state<=A;
   rb:state<=BU;
   rc:state<=CU;
   rd:state<=D;
   endcase
BU: case(1)
	rb:state<=BU;
	rc:state<=CU;
	rd:state<=D;
	ra:state<=A;
	endcase
CU: case(1)
	rc:state<=CU;
	rd:state<=D;
	rb:state<=BD;
	ra:state<=A;
	endcase
CD: case(1)
	rc:state<=CD;
	rb:state<=BD;
	ra:state<=A;
	rd:state<=D;
	endcase
BD :case(1)
	rb:state<=BD;
	ra:state<=A;
	rc:state<=CU;
	rd:state<=D;
	endcase
D: case(1)
	rd:state<=D;
	rc:state<=CD;
	rb:state<=BD;
	ra:state<=A;
	endcase
endcase
end
`endif
always @*
begin 
case(state)
A: floor=0;
BU,BD: floor=1;
CU,CD :floor=2;
D: floor=3;
endcase
end
`endif
`ifdef TWOSTATEMACHINES
enum {A,B,C,D} state;
enum {UP,DOWN} dir;
`include "twostate.txt"
always @*
begin
case(state)
A: floor=0;
B: floor=1;
C: floor=2;
D: floor=3;
endcase
end
`endif
endmodule




    



	


