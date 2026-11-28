// SPDX-License-Identifier: Apache-2.0
// LVS reference of reader2_unit: the placed digital block and the analog front end, joined on x, prenh, prenl and the supplies.
module reader2_unit (inout VPWR, inout VGND, input en, input pre, input [1:0] src, output xa, output xb, input x);
    wire prenh, prenl;
    reader2_slot u_b (.VPWR(VPWR), .VGND(VGND), .en(en), .pre(pre), .src(src), .xa(xa), .xb(xb), .x(x), .prenh(prenh), .prenl(prenl));
    reader2fe u_fe (.X(x), .PRENH(prenh), .PRENL(prenl), .VDD(VPWR), .GND(VGND));
endmodule
