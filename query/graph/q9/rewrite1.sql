create or replace view semiJoinView2100610367825385607 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4);
create or replace view semiJoinView7942636292836836515 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView2100610367825385607);
create or replace view semiJoinView5067401978704240349 as select distinct src as v1, dst as v2 from Graph AS g1 where (dst) in (select v2 from semiJoinView7942636292836836515);
create or replace view semiEnum3138448849903020001 as select distinct v4, v1 from semiJoinView5067401978704240349 join semiJoinView7942636292836836515 using(v2);
create or replace view semiEnum3850040432353314793 as select distinct v1, v6 from semiEnum3138448849903020001 join semiJoinView2100610367825385607 using(v4);
create or replace view semiEnum1776169174690861977 as select dst as v8, v1 from semiEnum3850040432353314793, Graph as g4 where g4.src=semiEnum3850040432353314793.v6;
create or replace view res as select distinct v1, v8 from semiEnum1776169174690861977;
select sum(v1+v8) from res;
