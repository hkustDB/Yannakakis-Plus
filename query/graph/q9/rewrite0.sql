create or replace view semiJoinView7372517204870661661 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (dst) from Graph AS g1);
create or replace view semiJoinView607158110772363190 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select (v4) from semiJoinView7372517204870661661);
create or replace view semiJoinView6105694926020862757 as select distinct src as v6, dst as v8 from Graph AS g4 where (src) in (select (v6) from semiJoinView607158110772363190);
create or replace view semiEnum6727609660480423250 as select distinct v4, v8 from semiJoinView6105694926020862757 join semiJoinView607158110772363190 using(v6);
create or replace view semiEnum2291222488724742863 as select distinct v2, v8 from semiEnum6727609660480423250 join semiJoinView7372517204870661661 using(v4);
create or replace view semiEnum3349136852037625865 as select src as v1, v8 from semiEnum2291222488724742863, Graph as g1 where g1.dst=semiEnum2291222488724742863.v2;
select distinct v1, v8 from semiEnum3349136852037625865;
