`timescale 1ns/1ps

module tb_wave;

    reg clk;
    reg reset;
    reg [31:0] frequency_step;
    reg [1:0] wave_type;
    wire [7:0] wave_out;

    wave_generator_core #(
        .USE_CORDIC(1) 
    ) uut (
        .clk(clk),
        .reset(reset),
        .frequency_step(frequency_step),
        .wave_type(wave_type),
        .wave_out(wave_out)
    );

    // Tạo xung clock 50MHz (Chu kỳ 20ns)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Kịch bản mô phỏng
    initial begin
        // Khởi tạo giá trị ban đầu
        reset = 1;
        wave_type = 2'b00;
        
        // Thiết lập bước nhảy tần số (frequency_step)
        frequency_step = 32'd85899345; 

        // Nhả reset sau 50ns
        #50 reset = 0;

        // 1. Test Sóng Vuông (wave_type = 00)
        $display("Testing Square Wave...");
        wave_type = 2'b00;
        #2000; 

        // 2. Test Sóng Tam Giác (wave_type = 01)
        $display("Testing Triangle Wave...");
        wave_type = 2'b01;
        #2000;

        // 3. Test Sóng Sin (wave_type = 10)
        $display("Testing Sine Wave...");
        wave_type = 2'b10;
        #2000;

        // 4. Test Sóng Cos (wave_type = 11)
        $display("Testing Cosine Wave...");
        wave_type = 2'b11;
        #2000;

        // Kết thúc mô phỏng
        $display("Simulation Finished.");
        $stop;
    end

endmodule