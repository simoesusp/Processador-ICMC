// 50MHz to 1Mhz

module clk_div2(in_clk, out_clk);

input in_clk;
output out_clk;

reg out_clk;
reg [31:0] count;
parameter threshold = 50;

always @(posedge in_clk) begin
	count <= count + 1;
	if(count == threshold) begin
		out_clk <= 1;
		count <= 0;
	end
	else begin
		out_clk <= 0;
	end
	// edge_det <= count[26];
end

// assign out_clk = !edge_det & count[26];

endmodule