create or replace view semiJoinView7721224490851223930 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4);
create or replace view semiJoinView6083869755870295440 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView7721224490851223930);
create or replace view semiJoinView3785504094870979531 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select v2 from semiJoinView6083869755870295440);
create or replace view semiEnum464280664222094923 as select v4, v1 from semiJoinView3785504094870979531 join semiJoinView6083869755870295440 using(v2);
create or replace view semiEnum5318347199610043294 as select v6, v1 from semiEnum464280664222094923 join semiJoinView7721224490851223930 using(v4);
create or replace view semiEnum2724116903565062375 as select v1, dst as v8 from semiEnum5318347199610043294, Graph as g4 where g4.src=semiEnum5318347199610043294.v6;
create or replace view res as select distinct v1, v8 from semiEnum2724116903565062375;
select sum(v1+v8) from res;
