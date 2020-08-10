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

//-----------------------------------------------------------------------------------------------
//game of life 16x16 toroid grid Solution

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q); 
//reg [255:0] q_mem;
//integer count = 0; //for 256 count
reg [3:0] sum = 0;   // sum of neighbours

always @(posedge clk) begin
    if (load) begin q <= data; end
    else begin
        for (integer count = 0 ; count < 256 ; count++) begin
        if (count == 0) begin
            sum = q[1] + q[15] + q[16] + q[17] + q[31] + q[240] + q[241] +  q[255]; 
               
        end else if (count == 15) begin
            sum = q[14] + q[16] + q[0] + q[31] + q[240] + q[254] + q[30]  + q[255];
            
        end else if (count == 240) begin
            sum = q[0] + q[1] + q[15] + q[239] + q[241] + q[224] + q[225] + q[255];
             
        end else if (count == 255) begin
            sum = q[0] + q[14] +  q[15] + q[224] + q[238] + q[240] + q[239] + q[254];
            
        end else if (count > 0 && count < 15) begin
            sum = q[count -1] + q[count +1] + q[count +16] + q[count +15] + q[count +17] + q[count + 240] + q[count +239] + q[count +241];

        end else if (count % 16 == 0) begin 
            sum = q[count -1] + q[count +1] + q[count +15] + q[count +16] + q[count +17] + q[count -15] + q[count -16] + q[count +31];
            
        end else if (count % 16 == 15)  begin
            sum = q[count -1] + q[count +1] + q[count +15] + q[count -15]  + q[count +16] + q[count -16] + q[count -17]  + q[count -31];
        
        end else if (count > 240 && count < 255) begin
            sum = q[count -1] + q[count +1] + q[count - 15] + q[count - 16] + q[count - 17] + q[count - 240] + q[count - 241] + q[count - 239];
            
        end else begin
            sum = q[count -1] + q[count +1] + q[count -15] + q[count -16]  + q[count -17] + q[count +15] + q[count +16] + q[count +17];
        end
        if ((sum == 0 || sum == 1) || (sum >= 4)) begin
         	q[count] <= 0;
    	end else if (sum == 3) begin
         	q[count] <= 1;
    	end
        //if (count <255) count <= count + 1; else count <= 0;     
    end
    end
end


    
endmodule
