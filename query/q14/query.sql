SELECT *
FROM Graph AS g1, Graph AS g2, Graph as g3, Graph as g4, Graph as g5, Graph as g6,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c2,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c3,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c4
WHERE c1.src = g1.src AND g1.dst = g2.src AND g2.src = g6.src AND g2.dst = g3.src AND g3.dst=g4.src AND g4.dst=g5.src AND g5.dst = c2.src AND g3.dst = c3.src AND g5.dst = c4.src AND c2.cnt >= c1.cnt