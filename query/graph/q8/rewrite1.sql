create or replace view semiJoinView5066319274075944549 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;
create or replace view semiJoinView4529745388083026028 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView5066319274075944549) and src<dst;
create or replace view semiJoinView457812389223488269 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select v2 from semiJoinView4529745388083026028);
create or replace view semiEnum5472267382574193879 as select v1, v2, v4 from semiJoinView457812389223488269 join semiJoinView4529745388083026028 using(v2);
create or replace view semiEnum8274200653855093836 as select v2, v4, v1, v6 from semiEnum5472267382574193879 join semiJoinView5066319274075944549 using(v4);
create or replace view semiEnum4806945127670562640 as select dst as v8, v2, v4, v1, v6 from semiEnum8274200653855093836, Graph as g4 where g4.src=semiEnum8274200653855093836.v6;
select sum(v1+v2+v4+v6+v8) from semiEnum4806945127670562640;
