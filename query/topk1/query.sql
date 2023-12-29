select R.src as node1, S.src as node2, T.src as node3, T.dst as node4, R.rating as r1, S.rating as r2, T.rating as r3
from graph R, graph S, graph T
where R.dst = S.src and S.dst = T.src