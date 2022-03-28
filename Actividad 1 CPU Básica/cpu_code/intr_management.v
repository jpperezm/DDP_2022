module intr_manager(input wire [7:0] interrupt_in,
                    input wire clk, reset, s_return_intr,
                    output wire s_stop_opcode,
                    output wire [7:0] interrupt_out);

wire [7:0] interrupt_request_in, interrupt_request_out, attention_interrupt_in, priority_interrupt

manager gestor(interrupt_in, interrupt_request_out, priority_interrupt, s_return_intr, attention_interrupt_in, interrupt_request_in, s_stop_opcode);
registro #(8) request (clk, reset, interrupt_request_in, interrupt_request_out);
registro #(8) atencion (clk, reset, attention_interrupt_in, priority_interrupt);

