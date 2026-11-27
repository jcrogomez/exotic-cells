module reader2_slot (en,
    pre,
    prenh,
    prenl,
    x,
    xa,
    xb,
    src);
 input en;
 input pre;
 output prenh;
 output prenl;
 input x;
 output xa;
 output xb;
 input [1:0] src;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire net13;
 wire \c[0] ;
 wire \c[10] ;
 wire \c[11] ;
 wire \c[12] ;
 wire \c[1] ;
 wire \c[2] ;
 wire \c[3] ;
 wire \c[4] ;
 wire \c[5] ;
 wire \c[6] ;
 wire \c[7] ;
 wire \c[8] ;
 wire \c[9] ;
 wire \ck[0] ;
 wire \ck[10] ;
 wire \ck[11] ;
 wire \ck[12] ;
 wire \ck[1] ;
 wire \ck[2] ;
 wire \ck[3] ;
 wire \ck[4] ;
 wire \ck[5] ;
 wire \ck[6] ;
 wire \ck[7] ;
 wire \ck[8] ;
 wire \ck[9] ;
 wire net1;
 wire net2;
 wire net6;
 wire net7;
 wire rs;
 wire run;
 wire net3;
 wire net4;
 wire ta;
 wire tb;
 wire \u_loop.c ;
 wire \u_loop.c2 ;
 wire \u_loop.d[0] ;
 wire \u_loop.d[1] ;
 wire \u_loop.d[2] ;
 wire \u_loop.d[3] ;
 wire \u_loop.d[4] ;
 wire \u_loop.d[5] ;
 wire \u_loop.d[6] ;
 wire \u_loop.enb ;
 wire \u_loop.qb ;
 wire \u_loop.r ;
 wire \u_loop.rsb ;
 wire \u_loop.s ;
 wire net5;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net;

 sky130_fd_sc_hd__decap_3 FILLER_0_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_23 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_26 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_25 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_37 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_18 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_27 ();
 sky130_fd_sc_hd__fill_2 FILLER_12_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_12_34 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_39 ();
 sky130_fd_sc_hd__fill_2 FILLER_12_42 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_9 ();
 sky130_fd_sc_hd__fill_2 FILLER_13_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_84 ();
 sky130_fd_sc_hd__fill_2 FILLER_13_87 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_53 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_65 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_68 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_74 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_77 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_80 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_86 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_45 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_59 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_62 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_65 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_68 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_74 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_77 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_24 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_30 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_34 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_53 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_84 ();
 sky130_fd_sc_hd__fill_2 FILLER_3_87 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_35 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_42 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_45 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_76 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_82 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_33 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_36 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_39 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_61 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_64 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_67 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_10 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_56 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_59 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_6 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_62 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_88 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_49 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_52 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_45 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_48 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_58 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_61 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_64 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_67 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_76 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_82 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_19 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_22 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_53 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_61 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_64 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_67 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_30 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_31 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_32 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_33 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_45 ();
 sky130_fd_sc_hd__inv_2 _20_ (.A(net2),
    .Y(_13_));
 sky130_fd_sc_hd__inv_2 _21_ (.A(\c[6] ),
    .Y(\ck[7] ));
 sky130_fd_sc_hd__inv_2 _22_ (.A(\c[8] ),
    .Y(\ck[9] ));
 sky130_fd_sc_hd__inv_2 _23_ (.A(\c[2] ),
    .Y(\ck[3] ));
 sky130_fd_sc_hd__inv_2 _24_ (.A(\c[10] ),
    .Y(\ck[11] ));
 sky130_fd_sc_hd__inv_2 _25_ (.A(\c[12] ),
    .Y(_00_));
 sky130_fd_sc_hd__inv_2 _26_ (.A(\c[4] ),
    .Y(\ck[5] ));
 sky130_fd_sc_hd__inv_2 _27_ (.A(\c[0] ),
    .Y(\ck[1] ));
 sky130_fd_sc_hd__inv_2 _28_ (.A(\c[1] ),
    .Y(\ck[2] ));
 sky130_fd_sc_hd__inv_2 _29_ (.A(\c[3] ),
    .Y(\ck[4] ));
 sky130_fd_sc_hd__inv_2 _30_ (.A(\c[5] ),
    .Y(\ck[6] ));
 sky130_fd_sc_hd__inv_2 _31_ (.A(\c[7] ),
    .Y(\ck[8] ));
 sky130_fd_sc_hd__inv_2 _32_ (.A(\c[9] ),
    .Y(\ck[10] ));
 sky130_fd_sc_hd__inv_2 _33_ (.A(\c[11] ),
    .Y(\ck[12] ));
 sky130_fd_sc_hd__o211a_2 _34_ (.A1(net3),
    .A2(net4),
    .B1(net1),
    .C1(_13_),
    .X(run));
 sky130_fd_sc_hd__nand2b_2 _35_ (.A_N(net3),
    .B(net4),
    .Y(_14_));
 sky130_fd_sc_hd__inv_2 _36_ (.A(_14_),
    .Y(rs));
 sky130_fd_sc_hd__xor2_2 _37_ (.A(net3),
    .B(net4),
    .X(_15_));
 sky130_fd_sc_hd__or3b_2 _38_ (.A(net4),
    .B(\c[2] ),
    .C_N(net3),
    .X(_16_));
 sky130_fd_sc_hd__o221a_2 _39_ (.A1(\c[8] ),
    .A2(_14_),
    .B1(_15_),
    .B2(\c[6] ),
    .C1(_16_),
    .X(ta));
 sky130_fd_sc_hd__or3b_2 _40_ (.A(net4),
    .B(\c[4] ),
    .C_N(net3),
    .X(_17_));
 sky130_fd_sc_hd__o221a_2 _41_ (.A1(\c[12] ),
    .A2(_14_),
    .B1(_15_),
    .B2(\c[10] ),
    .C1(_17_),
    .X(tb));
 sky130_fd_sc_hd__inv_2 _42_ (.A(\c[11] ),
    .Y(_01_));
 sky130_fd_sc_hd__inv_2 _43_ (.A(\c[10] ),
    .Y(_02_));
 sky130_fd_sc_hd__inv_2 _44_ (.A(\c[9] ),
    .Y(_03_));
 sky130_fd_sc_hd__inv_2 _45_ (.A(\c[8] ),
    .Y(_04_));
 sky130_fd_sc_hd__inv_2 _46_ (.A(\c[7] ),
    .Y(_05_));
 sky130_fd_sc_hd__inv_2 _47_ (.A(\c[6] ),
    .Y(_06_));
 sky130_fd_sc_hd__inv_2 _48_ (.A(\c[5] ),
    .Y(_07_));
 sky130_fd_sc_hd__inv_2 _49_ (.A(\c[4] ),
    .Y(_08_));
 sky130_fd_sc_hd__inv_2 _50_ (.A(\c[3] ),
    .Y(_09_));
 sky130_fd_sc_hd__inv_2 _51_ (.A(\c[2] ),
    .Y(_10_));
 sky130_fd_sc_hd__inv_2 _52_ (.A(\c[1] ),
    .Y(_11_));
 sky130_fd_sc_hd__inv_2 _53_ (.A(\c[0] ),
    .Y(_12_));
 sky130_fd_sc_hd__dfrtp_2 _54_ (.CLK(_01_),
    .D(_00_),
    .RESET_B(net11),
    .Q(\c[12] ));
 sky130_fd_sc_hd__dfrtp_2 _55_ (.CLK(_02_),
    .D(\ck[12] ),
    .RESET_B(net12),
    .Q(\c[11] ));
 sky130_fd_sc_hd__dfrtp_2 _56_ (.CLK(_03_),
    .D(\ck[11] ),
    .RESET_B(net12),
    .Q(\c[10] ));
 sky130_fd_sc_hd__dfrtp_2 _57_ (.CLK(_04_),
    .D(\ck[10] ),
    .RESET_B(net12),
    .Q(\c[9] ));
 sky130_fd_sc_hd__dfrtp_2 _58_ (.CLK(_05_),
    .D(\ck[9] ),
    .RESET_B(net12),
    .Q(\c[8] ));
 sky130_fd_sc_hd__dfrtp_2 _59_ (.CLK(_06_),
    .D(\ck[8] ),
    .RESET_B(net12),
    .Q(\c[7] ));
 sky130_fd_sc_hd__dfrtp_2 _60_ (.CLK(_07_),
    .D(\ck[7] ),
    .RESET_B(net11),
    .Q(\c[6] ));
 sky130_fd_sc_hd__dfrtp_2 _61_ (.CLK(_08_),
    .D(\ck[6] ),
    .RESET_B(net11),
    .Q(\c[5] ));
 sky130_fd_sc_hd__dfrtp_2 _62_ (.CLK(_09_),
    .D(\ck[5] ),
    .RESET_B(net11),
    .Q(\c[4] ));
 sky130_fd_sc_hd__dfrtp_2 _63_ (.CLK(_10_),
    .D(\ck[4] ),
    .RESET_B(net11),
    .Q(\c[3] ));
 sky130_fd_sc_hd__dfrtp_2 _64_ (.CLK(_11_),
    .D(\ck[3] ),
    .RESET_B(net11),
    .Q(\c[2] ));
 sky130_fd_sc_hd__dfrtp_2 _65_ (.CLK(_12_),
    .D(\ck[2] ),
    .RESET_B(net11),
    .Q(\c[1] ));
 sky130_fd_sc_hd__dfrtp_2 _66_ (.CLK(net10),
    .D(\ck[1] ),
    .RESET_B(net11),
    .Q(\c[0] ));
 sky130_fd_sc_hd__dfrtp_2 _67_ (.CLK(tb),
    .D(net),
    .RESET_B(net12),
    .Q(net9));
 sky130_fd_sc_hd__conb_1 _67__13 (.HI(net));
 sky130_fd_sc_hd__dfrtp_2 _68_ (.CLK(ta),
    .D(net13),
    .RESET_B(net12),
    .Q(net8));
 sky130_fd_sc_hd__conb_1 _68__14 (.HI(net13));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout11 (.A(run),
    .X(net11));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout12 (.A(run),
    .X(net12));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input1 (.A(en),
    .X(net1));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input2 (.A(pre),
    .X(net2));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input3 (.A(src[0]),
    .X(net3));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input4 (.A(src[1]),
    .X(net4));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input5 (.A(x),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_2 max_cap10 (.A(\ck[0] ),
    .X(net10));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output6 (.A(net6),
    .X(prenh));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output7 (.A(net7),
    .X(prenl));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output8 (.A(net8),
    .X(xa));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output9 (.A(net9),
    .X(xb));
 sky130_fd_sc_hd__inv_1 \u_loop.u_cmp  (.A(net5),
    .Y(\u_loop.c ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d0  (.A(net10),
    .X(\u_loop.d[0] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d1  (.A(\u_loop.d[0] ),
    .X(\u_loop.d[1] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d2  (.A(\u_loop.d[1] ),
    .X(\u_loop.d[2] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d3  (.A(\u_loop.d[2] ),
    .X(\u_loop.d[3] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d4  (.A(\u_loop.d[3] ),
    .X(\u_loop.d[4] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d5  (.A(\u_loop.d[4] ),
    .X(\u_loop.d[5] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d6  (.A(\u_loop.d[5] ),
    .X(\u_loop.d[6] ));
 sky130_fd_sc_hd__dlygate4sd3_1 \u_loop.u_d7  (.A(\u_loop.d[6] ),
    .X(\u_loop.r ));
 sky130_fd_sc_hd__nand3_4 \u_loop.u_gh  (.A(\ck[0] ),
    .B(rs),
    .C(net11),
    .Y(net6));
 sky130_fd_sc_hd__a21oi_4 \u_loop.u_gl  (.A1(net10),
    .A2(\u_loop.rsb ),
    .B1(\u_loop.enb ),
    .Y(net7));
 sky130_fd_sc_hd__inv_1 \u_loop.u_ie  (.A(net11),
    .Y(\u_loop.enb ));
 sky130_fd_sc_hd__inv_1 \u_loop.u_ir  (.A(rs),
    .Y(\u_loop.rsb ));
 sky130_fd_sc_hd__nor2_1 \u_loop.u_q  (.A(\u_loop.r ),
    .B(\u_loop.qb ),
    .Y(\ck[0] ));
 sky130_fd_sc_hd__nor2_1 \u_loop.u_qb  (.A(\u_loop.s ),
    .B(\ck[0] ),
    .Y(\u_loop.qb ));
 sky130_fd_sc_hd__inv_1 \u_loop.u_s1  (.A(\u_loop.c ),
    .Y(\u_loop.c2 ));
 sky130_fd_sc_hd__inv_1 \u_loop.u_s2  (.A(\u_loop.c2 ),
    .Y(\u_loop.s ));
endmodule
