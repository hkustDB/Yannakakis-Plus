create or replace view res as SELECT distinct g2.src as src, g2.dst as dst
FROM dblp AS g1, dblp AS g2, dblp AS g3, dblp AS g4, dblp AS g5,
    (SELECT src, COUNT(*) AS cnt FROM dblp GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM dblp GROUP BY src) AS c2,
    (SELECT dst, COUNT(*) AS cnt FROM dblp GROUP BY dst) AS c3,
    (SELECT dst, COUNT(*) AS cnt FROM dblp GROUP BY dst) AS c4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g1.src = c1.src
    AND g3.dst = c2.src AND c1.cnt < c2.cnt
    AND g4.dst = g2.src AND g2.dst = g5.src AND g4.src = c3.dst
    AND g5.dst = c4.dst AND c3.cnt < c4.cnt;

/*+QUERY_TIMEOUT=86400000*/select sum(src+dst) FROM res;