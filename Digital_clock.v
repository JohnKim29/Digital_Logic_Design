`timescale 1ns / 1ps

module digital_clock(
    output reg [7:0] seg_out,
    output reg [3:0] seg_digit,
    input clk,
    input reset
    );
		
	reg [1:0] state , next_state;
	integer state_count;
	reg state_sel;
    parameter s0 = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;
    parameter s3 = 2'b11;
	
	integer count;
	integer sec;
	integer min01;
	integer min10;
	integer hour01;
	integer hour10;
	integer mode;
 
 
	 always@(posedge clk , negedge reset)begin
			if(!reset)begin
				state_count <= 0;
				state_sel <= 0;
			end
			
			else begin
				if (state_count <2000000)begin
					state_count <= state_count + 1 ;
					state_sel <= 0;

				end
				
				else begin
					state_count <= 0;
					state_sel <= 1;
				end
			end
				
  end
		
    always@(posedge clk, negedge reset)
    begin
        if(!reset)
            state <= s0;
        else
            state <= next_state;
    end
   

	always@(posedge state_sel)
	begin
		case(state)
		s0:begin
			next_state<=s1;
		end
		s1:begin
			next_state<=s2;
		end
		s2:begin
			next_state<=s3;
		end
		s3:begin				
			next_state<=s0;
		end
		default:begin
			next_state<=s0;
		end
		endcase
	end
	

	always@(posedge clk, negedge reset)begin
        if(!reset)begin
            count<=0;
			sec <= 0;
			min01<=0;
			min10<=0;
			hour01<=0;	
			hour10<=0;
        end
		
		
        else begin
            if(count < 999999999)
				count <= count +1;
			else begin
				count <= 0;
                if(sec < 59)
					sec <= sec +1;
                else begin
					sec <= 0;
					min01 <= min01 +1 ;
				end
            end
			
			if(min01 > 9)begin
				min01 <= 0;
				min10 <= min10 + 1;
			end
			else
				;
			
			if(min10 > 5)begin
				min10 <= 0;
				hour01 <= hour01 +1;
			end
			
			else
				;
				
			
			if(hour01 > 3 && hour10 == 2)begin
				hour01 <= 0;
				hour10 <= 0;
			end
			
			else if(hour01 > 9) begin
				hour01 <= 0;
				hour10 <= hour10 + 1;
			end	
			
			else
				;
					
			
		end
	end
	
	always@(posedge clk, negedge reset)begin
		if(!reset)begin
            seg_out <= 8'b1111_1100;
            seg_digit <= 4'b1110;
        end
		else begin
			
			case(state)
			s0:begin
				seg_digit <= 4'b1110;
				mode <= min01;
			end
			s1:begin
				seg_digit <= 4'b1101;
				mode <= min10;
			end
			s2:begin
				seg_digit <= 4'b1011;
				mode <= hour01;
			end
			s3:begin
				seg_digit <= 4'b0111;
				mode <= hour10;
			end
			endcase
			
			
			case(mode)
			0:seg_out[7:0] <= 8'b1111_1100;
			1:seg_out[7:0] <= 8'b0110_0000;
			2:seg_out[7:0] <= 8'b1101_1010;
			3:seg_out[7:0] <= 8'b1111_0010;
			4:seg_out[7:0] <= 8'b0110_0110;
			5:seg_out[7:0] <= 8'b1011_0110;
			6:seg_out[7:0] <= 8'b1011_1110;
			7:seg_out[7:0] <= 8'b1110_0000;
			8:seg_out[7:0] <= 8'b1111_1110;
			9:seg_out[7:0] <= 8'b1110_0110;
			default : seg_out[7:0] <= 8'b1111_1100;
			endcase
		end
	end
endmodule
