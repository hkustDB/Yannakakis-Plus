create or replace view supplierAux69 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView5301519830958620810 as select v1, v2, v3, v5 from supplierAux69 where (v2, v3, v5, v1) in (select s_name, s_address, s_phone, s_suppkey from supplier AS supplier);
create or replace view semiJoinView5424991906858505601 as select l_suppkey as v1, total_revenue as v9 from view1 AS view1 where (total_revenue) in (select v2_total_revenue_max from view2 AS view2);
create or replace view semiJoinView7217634797979110112 as select v1, v2, v3, v5 from semiJoinView5301519830958620810 where (v1) in (select v1 from semiJoinView5424991906858505601);
create or replace view semiEnum8390812953804857336 as select v5, v2, v3, v1, v9 from semiJoinView7217634797979110112 join semiJoinView5424991906858505601 using(v1);
create or replace view semiEnum4712384514429048626 as select v5, v2, v3, v1, v9 from semiEnum8390812953804857336, view2 as view2 where view2.v2_total_revenue_max=semiEnum8390812953804857336.v9;
select distinct v1, v2, v3, v5, v9 from semiEnum4712384514429048626;
