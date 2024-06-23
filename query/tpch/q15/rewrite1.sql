create or replace view supplierAux3 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView1033575015812455038 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (supplier_no) in (select v1 from supplierAux3);
create or replace view semiJoinView5170187690415384327 as select distinct v1, v9 from semiJoinView1033575015812455038 where (v9) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiEnum3384836742973323926 as select distinct v1, v9 from semiJoinView5170187690415384327, q15_inner as q15_inner where q15_inner.max_tr=semiJoinView5170187690415384327.v9;
create or replace view semiEnum2995508743120337364 as select v5, v2, v9, v1, v3 from semiEnum3384836742973323926 join supplierAux3 using(v1);
create or replace view res as select distinct v1, v2, v3, v5, v9 from semiEnum2995508743120337364;
select sum(v1), sum(v2), sum(v3), sum(v5), sum(v9) from res;