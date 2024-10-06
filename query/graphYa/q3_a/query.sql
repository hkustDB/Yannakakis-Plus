create or replace view res as SELECT distinct g1.dst
FROM Graph AS g1, Graph AS g2, Graph AS g3,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c2,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c3,
    (SELECT dst, COUNT(*) AS cnt FROM Graph GROUP BY dst) AS c4
WHERE g1.dst = g2.src AND g2.dst = g3.src
    AND c1.src = g1.src AND c2.src = g3.dst
    AND c3.src = g2.src AND c4.dst = g3.dst;

select sum(dst) from res;