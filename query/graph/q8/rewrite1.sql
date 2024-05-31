create or replace view semiJoinView996487866781989862 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView7027669911822510683 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView996487866781989862) and src<dst;
create or replace view semiJoinView3707355291637780613 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select v6 from semiJoinView7027669911822510683);
create or replace view semiEnum3216818181710242627 as select v6, v4, v8 from semiJoinView3707355291637780613 join semiJoinView7027669911822510683 using(v6);
create or replace view semiEnum4550608445835670139 as select v2, v8, v6, v4 from semiEnum3216818181710242627 join semiJoinView996487866781989862 using(v4);
create or replace view semiEnum9191438886353126441 as select v2, src as v1, v8, v6, v4 from semiEnum4550608445835670139, Graph as g1 where g1.dst=semiEnum4550608445835670139.v2;
select sum(v1+v2+v4+v6+v8) from semiEnum9191438886353126441;
