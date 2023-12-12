SELECT g2.src, g2.dst, count(g3.dst), count(g1.dst)
FROM Graph AS g1, Graph AS g2, Graph AS g3
WHERE g1.dst = g2.src AND g2.dst = g3.src
Group by g2.src, g2.dst