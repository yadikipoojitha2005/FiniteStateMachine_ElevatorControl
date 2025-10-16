module tb;
reg clk,rst,ra,rb,rc,rd;
wire [1:0] floor;
lift TEST (clk,rst,ra,rb,rc,rd,floor);
always #5 clk=!clk;
initial begin
clk=0;ra=0;rb=0;rc=0;rd=0;
rst=1;
#2;
rst=0;
end
initial begin
repeat(5) @(posedge clk);
repeat(30)
begin
{ra,rb,rc,rd}=$random; @(posedge clk);
end
$finish;
end
endmodule
