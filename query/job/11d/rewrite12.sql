create or replace view aggView4164458672053879398 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin2608578016860183360 as (
with aggView8000093381832784145 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView8000093381832784145 where mk.keyword_id=aggView8000093381832784145.v22);
create or replace view aggJoin5567454822287350806 as (
with aggView6948002042383702114 as (select v24 from aggJoin2608578016860183360 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView6948002042383702114 where ml.movie_id=aggView6948002042383702114.v24);
create or replace view aggJoin4252171969279872660 as (
with aggView2121948515311745274 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView2121948515311745274 where mc.company_type_id=aggView2121948515311745274.v18);
create or replace view aggView1732428945456268847 as select v19, v24, v17 from aggJoin4252171969279872660 group by v19,v24,v17;
create or replace view aggJoin1086462322870851183 as (
with aggView9007407323801432412 as (select id as v13 from link_type as lt)
select v24 from aggJoin5567454822287350806 join aggView9007407323801432412 using(v13));
create or replace view aggJoin5982776362145849380 as (
with aggView2805194698927763832 as (select v24 from aggJoin1086462322870851183 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView2805194698927763832 where t.id=aggView2805194698927763832.v24 and production_year>1950);
create or replace view aggView4263193011509467997 as select v24, v28 from aggJoin5982776362145849380 group by v24,v28;
create or replace view aggJoin4584387936267837131 as (
with aggView167808114860161115 as (select v24, MIN(v28) as v41 from aggView4263193011509467997 group by v24)
select v19, v17, v41 from aggView1732428945456268847 join aggView167808114860161115 using(v24));
create or replace view aggJoin8390482368301416364 as (
with aggView8092275893213810179 as (select v17, MIN(v2) as v39 from aggView4164458672053879398 group by v17)
select v19, v41 as v41, v39 from aggJoin4584387936267837131 join aggView8092275893213810179 using(v17));
select MIN(v39) as v39,MIN(v19) as v40,MIN(v41) as v41 from aggJoin8390482368301416364;
