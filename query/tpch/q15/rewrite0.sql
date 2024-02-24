create or replace view supplierAux74 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiJoinView6374496634503462177 as select v1, v2, v3, v5 from supplierAux74 where (v5) in (select s_phone from supplier AS supplier) and (v3) in (select s_address from supplier AS supplier) and (v1) in (select s_suppkey from supplier AS supplier) and (v2) in (select s_name from supplier AS supplier);
create or replace view semiJoinView3087091906926738644 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (supplier_no) in (select v1 from semiJoinView6374496634503462177);
create or replace view semiJoinView2338154402417714093 as select v1, v9 from semiJoinView3087091906926738644 where (v9) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiEnum5440529060789384814 as select v1, v9 from semiJoinView2338154402417714093, q15_inner as q15_inner where q15_inner.max_tr=semiJoinView2338154402417714093.v9;
create or replace view semiEnum8003310503106144034 as select v1, v9, v5, v3, v2 from semiEnum5440529060789384814 join semiJoinView6374496634503462177 using(v1);
select distinct v1, v2, v3, v5, v9 from semiEnum8003310503106144034;
