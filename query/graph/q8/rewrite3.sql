create or replace view semiJoinView6507781842538042387 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView2902824718390104627 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView6507781842538042387) and src<dst;
create or replace view semiJoinView5560489269403942646 as select v4, v6 from semiJoinView2902824718390104627 where (v6) in (select src from Graph AS g4);
create or replace view semiEnum7646875307907802507 as select dst as v8, v4, v6 from semiJoinView5560489269403942646, Graph as g4 where g4.src=semiJoinView5560489269403942646.v6;
create or replace view semiEnum5502014773378576415 as select v4, v6, v8, v2 from semiEnum7646875307907802507 join semiJoinView6507781842538042387 using(v4);
create or replace view semiEnum521933334886169131 as select src as v1, v4, v6, v8, v2 from semiEnum5502014773378576415, Graph as g1 where g1.dst=semiEnum5502014773378576415.v2;
select sum(v1+v2+v4+v6+v8) from semiEnum521933334886169131;
