module counter_mod10_p (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire count_in_flag,
    input wire [3:0] count_in,
    output reg [3:0] count,
    output reg tick
);
always @(posedge clk) begin
    if(reset)begin
        count <= 4'b0;
        tick <= 1'b0;
    end
    else begin
        tick <= 1'b0;
        if((count_in_flag) && (count_in <= 4'd9)) begin
            count <= count_in;
        end
        else begin
            if(enable) begin
                if(count == 4'd9) begin
                    count <= 4'b0;
                    tick <= 1'b1;
                end
                else begin
                    tick <= 1'b0;
                    count <= count + 1;
                end
            end
        end
    end
end
endmodule






