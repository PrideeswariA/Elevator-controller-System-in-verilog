`timescale 1ns/1ps

module elevator_controller_tb;

reg clk;
reg rst;
reg [1:0] request_floor;

wire [1:0] current_floor;

elevator_controller DUT(
    .clk(clk),
    .rst(rst),
    .request_floor(request_floor),
    .current_floor(current_floor)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    request_floor = 0;

    #10 rst = 0;

    request_floor = 2'b11;
    #40;

    request_floor = 2'b01;
    #40;

    request_floor = 2'b10;
    #40;

    request_floor = 2'b00;
    #40;

    $finish;
end

initial
begin
    $monitor("Time=%0t Requested=%d Current=%d",
              $time,
              request_floor,
              current_floor);
end

endmodule
