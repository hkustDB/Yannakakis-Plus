create or replace view supplierAux8 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView6341511623358325182 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select (max_tr) from q15_inner AS q15_inner);
create or replace view semiJoinView3624185644022244109 as select distinct v1, v2, v3, v5 from supplierAux8 where (v1) in (select (v1) from semiJoinView6341511623358325182);
create or replace view semiEnum3800925340912396553 as select distinct v3, v2, v9, v1, v5 from semiJoinView3624185644022244109 join semiJoinView6341511623358325182 using(v1);
create or replace view semiEnum2977337225494113334 as select v3, v2, v9, v1, v5 from semiEnum3800925340912396553, q15_inner as q15_inner where q15_inner.max_tr=semiEnum3800925340912396553.v9;
select distinct v1, v2, v3, v5, v9 from semiEnum2977337225494113334;
