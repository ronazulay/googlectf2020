module check(
    input clk,

    input [6:0] data,
    output wire open_safe
);

wire [1:0] my;
assign my = 2'b10;

reg [55:0] test;
reg [6:0] memory [7:0];
reg [2:0] idx = 0;

wire [55:0] magic = {
    {memory[0], memory[5]},
    {memory[6], memory[2]},
    {memory[4], memory[3]},
    {memory[7], memory[1]}
};

wire [55:0] kittens = { magic[9:0],  magic[41:22], magic[21:10], magic[55:42] };
assign open_safe = kittens == 56'd3008192072309708;
assign test = 56'd3008192072309708;
  
always_ff @(posedge clk) begin
$display("my = %b\n", my);
    	$display("idx = %d\n", idx);

     memory[idx] <= data;
     idx <= idx + 5;

    $display("memory = %x", memory[0]);
    $display("memory = %b", memory[0]);
    $display("memory = %x", memory[1]);
    $display("memory = %b", memory[1]);
    $display("memory = %x", memory[2]);
    $display("memory = %b", memory[2]);
    $display("memory = %x", memory[3]);
    $display("memory = %b", memory[3]);
    $display("memory = %x", memory[4]);
    $display("memory = %b", memory[4]);
    $display("memory = %x", memory[5]);
    $display("memory = %b", memory[5]);
    $display("memory = %x", memory[6]);
    $display("memory = %b", memory[6]);
    $display("memory = %x", memory[7]);
    $display("memory = %b", memory[7]);
    $display("");

    $display("magic        = %b", magic);
    $display("magic_target = %b", 56'b00001010101111100010111011111110111101001001101111001100);
    $display("kittens        = %b", kittens);
    $display("kittens_target = %b", 56'd3008192072309708);
    $display("");

    $display("test = %b", test);
end

endmodule


