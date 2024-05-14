create or replace view semiJoinView8791874925273720525 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4) and src<dst;
create or replace view semiJoinView4718241150179362032 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (v4) from semiJoinView8791874925273720525) and src<dst;
create or replace view semiJoinView8598165698159135638 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select (v2) from semiJoinView4718241150179362032);
create or replace view semiEnum241714070534177357 as select v4, v1, v2 from semiJoinView8598165698159135638 join semiJoinView4718241150179362032 using(v2);
create or replace view semiEnum7669015465043660448 as select v4, v6, v1, v2 from semiEnum241714070534177357 join semiJoinView8791874925273720525 using(v4);
create or replace view semiEnum7052101618349875303 as select v4, v6, v1, v2, dst as v8 from semiEnum7669015465043660448, Graph as g4 where g4.src=semiEnum7669015465043660448.v6;
select v1, v2, v4, v6, v8 from semiEnum7052101618349875303;
