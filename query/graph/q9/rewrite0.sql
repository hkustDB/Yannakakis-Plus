create or replace view bag4006 as select g2.src as v2, g3.src as v4, g3.dst as v6 from Graph as g3, Graph as g2 where g3.src=g2.dst;
create or replace view bag4005 as select g1.src as v1, g1.dst as v2, g4.src as v6, g4.dst as v8 from Graph as g4, Graph as g1;
create or replace view semiJoinView8710646402332314628 as select v1, v2, v6, v8 from bag4005 where (v2, v6) in (select v2, v6 from bag4006);
create or replace view bag4005Aux15 as select v1, v8 from semiJoinView8710646402332314628;
create or replace view res as select distinct v1, v8 from bag4005Aux15;
select sum(v1+v8) from res;
