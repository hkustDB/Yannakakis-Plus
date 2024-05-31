create or replace view semiJoinView8233773097776419415 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;
create or replace view semiJoinView455347288585619818 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView8233773097776419415) and src<dst;
create or replace view semiJoinView5175669300694909212 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select v2 from semiJoinView455347288585619818);
create or replace view semiEnum2458162857919398502 as select v2, v1, v4 from semiJoinView5175669300694909212 join semiJoinView455347288585619818 using(v2);
create or replace view semiEnum4516938094990972033 as select v2, v1, v4, v6 from semiEnum2458162857919398502 join semiJoinView8233773097776419415 using(v4);
create or replace view semiEnum2049553585914219469 as select v2, v1, dst as v8, v4, v6 from semiEnum4516938094990972033, Graph as g4 where g4.src=semiEnum4516938094990972033.v6;
select sum(v1+v2+v4+v6+v8) from semiEnum2049553585914219469;
