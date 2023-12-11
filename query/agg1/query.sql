SELECT g2.src, SUM(g1.dst), SUM(g2.dst), SUM(g3.dst), SUM(g4.dst)
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src
GROUP BY g2.src