select R.src as node1, S.src as node2, S.dst as node3, R.rating as r1, S.rating as r2
from graph R, graph S
where R.dst = S.src

select R.src as node1, S.src as node2, S.dst as node3, R.rating + S.rating as rating
from graph R, graph S
where R.dst = S.src
order by 