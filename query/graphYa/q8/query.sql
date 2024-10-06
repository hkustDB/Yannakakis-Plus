create or replace view res as SELECT g1.src as s1, g4.src as s2, COUNT(*) as cnt, SUM(g3.dst) as sum1, AVG(g4.dst) as avg1, AVG(g1.src) as avg2
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4, Graph AS g5,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM Graph GROUP BY src) AS c2,
    (SELECT dst, COUNT(*) AS cnt FROM Graph GROUP BY dst) AS c3,
    (SELECT dst, COUNT(*) AS cnt FROM Graph GROUP BY dst) AS c4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g1.src = c1.src
    AND g3.dst = c2.src AND g4.dst = g2.src AND g2.dst = g5.src 
    AND g4.src = c3.dst AND g5.dst = c4.dst
GROUP BY g1.src, g4.src;

select sum(s1), sum(s2), sum(cnt), sum(sum1), sum(avg1), sum(avg2) from res;