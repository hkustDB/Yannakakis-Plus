create or replace view supplierAux40 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView8441737421432407863 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiJoinView4185009753809385396 as select distinct v1, v2, v3, v5 from supplierAux40 where (v1) in (select v1 from semiJoinView8441737421432407863);
create or replace view semiEnum1978831883957390015 as select distinct v9, v3, v2, v5, v1 from semiJoinView4185009753809385396 join semiJoinView8441737421432407863 using(v1);
create or replace view semiEnum2491349593508585214 as select v9, v2, v3, v5, v1 from semiEnum1978831883957390015, q15_inner as q15_inner where q15_inner.max_tr=semiEnum1978831883957390015.v9;
select distinct v1, v2, v3, v5, v9 from semiEnum2491349593508585214;
