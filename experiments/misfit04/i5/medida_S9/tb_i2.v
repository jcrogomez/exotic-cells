// MISFIT-04 I2 (enmienda 1, A1). Tabla E7 escrita a mano desde el texto de MISFIT-03 enmienda 1 (E2, E3, E8), no desde el RTL:
//  en = 0: VBIAS = C1 = 0, precarga encendida (PRE_N bajo), todos los interruptores abiertos (SxxB alto, DUT y REF bajos).
//  en = 1: VBIAS = C1 = 1; PRE_N bajo solo con pre = 1; DUT cerrado solo en src = 01; REF cerrado en src = 10 y 11;
//          src = 11 cierra S0 y S1 en A y en B; src = 10 cierra S1 y S2 en A, S0 y S1 en B; S2 de B no tiene línea.
// DUT: I2A = netlist final por el protocolo (9 combinaciones alcanzables); I2B = e7_decoder suelto (16).
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0; always #10 clk = ~clk;
  reg [7:0] ui = 0, uio = 0; reg xa = 0, xb = 0;
  wire [7:0] uo, uio_out, uio_oe;
  wire prea, preb, vbias, c1, duta, dutb, refa, refb, sa0b, sa1b, sa2b, sb0b, sb1b;
  misfit04_core dut (.ui_in(ui), .uo_out(uo), .uio_in(uio), .uio_out(uio_out), .uio_oe(uio_oe), .ena(1'b1), .clk(clk), .rst_n(rst_n),
    .s0_prea(prea), .s0_preb(preb), .s0_vbias(vbias), .s0_c1(c1), .s0_duta(duta), .s0_dutb(dutb), .s0_refa(refa), .s0_refb(refb),
    .s0_sa0b(sa0b), .s0_sa1b(sa1b), .s0_sa2b(sa2b), .s0_sb0b(sb0b), .s0_sb1b(sb1b), .s0_xa(xa), .s0_xb(xb));
  integer errs = 0, seen = 0; reg [15:0] combos = 0;
  function [12:0] hand(input en, input pre, input [1:0] s);
    reg cal, c11, c10;
    begin
      cal = (s == 2'b10) || (s == 2'b11); c11 = (s == 2'b11); c10 = (s == 2'b10);
      if (!en) hand = {1'b0,1'b0, 1'b0,1'b0, 1'b0,1'b0, 1'b0,1'b0, 1'b1,1'b1,1'b1, 1'b1,1'b1};
      else hand = {~pre, ~pre, 1'b1, 1'b1, (s == 2'b01), (s == 2'b01), cal, cal, ~c11, ~cal, ~c10, ~cal, ~cal};
    end
  endfunction
  wire [12:0] got = {prea, preb, vbias, c1, duta, dutb, refa, refb, sa0b, sa1b, sa2b, sb0b, sb1b};
  task check(input en, input pre, input [1:0] s, input [127:0] where);
    begin
      seen = seen + 1; combos[{en, pre, s}] = 1'b1;
      if (got !== hand(en, pre, s)) begin errs = errs + 1; $display("DISCREPANCIA %0s en=%b pre=%b src=%b got=%b hand=%b", where, en, pre, s, got, hand(en, pre, s)); end
    end
  endtask
  task wr(input [3:0] a, input [7:0] d);
    begin @(negedge clk); uio[3:0] = a; ui = d; repeat (2) @(negedge clk); uio[4] = 1; repeat (4) @(negedge clk); uio[4] = 0; repeat (4) @(negedge clk); end
  endtask
  integer e, s;
  initial begin
    repeat (4) @(negedge clk); rst_n = 1; repeat (4) @(negedge clk);
    check(0, 0, 2'b00, "reset");
    for (e = 0; e < 2; e = e + 1) for (s = 0; s < 4; s = s + 1) begin
      xa = 0; xb = 0;
      wr(4'h1, 8'h03); wr(4'h2, 8'h00); wr(4'h3, s); wr(4'h4, e); wr(4'h5, 8'd10);
      repeat (3) @(negedge clk); check(e, 0, 2'b00, "reposo armado");
      wr(4'h6, 8'h01);
      if (e) begin
        repeat (20) @(negedge clk); if (!uio_out[7]) $display("AVISO no busy"); check(1, 1, s, "precarga");
        wait (prea === 1'b1); repeat (5) @(negedge clk); check(1, 0, s, "cuenta");
        xa = 1; xb = 1; repeat (10) @(negedge clk); check(1, 0, 2'b00, "fin");
      end else begin
        repeat (20) @(negedge clk); check(0, 0, 2'b00, "rechazada");
      end
      wr(4'h1, 8'h00); repeat (3) @(negedge clk); check(0, 0, 2'b00, "desarmado");
    end
    $display("I2A lecturas=%0d combinaciones_distintas=%0d discrepancias=%0d", seen, $countones(combos), errs);
    $finish;
  end
endmodule
