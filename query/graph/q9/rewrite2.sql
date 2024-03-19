create or replace view semiJoinView1219664592203909039 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1);
create or replace view semiJoinView9006302572553774733 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView1219664592203909039);
create or replace view semiJoinView166653366863512466 as select v4, v6 from semiJoinView9006302572553774733 where (v6) in (select src from Graph AS g4);
create or replace view semiEnum1838027008088007070 as select v4, dst as v8 from semiJoinView166653366863512466, Graph as g4 where g4.src=semiJoinView166653366863512466.v6;
create or replace view semiEnum2056664636530167754 as select v2, v8 from semiEnum1838027008088007070 join semiJoinView1219664592203909039 using(v4);
create or replace view semiEnum811985184358805594 as select v8, src as v1 from semiEnum2056664636530167754, Graph as g1 where g1.dst=semiEnum2056664636530167754.v2;
create or replace view res as select distinct v1, v8 from semiEnum811985184358805594;
select sum(v1+v8) from res;
