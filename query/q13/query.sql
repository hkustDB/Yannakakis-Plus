SELECT g1.src AS src, g1.dst AS via1, g3.src AS via2, g3.dst AS via3, g4.dst as via4, g5.dst as dst, c1.cnt as c1cnt, c2.cnt as c2cnt
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4, Graph AS g5,
(SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
(SELECT dst, COUNT(*) AS cnt FROM Graph GROUP BY dst) AS c2
WHERE c1.src = g1.src AND g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src AND g4.dst = g5.src AND g5.dst = c2.dst AND c1.cnt < c2.cnt