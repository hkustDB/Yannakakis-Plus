select S.dst as A, S.src as B, R.src as C, T.dst as D, U.dst as E, R.rating+S.rating+T.rating+U.rating as total_rating
from graph R, graph S, graph T, graph U
where R.dst = S.src and R.src = T.src and R.src = U.src
order by total_rating desc
limit 1024
