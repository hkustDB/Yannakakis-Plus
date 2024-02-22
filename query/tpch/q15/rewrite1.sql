create or replace view supplierAux69 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView3266970094061819581 as select v1, v2, v3, v5 from supplierAux69 where (v2, v3, v5, v1) in (select s_name, s_address, s_phone, s_suppkey from supplier AS supplier);
create or replace view semiJoinView762044418243572660 as select l_suppkey as v1, total_revenue as v9 from view1 AS view1 where (total_revenue) in (select v2_total_revenue_max from view2 AS view2);
create or replace view semiJoinView6463089272808936664 as select v1, v9 from semiJoinView762044418243572660 where (v1) in (select v1 from semiJoinView3266970094061819581);
create or replace view semiEnum4826298285266837091 as select v5, v2, v3, v1, v9 from semiJoinView6463089272808936664 join semiJoinView3266970094061819581 using(v1);
create or replace view semiEnum861942091323434547 as select v5, v2, v3, v1, v9 from semiEnum4826298285266837091, view2 as view2 where view2.v2_total_revenue_max=semiEnum4826298285266837091.v9;
select sum(distinct v1+v2+v3+v5+v9) from semiEnum861942091323434547;
