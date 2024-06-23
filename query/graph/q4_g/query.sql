create or replace view res as SELECT distinct g3.src AS src, g3.dst AS dst
FROM google AS g1, google AS g2, google AS g3,
    (SELECT src, COUNT(*) AS cnt FROM google GROUP BY src) AS c1,
    (SELECT src, COUNT(*) AS cnt FROM google GROUP BY src) AS c2
WHERE c1.src = g1.src AND g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = c2.src
    AND c1.cnt < c2.cnt;

select sum(src+dst) FROM res;