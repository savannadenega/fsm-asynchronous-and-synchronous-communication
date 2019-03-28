`timescale 1ns / 1ps

`include "cpu.v"
`include "peripheral.v"


module testbench;

  	// Inputs
	reg cpuClock_testBench, perClock_testBench, reset_testBench;

	wire [0:0] SEND_testBench;
	wire [31:0] DATA_testBench;

	// CPU's Unit Under Test (UUT)
	fsmCPU uutCPU(
		.clk_cpu(cpuClock_testBench),
		.rst_cpu(reset_testBench),
		.outDATA_cpu(DATA_testBench),
		.outSEND_cpu(SEND_testBench)
	);

	// Peripheral's Unit Under Test (UUT)
	fsmPeripheral uutPeripheral(
		.SEND_per(SEND_testBench),
		.clk_per(perClock_testBench),
		.rst_per(reset_testBench),
    .inputData_per(DATA_testBench)
	);

initial begin
	$dumpfile("dump.vcd");
	$dumpvars;

	// Initialize Inputs
	cpuClock_testBench = 0;
	perClock_testBench = 0;
	reset_testBench = 1;

	// Wait 100 ns for global reset to finish
	#50;
	reset_testBench = 0;

  	#100;

	$finish;
end

// Diffeence between clocks cpu and peripheral
always #5 perClock_testBench = !perClock_testBench;
always #5 cpuClock_testBench = !cpuClock_testBench;

endmodule
