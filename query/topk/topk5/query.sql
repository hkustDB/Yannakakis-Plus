select S.dst as A, S.src as B, R.src as C, T.dst as D, U.dst as E, R.rating as r1, S.rating as r2, T.rating as r3, U.rating as r4
from graph R, graph S, graph T, graph U
where R.dst = S.src and R.src = T.src and R.src = U.src
