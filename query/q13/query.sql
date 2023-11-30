SELECT g2.dst as dst1, g3.src as src2, g4.dst as dst2, g5.dst as dst3
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4, Graph AS g5, Graph AS g6,
(SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
(SELECT dst, COUNT(*) AS cnt FROM Graph GROUP BY dst) AS c2
WHERE c1.src = g1.src AND g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src AND g4.dst = g5.src AND g5.dst = g6.src AND g5.dst = c2.dst AND c1.cnt < c2.cnt