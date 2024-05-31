create or replace view res as SELECT g1.src AS src, g1.dst AS via1, g2.src AS via2, g2.dst AS via3,
    g3.src AS via4, g3.dst AS via5, g4.src AS via6, g4.dst AS via7, g5.src AS via8, g5.dst AS via9, g6.src AS via10, g6.dst AS via11, g7.src AS via12, g7.dst AS dst
FROM Graph AS g1, Graph AS g2, Graph AS g3,
    Graph AS g4, Graph AS g5, Graph AS g6, Graph AS g7
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g1.src
    AND g4.dst = g5.src AND g5.dst = g6.src AND g6.dst = g4.src
    AND g1.dst = g7.src AND g7.dst = g4.src
    AND g1.src + g2.src + g3.src <= g4.src + g5.src + g6.src;
/*+ QUERY_TIMEOUT=28800000*/select sum(src + via1 + via2 + via3 + via4 + via5 + via6 + via7 + via8 + via9 + via10 + via11 + via12 + dst) from res;