select R.src as node1, R.dst as node2, S.dst as node3, T.dst as node4, R.rating+S.rating+T.rating as total_rating
from graph R, graph S, graph T
where R.src = S.src and R.src = T.src
order by total_rating desc
limit 1024
