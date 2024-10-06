create or replace view supplierAux98 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
create or replace view semiUp8237530834903646654 as select supplier_no as v1, total_revenue as v9 from revenue0 AS revenue0 where (total_revenue) in (select max_tr from q15_inner AS q15_inner);
create or replace view semiUp8676336837832886438 as select v1, v2, v3, v5 from supplierAux98 where (v1) in (select v1 from semiUp8237530834903646654);
create or replace view semiDown6591534488732418312 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier AS supplier where (s_address, s_phone, s_suppkey, s_name) in (select v3, v5, v1, v2 from semiUp8676336837832886438);
create or replace view semiDown1035205759953231851 as select v1, v9 from semiUp8237530834903646654 where (v1) in (select v1 from semiUp8676336837832886438);
create or replace view semiDown5729991721382022002 as select max_tr as v9 from q15_inner AS q15_inner where (max_tr) in (select v9 from semiDown1035205759953231851);
create or replace view joinView382170348297197483 as select v1, v2, v3, v5 from semiUp8676336837832886438 join semiDown6591534488732418312 using(v2, v3, v1, v5);
create or replace view joinView3959719507470767822 as select v1, v9 from semiDown1035205759953231851 join semiDown5729991721382022002 using(v9);
create or replace view joinView2776591647250213747 as select v1, v2, v3, v5, v9 from joinView382170348297197483 join joinView3959719507470767822 using(v1);
select distinct v1, v2, v3, v5, v9 from joinView2776591647250213747;

