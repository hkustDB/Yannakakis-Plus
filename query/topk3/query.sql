select R.src as node1, S.src as node2, T.src as node3, U.src as node4, U.dst as node5, R.rating as r1, S.rating as r2, T.rating as r3, U.rating as r4
from graph R, graph S, graph T, graph U
where R.dst = S.src and S.dst = T.src and T.dst = U.src