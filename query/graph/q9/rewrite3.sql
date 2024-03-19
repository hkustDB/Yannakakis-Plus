create or replace view semiJoinView602930932203084601 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4);
create or replace view semiJoinView1408627016572865965 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView602930932203084601);
create or replace view semiJoinView3465936400558832452 as select v2, v4 from semiJoinView1408627016572865965 where (v2) in (select dst from Graph AS g1);
create or replace view semiEnum6158227949342650067 as select v4, src as v1 from semiJoinView3465936400558832452, Graph as g1 where g1.dst=semiJoinView3465936400558832452.v2;
create or replace view semiEnum2974160135449412239 as select v6, v1 from semiEnum6158227949342650067 join semiJoinView602930932203084601 using(v4);
create or replace view semiEnum6991124390198894404 as select v1, dst as v8 from semiEnum2974160135449412239, Graph as g4 where g4.src=semiEnum2974160135449412239.v6;
create or replace view res as select distinct v1, v8 from semiEnum6991124390198894404;
select sum(v1+v8) from res;
