SELECT g2.src, sum(g3.dst)
FROM Graph AS g1, Graph AS g2, Graph AS g3
WHERE g1.dst = g2.src AND g2.dst = g3.src
Group by g2.src