create or replace view supplierAux40 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView8845761291651779800 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiJoinView5108084635312812482 as select distinct v1, v9 from semiJoinView8845761291651779800 where (v1) in (select v1 from supplierAux40);
create or replace view semiEnum645905456351271606 as select distinct v9, v3, v2, v5, v1 from semiJoinView5108084635312812482 join supplierAux40 using(v1);
create or replace view semiEnum3958500992614836256 as select v9, v2, v3, v5, v1 from semiEnum645905456351271606, q15_inner as q15_inner where q15_inner.max_tr=semiEnum645905456351271606.v9;
select distinct v1, v2, v3, v5, v9 from semiEnum3958500992614836256;
