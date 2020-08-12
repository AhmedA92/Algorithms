//-----------------------------------------------------------------------------------------------
//game of life 16x16 toroid grid Solution
//https://hdlbits.01xz.net/wiki/Conwaylife

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
