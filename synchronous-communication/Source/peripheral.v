module fsmPeripheral (SEND_per, clk_per, rst_per, inputData_per);

	input SEND_per;
  	input clk_per, rst_per;
  	input [31:0] inputData_per;

	/*
		Peripheral states:
		0 - not receiving
		1 - receiving
	*/
	reg currentState_per, nextState_per;
  	reg [31:0] data_per;


	// Current State - Initial begin
	always @ (posedge clk_per)
	begin
		if (rst_per == 1)
			currentState_per <= 0;
		else
			currentState_per <= nextState_per;
	end

	// Next State
	always @ (*)
	begin
		case ({currentState_per})
			0, 1:
				if (SEND_per == 1)
					nextState_per = 1;
				else
					nextState_per = 0;
		endcase
	end

	// Outputs
	always @ (*)
	begin
      if (currentState_per == 1)
      	data_per = inputData_per;
	end

endmodule
