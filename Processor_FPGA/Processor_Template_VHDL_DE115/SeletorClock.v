module SeletorClock(
input wire clock, 
input wire reset, 
input wire sel_1hz, 
input wire clock_1hz, 
input wire sel_10hz, 
input wire clock_10hz, 
input wire sel_100hz, 
input wire clock_100hz,
input wire sel_1khz, 
input wire clock_1khz, 
input wire sel_10khz, 
input wire clock_10khz,
input wire sel_100khz, 
input wire clock_100khz,
input wire sel_1mhz, 
input wire clock_1mhz,
input wire sel_12mhz,
input wire clock_12mhz,
input wire sel_25mhz,
output reg clock_saida
);

always @ (posedge clock or posedge reset)
begin
	if(reset) begin
		clock_saida <= 1'b0;
	end	
	else if( (sel_1hz == 1'b1) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0) ) begin
		clock_saida <= clock_1hz;
	end	
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b1) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0) ) begin
		clock_saida <= clock_10hz;
	end	
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b1) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0)) begin
		clock_saida <= clock_100hz;
	end
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b1) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0)) begin
		clock_saida <= clock_1khz;
	end
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b1) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0)) begin
		clock_saida <= clock_10khz;	
	end	
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b1) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0)) begin
		clock_saida <= clock_100khz;	
	end
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b1) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b0)) begin
		clock_saida <= clock_1mhz;		
	end
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b1) && (sel_25mhz == 1'b0)) begin
		clock_saida <= clock_12mhz;
	end
	else if( (sel_1hz == 1'b0) && (sel_10hz == 1'b0) && (sel_100hz == 1'b0) && (sel_1khz == 1'b0) && (sel_10khz == 1'b0) && (sel_100khz == 1'b0) && (sel_1mhz == 1'b0) && (sel_12mhz == 1'b0) && (sel_25mhz == 1'b1)) begin
		clock_saida <= clock;		
	end	
	else begin
		clock_saida <= 1'b0;
	end	
end

endmodule 