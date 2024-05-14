create or replace view semiJoinView3392499514759545587 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4);
create or replace view semiJoinView1098153017120964260 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (v4) from semiJoinView3392499514759545587);
create or replace view semiJoinView871723072018636555 as select distinct src as v1, dst as v2 from Graph AS g1 where (dst) in (select (v2) from semiJoinView1098153017120964260);
create or replace view semiEnum7750418091974621917 as select distinct v4, v1 from semiJoinView871723072018636555 join semiJoinView1098153017120964260 using(v2);
create or replace view semiEnum481918461250770410 as select distinct v1, v6 from semiEnum7750418091974621917 join semiJoinView3392499514759545587 using(v4);
create or replace view semiEnum6924013322473421331 as select v1, dst as v8 from semiEnum481918461250770410, Graph as g4 where g4.src=semiEnum481918461250770410.v6;
select distinct v1, v8 from semiEnum6924013322473421331;
