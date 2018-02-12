module mac8x8
(
    input[7:0] a, b, 
    input clk, clr,
    output[31:0] acc
);
    wire[15:0] c;
    reg[31:0] acc_reg;

    initial
    begin
        acc_reg = 32'b0;
		  
    end
	 
    mul8x8 mul(a, b, c);

    always @(posedge clk)
    begin
        if(clr == 1'b1)
            acc_reg = 32'b0;
        else
            acc_reg = acc_reg + c;
    end

    assign acc = acc_reg;
endmodule


module mul8x8
(
    input[7:0] a,b,
    output[15:0] c
);
    wire[7:0] q0, q1, q2, q3, add0_0, temp0;
    wire[11:0] temp1, temp2, temp3, add0_1, add1_0;

    mul4x4 mac0(a[3:0],b[3:0],q0);
    mul4x4 mac1(a[7:4],b[3:0],q1);
    mul4x4 mac2(a[3:0],b[7:4],q2);
    mul4x4 mac3(a[7:4],b[7:4],q3);

    assign temp0 ={4'b0,q0[7:4]};
    adder8x8 adder0_0(q1,temp0,add0_0);

    assign temp1 ={4'b0,q2};
    assign temp2 ={q3,4'b0};
    adder12x12 adder0_1(temp1,temp2,add0_1);

    assign temp3={4'b0,add0_0};
    adder12x12 adder1_0(temp3,add0_1,add1_0);

    assign c[3:0]=q0[3:0];
    assign c[15:4]=add1_0;
endmodule


module mul4x4
(
    input[3:0] a,b,
    output[7:0] c
);
    wire[3:0] q0, q1, q2, q3, add0_0, temp0;
    wire[5:0] temp1, temp2, temp3, add0_1, add1_0;

    mul2x2 z0(a[1:0],b[1:0],q0);
    mul2x2 z1(a[3:2],b[1:0],q1);
    mul2x2 z2(a[1:0],b[3:2],q2);
    mul2x2 z3(a[3:2],b[3:2],q3);

    assign temp0 ={2'b0,q0[3:2]};
    adder4x4 adder0_0(q1,temp0,add0_0);

    assign temp1 ={2'b0,q2};
    assign temp2 ={q3,2'b0};
    adder6x6 adder0_1(temp1,temp2,add0_1);

    assign temp3={2'b0,add0_0};
    adder6x6 adder1_0(temp3,add0_1,add1_0);

    assign c[1:0]=q0[1:0];
    assign c[7:2]=add1_0;
endmodule

module mul2x2
(
    input[1:0] a,b,
    output[3:0] c
);
    wire[3:0] temp;

    assign c[0] = a[0]&b[0];
    assign temp[0] = a[1]&b[0];
    assign temp[1] = a[0]&b[1];
    assign temp[2] = a[1]&b[1];

    hadder2x2 adder1(temp[0], temp[1], c[1], temp[3]);
    hadder2x2 adder2(temp[2], temp[3], c[2], c[3]);
endmodule


module adder12x12 
(
    input[11:0] a, b, 
    output[11:0] s
);
    wire [11:0] c_wire;

    bitsum sum0(a[0], b[0], s[0], {1'b0}, c_wire[0]);
    bitsum sum1(a[1], b[1], s[1], c_wire[0], c_wire[1]);    
    bitsum sum2(a[2], b[2], s[2], c_wire[1], c_wire[2]);
    bitsum sum3(a[3], b[3], s[3], c_wire[2], c_wire[3]);
    bitsum sum4(a[4], b[4], s[4], c_wire[3], c_wire[4]);
    bitsum sum5(a[5], b[5], s[5], c_wire[4], c_wire[5]);
    bitsum sum6(a[6], b[6], s[6], c_wire[5], c_wire[6]);
    bitsum sum7(a[7], b[7], s[7], c_wire[6], c_wire[7]);
    bitsum sum8(a[8], b[8], s[8], c_wire[7], c_wire[8]);
    bitsum sum9(a[9], b[9], s[9], c_wire[8], c_wire[9]);
    bitsum sum10(a[10], b[10], s[10], c_wire[9], c_wire[10]);
    bitsum sum11(a[11], b[11], s[11], c_wire[10], c_wire[11]);
endmodule


module adder8x8 
(
    input[7:0] a, b, 
    output[7:0] s
);
    wire [7:0] c_wire;

    bitsum sum0(a[0], b[0], s[0], {1'b0}, c_wire[0]);
    bitsum sum1(a[1], b[1], s[1], c_wire[0], c_wire[1]);    
    bitsum sum2(a[2], b[2], s[2], c_wire[1], c_wire[2]);
    bitsum sum3(a[3], b[3], s[3], c_wire[2], c_wire[3]);
    bitsum sum4(a[4], b[4], s[4], c_wire[3], c_wire[4]);
    bitsum sum5(a[5], b[5], s[5], c_wire[4], c_wire[5]);
    bitsum sum6(a[6], b[6], s[6], c_wire[5], c_wire[6]);
    bitsum sum7(a[7], b[7], s[7], c_wire[6], c_wire[7]);
endmodule


module adder6x6 
(
    input[5:0] a, b, 
    output[5:0] s
);
    wire [5:0] c_wire;

    bitsum sum0(a[0], b[0], s[0], {1'b0}, c_wire[0]);
    bitsum sum1(a[1], b[1], s[1], c_wire[0], c_wire[1]);    
    bitsum sum2(a[2], b[2], s[2], c_wire[1], c_wire[2]);
    bitsum sum3(a[3], b[3], s[3], c_wire[2], c_wire[3]);
    bitsum sum4(a[4], b[4], s[4], c_wire[3], c_wire[4]);
    bitsum sum5(a[5], b[5], s[5], c_wire[4], c_wire[5]);
endmodule


module adder4x4 
(
    input[3:0] a, b, 
    output[3:0] s
);
    wire [3:0] c_wire;

    bitsum sum0(a[0], b[0], s[0], {1'b0}, c_wire[0]);
    bitsum sum1(a[1], b[1], s[1], c_wire[0], c_wire[1]);    
    bitsum sum2(a[2], b[2], s[2], c_wire[1], c_wire[2]);
    bitsum sum3(a[3], b[3], s[3], c_wire[2], c_wire[3]);
endmodule
 
module bitsum (A, B, S, Cin, Cout);
    input A, B, Cin;
    output S, Cout;
    
    wire A, B, S, Res;
    wire c1, c2, Cin, Cout;
        
    xor(Res, A, B);
    and(c1, A, B);
    xor(S, Cin, Res);
    and(c2, Cin, Res);
    or(Cout, c1, c2);
endmodule

module hadder2x2
(
    input a,b,
    output s, c
);
    assign s = a^b;
    assign c = a&b;
endmodule
