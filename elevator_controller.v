module elevator_controller(
    input clk,
    input rst,
    input [1:0] request_floor,
    output reg [1:0] current_floor
);

always @(posedge clk or posedge rst)
begin
    if(rst)
        current_floor <= 2'b00;
    else
    begin
        if(request_floor > current_floor)
            current_floor <= current_floor + 1;

        else if(request_floor < current_floor)
            current_floor <= current_floor - 1;

        else
            current_floor <= current_floor;
    end
end

endmodule
