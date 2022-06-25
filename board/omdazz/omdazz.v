
/*
 * Copyright(c) 2020 Petr Krasnoshchekov
 *                   Black_Storm
 */

module omdazz
(
    input         clk,
    input         reset_n,
    input  [ 3:0] key_sw,
    output [ 3:0] led,
    output [ 7:0] hex,
    output [ 3:0] digit,
    output        buzzer
);
    // wires & inputs
    wire          clkCpu;
    wire          clkIn     =  clk;
    wire          rst_n     =  key_sw[0]; //  s4
    wire          clkEnable =  key_sw[1]; //  s3
    wire [  3:0 ] clkDivide =  4'b1000;
    wire [  4:0 ] regAddr   =  key_sw[2] ? 5'h0 : 5'ha; //  s2
    wire [ 31:0 ] regData;

    //cores
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .clkDivide  ( clkDivide ),
        .clkEnable  ( clkEnable ),
        .clk        ( clkCpu    ),
        .regAddr    ( regAddr   ),
        .regData    ( regData   )
    );

    //outputs
    assign led[0]    = ~clkCpu;
    assign led[3:1] = ~regData[2:0];

    //hex out
    wire [ 31:0 ] h7segment = regData;
    wire clkHex;

    sm_clk_divider hex_clk_divider
    (
        .clkIn   ( clkIn  ),
        .rst_n   ( rst_n  ),
        .divide  ( 4'b0   ),
        .enable  ( 1'b1   ),
        .clkOut  ( clkHex )
    );

    wire [ 7:0] anodes;
    assign digit = anodes [ 3:0];

    sm_hex_display_8 sm_hex_display_8
    (
        .clock          ( clkHex     ),
        .resetn         ( rst_n      ),
        .number         ( h7segment  ),
        .seven_segments ( hex[6:0]   ),
        .dot            ( hex[7]     ),
        .anodes         ( anodes     )
    );

    assign buzzer = 1'b1;

endmodule
