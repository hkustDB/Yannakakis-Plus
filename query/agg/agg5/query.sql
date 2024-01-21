SELECT g2.src, g5.src, sum(g5.dst)
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4, Graph as g5
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src AND g4.dst = g5.src
Group by g2.src, g5.src