create or replace view semiJoinView400801767561036800 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (dst) from Graph AS g1) and src<dst;
create or replace view semiJoinView426975307677377143 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4) and src<dst;
create or replace view semiJoinView1742755132195507327 as select v4, v6 from semiJoinView426975307677377143 where (v4) in (select (v4) from semiJoinView400801767561036800);
create or replace view semiEnum4672794615972401033 as select v2, v4, v6 from semiJoinView1742755132195507327 join semiJoinView400801767561036800 using(v4);
create or replace view semiEnum7380345438705059014 as select v4, dst as v8, v2, v6 from semiEnum4672794615972401033, Graph as g4 where g4.src=semiEnum4672794615972401033.v6;
create or replace view semiEnum5860062066704399086 as select v4, v8, v2, src as v1, v6 from semiEnum7380345438705059014, Graph as g1 where g1.dst=semiEnum7380345438705059014.v2;
select v1, v2, v4, v6, v8 from semiEnum5860062066704399086;
