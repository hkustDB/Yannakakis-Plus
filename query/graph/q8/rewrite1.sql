create or replace view semiJoinView5031642675158283797 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;
create or replace view semiJoinView3108839404218010911 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView5031642675158283797) and src<dst;
create or replace view semiJoinView1611820856152107194 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select v2 from semiJoinView3108839404218010911);
create or replace view semiEnum1278272157482515860 as select v1, v4, v2 from semiJoinView1611820856152107194 join semiJoinView3108839404218010911 using(v2);
create or replace view semiEnum6614682374152705941 as select v1, v4, v6, v2 from semiEnum1278272157482515860 join semiJoinView5031642675158283797 using(v4);
create or replace view semiEnum8477044146358884453 as select v1, v4, v6, dst as v8, v2 from semiEnum6614682374152705941, Graph as g4 where g4.src=semiEnum6614682374152705941.v6;
select * from semiEnum8477044146358884453;
