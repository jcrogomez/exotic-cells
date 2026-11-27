// SPDX-License-Identifier: Apache-2.0
// Behavioural stand-in for reader2_loop in tests: q pulses every T ns once enabled, the first one after T1 ns.
`timescale 1ns/1ps
module reader2_loop (input wire en, input wire rs, input wire x, output reg q, output wire prenh, output wire prenl);
    assign prenh = ~(q & rs & en); assign prenl = ~((q & ~rs) | ~en);
    parameter real TL = 1000.0, T1L = 4000.0, TH = 22.0, T1H = 180.0, PW = 4.0;
    initial q = 0;
    always begin
        wait (en);
        fork : cyc
            begin #(rs ? T1H : T1L); forever begin q = 1; #(PW); q = 0; #((rs ? TH : TL) - PW); end end
            begin wait (!en); disable cyc; end
        join
        q = 0;
    end
endmodule
