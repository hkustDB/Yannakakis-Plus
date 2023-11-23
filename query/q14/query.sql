SELECT *
FROM Graph AS g1, Graph AS g2,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c2
WHERE c1.src = g1.src AND g1.dst = g2.src AND g2.dst = c2.src
    AND c2.cnt < c1.cnt