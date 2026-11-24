// MISFIT-04 I3: una adquisicion por src (01, 10, 11) en el netlist final; VCD del nucleo. Las salidas del inversor de A y de B
// (s0_xa, s0_xb) suben 27,943 y 27,960 us despues de que la precarga se suelta (prea sube), los tiempos de tt 27 del contrato.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0; always #10 clk = ~clk;
  reg [7:0] ui = 0, uio = 0; reg xa = 0, xb = 0;
  wire [7:0] uo, uio_out, uio_oe;
  wire prea, preb, vbias, c1, duta, dutb, refa, refb, sa0b, sa1b, sa2b, sb0b, sb1b;
  misfit04_core dut (.ui_in(ui), .uo_out(uo), .uio_in(uio), .uio_out(uio_out), .uio_oe(uio_oe), .ena(1'b1), .clk(clk), .rst_n(rst_n),
    .s0_prea(prea), .s0_preb(preb), .s0_vbias(vbias), .s0_c1(c1), .s0_duta(duta), .s0_dutb(dutb), .s0_refa(refa), .s0_refb(refb),
    .s0_sa0b(sa0b), .s0_sa1b(sa1b), .s0_sa2b(sa2b), .s0_sb0b(sb0b), .s0_sb1b(sb1b), .s0_xa(xa), .s0_xb(xb));
  task wr(input [3:0] a, input [7:0] d);
    begin @(negedge clk); uio[3:0] = a; ui = d; repeat (2) @(negedge clk); uio[4] = 1; repeat (4) @(negedge clk); uio[4] = 0; repeat (4) @(negedge clk); end
  endtask
  integer s; reg [1:0] SRC [0:2];
  initial begin
    SRC[0] = 2'b01; SRC[1] = 2'b10; SRC[2] = 2'b11;
    $dumpfile("i3.vcd"); $dumpvars(0, tb.dut);
    repeat (4) @(negedge clk); rst_n = 1; repeat (4) @(negedge clk);
    wr(4'h1, 8'h03); wr(4'h2, 8'h00); wr(4'h4, 8'h01);
    for (s = 0; s < 3; s = s + 1) begin
      xa = 0; xb = 0; wr(4'h3, SRC[s]); wr(4'h6, 8'h01);
      @(posedge prea); $display("VENTANA src=%b inicio %0t", SRC[s], $time);
      fork begin #27943; xa = 1; $display("XA src=%b %0t", SRC[s], $time); end begin #27960; xb = 1; $display("XB src=%b %0t", SRC[s], $time); end join
      wait (uio_out[7] == 1'b0); $display("FIN src=%b %0t", SRC[s], $time);
      repeat (20) @(negedge clk);
    end
    $finish;
  end
endmodule
