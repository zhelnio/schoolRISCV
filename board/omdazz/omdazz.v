
module omdazz
(
    input         clk,
    input         reset_n,
    input  [ 3:0] key_sw,
    output [ 3:0] led,
    output [ 7:0] abcdefgh,
    output [ 3:0] digit,
    output        buzzer
);
    // wires & inputs
    wire          clkCpu;
    wire          clkIn     =  clk;
    wire          rst_n     =  key_sw[0];
    wire          clkEnable =  key_sw[1];
    wire [  3:0 ] clkDevide =  4'b1000;
    wire [  4:0 ] regAddr   =  key_sw[2] ? 5'ha : 5'h0;
    wire [ 31:0 ] regData;

    //cores
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .clkDevide  ( clkDevide ),
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
        .devide  ( 4'b0   ),
        .enable  ( 1'b1   ),
        .clkOut  ( clkHex )
    );

    wire [31:0] data = 32'h76543210;
    wire [ 7:0] anodes;
    assign digit = anodes [ 3:0];

    wire [6:0] seven_segments;
    assign {abcdefgh[1],abcdefgh[2],abcdefgh[3],abcdefgh[4],abcdefgh[5],abcdefgh[6],abcdefgh[7]} = seven_segments;

    sm_hex_display_8 sm_hex_display_8
    (
        .clock          ( clkHex        ),
        .resetn         ( rst_n         ),
        .number         ( h7segment  ),
        .seven_segments ( seven_segments   ),
        .dot            ( abcdefgh[0]   ),
        .anodes         ( anodes        )
    );

    assign buzzer = 1'b1;

/*
module sm_hex_display_8
(
    input             clock,
    input             resetn,
    input      [31:0] number,

    output reg [ 6:0] seven_segments,
    output reg        dot,
    output reg [ 7:0] anodes
);
*/

endmodule
