create or replace view supplierAux98 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiUp652700539782073035 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiUp7163916214560773665 as select v1, v9 from semiUp652700539782073035 where (v1) in (select v1 from supplierAux98);
create or replace view semiDown2844558541078039185 as select max_tr as v9 from q15_inner AS q15_inner where (max_tr) in (select v9 from semiUp7163916214560773665);
create or replace view semiDown3028728644242266706 as select v1, v2, v3, v5 from supplierAux98 where (v1) in (select v1 from semiUp7163916214560773665);
create or replace view semiDown8900281152401709126 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier AS supplier where (s_address, s_phone, s_suppkey, s_name) in (select v3, v5, v1, v2 from semiDown3028728644242266706);
create or replace view joinView939602806982830230 as select v1, v2, v3, v5 from semiDown3028728644242266706 join semiDown8900281152401709126 using(v2, v3, v1, v5);
create or replace view joinView1262266004958147328 as select v1, v9 from semiUp7163916214560773665 join semiDown2844558541078039185 using(v9);
create or replace view joinView1069786349820400118 as select v1, v9, v2, v3, v5 from joinView1262266004958147328 join joinView939602806982830230 using(v1);
select distinct v1, v2, v3, v5, v9 from joinView1069786349820400118;

