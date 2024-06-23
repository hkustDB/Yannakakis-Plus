create or replace view res as SELECT g1.src as v1, g1.dst as v2, g2.dst as v3, g4.src as v4, g4.dst as v5, g5.dst as v6
FROM bitcoin AS g1, bitcoin AS g2, bitcoin AS g3,
    bitcoin AS g4, bitcoin AS g5, bitcoin AS g6, bitcoin AS g7
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g1.src
    AND g4.dst = g5.src AND g5.dst = g6.src AND g6.dst = g4.src
    AND g1.dst = g7.src AND g7.dst = g4.src
    AND g1.weight*g2.weight*g3.weight+800 < g4.weight*g5.weight*g6.weight;

select sum(v1+v2+v3+v4+v5+v6) from res;