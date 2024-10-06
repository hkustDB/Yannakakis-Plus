SELECT *
FROM bitcoin AS g1, bitcoin AS g2, bitcoin AS g3,
    bitcoin AS g4, bitcoin AS g5, bitcoin AS g6, bitcoin AS g7
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g1.src
    AND g4.dst = g5.src AND g5.dst = g6.src AND g6.dst = g4.src
    AND g1.dst = g7.src AND g7.dst = g4.src
    AND g1.weight < 2