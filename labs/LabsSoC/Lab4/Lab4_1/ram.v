`timescale 1 ns/ 10 ps
module ram
(
	input clk, we,
	input [7:0] data,
	input [3:0] addr,
	output [7:0] q
);
	reg [7:0] ram[15:0];
	reg [3:0] addr_reg;

	always @ (clk)
	begin
		if (we)
			ram[addr] = data;
		addr_reg = addr;
	end
	assign q = ram[addr_reg];
endmodule
