module manager(input wire [7:0] interrupt_in, compare_request, priority_interrupt,
               input wire s_return_intr,
               output wire [7:0] attention_interrupt, interrupt_request,
               output wire s_stop_opcode);

wire [7:0] min_priority, min_interrupt_request, unique_interrupt;

assign interrupt_request = (s_return_intr ? ((~priority_interrupt & compare_request) | interrupt_in) : (interrupt_in | compare_request));
assign unique_interrupt = ((priority_interrupt == 8'b0) ? (min_interrupt_request) : ((min_interrupt_request < min_priority) ? (min_interrupt_request | priority_interrupt) : priority_interrupt));
assign attention_interrupt = (s_return_intr ? (unique_interrupt | priority_interrupt) : unique_interrupt);
assign min_priority = (-priority_interrupt & priority_interrupt);
assign min_interrupt_request = (-interrupt_request & interrupt_request);
assign s_stop_opcode = ((priority_interrupt == 8'b0) | (min_interrupt_request < min_priority)) ? 1'b1 : 1'b0;


