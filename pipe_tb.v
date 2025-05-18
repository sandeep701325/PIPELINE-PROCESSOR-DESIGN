module pipe_tb;

    // Inputs
    reg [3:0] RS_1;
    reg [3:0] RS_2;
    reg [3:0] RD;
    reg [7:0] addr;
    reg [1:0] func;
    reg clk_1;
    reg clk_2;

    // Outputs
    wire [15:0] z;
    integer k;

    // Instantiate the Unit Under Test (UUT)
    pipe uut (
        .RS_1(RS_1), 
        .RS_2(RS_2), 
        .RD(RD), 
        .z(z), 
        .addr(addr), 
        .func(func), 
        .clk_1(clk_1), 
        .clk_2(clk_2)
    );

    // Clock Generation
    initial begin
        clk_1 = 0;
        clk_2 = 0;
        repeat(20) begin
            #5 clk_1 = 1;
            #5 clk_1 = 0;
            #5 clk_2 = 1;
            #5 clk_2 = 0;
        end
    end

    // Initialize register bank values
    initial begin
        for(k = 0; k < 16; k = k + 1) begin
            uut.regbank[k] = k;  // Initialize each register to its index value
        end
    end

    // Stimulus Generation (Test cases)
    initial begin
        #5 
        RS_1 = 5; RS_2 = 3; RD = 1; func = 2'b00; addr = 125;  // Add 5 + 3 -> 8
        #20
        RS_1 = 6; RS_2 = 4; RD = 2; func = 2'b01; addr = 126;  // Sub 6 - 4 -> 2
        #20
        RS_1 = 7; RS_2 = 5; RD = 3; func = 2'b00; addr = 127;  // Add 7 + 5 -> 12
        #20
        RS_1 = 8; RS_2 = 6; RD = 4; func = 2'b01; addr = 128;  // Sub 8 - 6 -> 2
        #20
        RS_1 = 9; RS_2 = 7; RD = 5; func = 2'b00; addr = 129;  // Add 9 + 7 -> 16
    end

    // Monitor the outputs
    initial begin
        $monitor("Time=%0t, rs1=%d, rs2=%d, rd=%d, func=%b, addr=%d, z=%d", 
                 $time, RS_1, RS_2, RD, func, addr, z);
    end

endmodule
