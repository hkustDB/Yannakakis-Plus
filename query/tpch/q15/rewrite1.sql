create or replace view supplierAux74 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView917567596888505404 as select v1, v2, v3, v5 from supplierAux74 where (v5, v3, v1, v2) in (select (s_phone, s_address, s_suppkey, s_name) from supplier AS supplier);
create or replace view semiJoinView4653054340788208155 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiJoinView289438604116215001 as select v1, v2, v3, v5 from semiJoinView917567596888505404 where (v1) in (select v1 from semiJoinView4653054340788208155);
create or replace view semiEnum2896682860761715349 as select v1, v9, v5, v3, v2 from semiJoinView289438604116215001 join semiJoinView4653054340788208155 using(v1);
create or replace view semiEnum2394921378855886644 as select v1, v9, v5, v3, v2 from semiEnum2896682860761715349, q15_inner as q15_inner where q15_inner.max_tr=semiEnum2896682860761715349.v9;
select distinct v1, v2, v3, v5, v9 from semiEnum2394921378855886644;
