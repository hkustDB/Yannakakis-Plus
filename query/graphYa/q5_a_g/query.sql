SELECT count(*)
FROM google AS g1, google AS g2, google AS g3, google AS g4, google AS g5,
    (SELECT src, COUNT(*) AS cnt FROM google GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM google GROUP BY src) AS c2,
    (SELECT dst, COUNT(*) AS cnt FROM google GROUP BY dst) AS c3,
    (SELECT dst, COUNT(*) AS cnt FROM google GROUP BY dst) AS c4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g1.src = c1.src
    AND g3.dst = c2.src AND g4.dst = g2.src AND g2.dst = g5.src 
    AND g4.src = c3.dst AND g5.dst = c4.dst