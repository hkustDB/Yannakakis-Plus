SELECT *
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src
    AND g4.dst = g1.src AND g2.src = g4.src 