create or replace view semiJoinView4637336618234464211 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView5086821610018526759 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView4637336618234464211) and src<dst;
create or replace view semiJoinView1332938496435307720 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select v6 from semiJoinView5086821610018526759);
create or replace view semiEnum6899526180751352192 as select v8, v6, v4 from semiJoinView1332938496435307720 join semiJoinView5086821610018526759 using(v6);
create or replace view semiEnum1206091103203316075 as select v8, v2, v4, v6 from semiEnum6899526180751352192 join semiJoinView4637336618234464211 using(v4);
create or replace view semiEnum7794047421457173809 as select v8, v2, v4, src as v1, v6 from semiEnum1206091103203316075, Graph as g1 where g1.dst=semiEnum1206091103203316075.v2;
select sum(v1+v2+v4+v6+v8) from semiEnum7794047421457173809;
