/*+QUERY_TIMEOUT=86400000*/SELECT count(*)
FROM graph AS g1, graph AS g2, graph AS g3, graph AS g4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src
    AND g4.dst = g1.src AND g2.src = g4.src 