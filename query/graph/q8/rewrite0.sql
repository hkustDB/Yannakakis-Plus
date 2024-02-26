create or replace view semiJoinView636277347636229019 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView7672356264426556025 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView636277347636229019) and src<dst;
create or replace view semiJoinView5649868607173444230 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select v6 from semiJoinView7672356264426556025);
create or replace view semiEnum2953225296812112918 as select v8, v4, v6 from semiJoinView5649868607173444230 join semiJoinView7672356264426556025 using(v6);
create or replace view semiEnum3488347382704161863 as select v4, v6, v8, v2 from semiEnum2953225296812112918 join semiJoinView636277347636229019 using(v4);
create or replace view semiEnum6418680648988627357 as select src as v1, v4, v6, v8, v2 from semiEnum3488347382704161863, Graph as g1 where g1.dst=semiEnum3488347382704161863.v2;
select * from semiEnum6418680648988627357;
