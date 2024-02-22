create or replace view semiJoinView3740891860854402151 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView1661033826236749955 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;
create or replace view semiJoinView4372141930053991080 as select v2, v4 from semiJoinView3740891860854402151 where (v4) in (select v4 from semiJoinView1661033826236749955);
create or replace view semiEnum381538604869844238 as select v2, v4, v6 from semiJoinView4372141930053991080 join semiJoinView1661033826236749955 using(v4);
create or replace view semiEnum4038019393247485743 as select v4, v6, dst as v8, v2 from semiEnum381538604869844238, Graph as g4 where g4.src=semiEnum381538604869844238.v6;
create or replace view semiEnum3196115530669860110 as select src as v1, v4, v6, v8, v2 from semiEnum4038019393247485743, Graph as g1 where g1.dst=semiEnum4038019393247485743.v2;
select sum(v1+v2+v4+v6+v8) from semiEnum3196115530669860110;
