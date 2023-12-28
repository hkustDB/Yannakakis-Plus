SELECT g1.src as src, g1.dst as dst, g2.dst as dst2, g3.dst as dst3, g1.rating as r1, g2.rating as r2, g3.rating as r3
FROM Graph AS g1, Graph AS g2, Graph AS g3
WHERE g1.dst = g2.src AND g2.dst = g3.src