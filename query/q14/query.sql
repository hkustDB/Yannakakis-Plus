SELECT count(g1.src, g1.dst, c1.cnt, g2.dst, g3.dst, c2.cnt)
FROM Graph AS g1, Graph AS g2, Graph as g3,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c2
WHERE c1.src = g1.src AND g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = c2.src