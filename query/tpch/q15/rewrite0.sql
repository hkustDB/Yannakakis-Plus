create or replace view supplierAux3 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView449768606522166218 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiJoinView1044127942036411937 as select distinct v1, v2, v3, v5 from supplierAux3 where (v1) in (select v1 from semiJoinView449768606522166218);
create or replace view semiEnum6898594267228507918 as select distinct v5, v2, v9, v1, v3 from semiJoinView1044127942036411937 join semiJoinView449768606522166218 using(v1);
create or replace view semiEnum837563120507053288 as select v5, v2, v9, v1, v3 from semiEnum6898594267228507918, q15_inner as q15_inner where q15_inner.max_tr=semiEnum6898594267228507918.v9;
select distinct v1, v2, v3, v5, v9 from semiEnum837563120507053288;

