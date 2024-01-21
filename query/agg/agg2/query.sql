SELECT g2.src, SUM(g3.dst)
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src AND g1.src < g4.dst AND g1.src in (1, 2)
GROUP BY g2.src