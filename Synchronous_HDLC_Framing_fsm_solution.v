//Moore FSM Solution for Synchronous HDLC Framing 
//The problem description in the following link
//https://hdlbits.01xz.net/wiki/Fsm_hdlc

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output  reg disc,
    output  reg flag,
    output  reg err);

        
reg [3:0]state, next_state;
parameter none = 4'b0000;
parameter one = 4'b0001;
parameter two = 4'b0010;
parameter three = 4'b0011;
parameter four = 4'b0100;
parameter five = 4'b0101;
parameter six = 4'b0110;
parameter discard = 4'b0111;
parameter flag_S = 4'b1000;
parameter error = 4'b1001;

always @(posedge clk) begin
        if(reset) begin state <= none;  end 
        else begin
            state <= next_state;
        end
end

always @(state, in)begin
    case(state)
        none: if (in == 1'b0) next_state <= none; else next_state <= one;
        one: if (in == 1'b0) next_state <= none; else next_state <= two;
        two: if (in == 1'b0) next_state <= none; else next_state <= three;
        three: if (in == 1'b0) next_state <= none; else next_state <= four;
        four: if (in == 1'b0) next_state <= none; else next_state <= five;
        five: if (in == 1'b0) next_state <= discard; else next_state <= six;
        discard: if (in == 1'b0) next_state <= none; else next_state <= one;
        six: if (in == 1'b0) next_state <= flag_S; else next_state <= error;
        flag_S: if (in == 1'b0) next_state <= none; else next_state <= one;
        error: if (in == 1'b0) next_state <= none; else next_state <= error;
    
        default: next_state <= none;
    endcase
end
    
always @(state) begin
    case(state)
        none: begin flag <= 0;err <= 0; disc <= 0; end
        one: begin flag <= 0;err <= 0; disc <= 0; end
        two: begin flag <= 0;err <= 0; disc <= 0; end
        three: begin flag <= 0;err <= 0; disc <= 0; end
        four: begin flag <= 0;err <= 0; disc <= 0; end
        five: begin flag <= 0;err <= 0; disc <= 0; end
        six: begin flag <= 0;err <= 0; disc <= 0; end
        discard: begin flag <= 0;err <= 0; disc <= 1; end
        flag_S: begin flag <= 1;err <= 0; disc <= 0; end
        error: begin flag <= 0;err <= 1; disc <= 0; end
  
        default: begin flag <= 0;err <= 0; disc <= 0; end
    endcase  
end
endmodule
