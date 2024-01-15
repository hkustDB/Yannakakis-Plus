SELECT R.src                                     AS node1,
       S.src                                     AS node2,
       T.src                                     AS node3,
       U.src                                     AS node4,
       U.dst                                     AS node5,
       R.rating + S.rating + T.rating + U.rating AS total_rating
FROM graph R,
     graph S,
     graph T,
     graph U
WHERE R.dst = S.src
  AND S.dst = T.src
  AND T.dst = U.src
ORDER BY total_rating DESC limit 7