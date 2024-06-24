create or replace view res as SELECT g2.src, COUNT(*) as cnt, SUM(g3.dst) as sum1, AVG(g4.dst) as avg1, AVG(g1.src) as avg2
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph AS g4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src AND g1.src < g4.dst
GROUP BY g2.src;

/*+QUERY_TIMEOUT=172800000*/select sum(src + cnt + sum1 + cnt + avg1 + avg2) from res;