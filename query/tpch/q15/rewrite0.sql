create or replace view supplierAux8 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView5762360103339622685 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (supplier_no) in (select (v1) from supplierAux8);
create or replace view semiJoinView3240792921506196257 as select distinct v1, v9 from semiJoinView5762360103339622685 where (v9) in (select (max_tr) from q15_inner AS q15_inner);
create or replace view semiEnum3366789523258616029 as select distinct v1, v9 from semiJoinView3240792921506196257, q15_inner as q15_inner where q15_inner.max_tr=semiJoinView3240792921506196257.v9;
create or replace view semiEnum8008381501238359233 as select v3, v2, v1, v9, v5 from semiEnum3366789523258616029 join supplierAux8 using(v1);
select distinct v1, v2, v3, v5, v9 from semiEnum8008381501238359233;
