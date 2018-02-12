`timescale 1 ns/ 10 ps
module pwm
(
	input[3:0] duty,
	input clk,
	output out
);

	reg[3:0] counter;
	reg out_reg;

	initial
	begin
		counter = 4'b0000;
	end

	always@(posedge clk)
	begin
		if (counter == 4'b0)
			counter = counter + 4'b1;
		if(counter <= duty) 
			out_reg = 1'b1;
		else 
			out_reg = 1'b0;
		counter = counter + 4'b1;
	end

	assign out = out_reg;
endmodule
