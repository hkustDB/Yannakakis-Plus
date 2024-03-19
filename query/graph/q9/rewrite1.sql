create or replace view semiJoinView4033663413502681181 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1);
create or replace view semiJoinView520320218639278969 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView4033663413502681181);
create or replace view semiJoinView5326358545072554591 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select v6 from semiJoinView520320218639278969);
create or replace view semiEnum4463057930595416494 as select v4, v8 from semiJoinView5326358545072554591 join semiJoinView520320218639278969 using(v6);
create or replace view semiEnum843500280259865992 as select v2, v8 from semiEnum4463057930595416494 join semiJoinView4033663413502681181 using(v4);
create or replace view semiEnum2741049538258932789 as select v8, src as v1 from semiEnum843500280259865992, Graph as g1 where g1.dst=semiEnum843500280259865992.v2;
create or replace view res as select distinct v1, v8 from semiEnum2741049538258932789;
select sum(v1+v8) from res;
