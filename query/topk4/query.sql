select R.src as node1, R.dst as node2, S.dst as node3, T.dst as node4, R.rating as r1, S.rating as r2, T.rating as r3
from graph R, graph S, graph T
where R.src = S.src and R.src = T.src