create or replace view aggView4788610181920198683 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7960635253159112181 as (
with aggView1144079636635042478 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1144079636635042478 where mi_idx.info_type_id=aggView1144079636635042478.v12 and info<'7.0');
create or replace view aggView708081813514996283 as select v32, v37 from aggJoin7960635253159112181 group by v32,v37;
create or replace view aggJoin104925795337603563 as (
with aggView8865091692609002517 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8865091692609002517 where t.kind_id=aggView8865091692609002517.v17 and production_year>2008);
create or replace view aggView4180773690830958669 as select v38, v37 from aggJoin104925795337603563 group by v38,v37;
create or replace view aggJoin5504116835468617606 as (
with aggView3894920071185903139 as (select v1, MIN(v2) as v49 from aggView4788610181920198683 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView3894920071185903139 where mc.company_id=aggView3894920071185903139.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5425790928130260225 as (
with aggView8460606748546896237 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin5504116835468617606 join aggView8460606748546896237 using(v8));
create or replace view aggJoin5130726349451794403 as (
with aggView4001681619557506595 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4001681619557506595 where mi.info_type_id=aggView4001681619557506595.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin9093810429640019930 as (
with aggView8151490325536352341 as (select v37 from aggJoin5130726349451794403 group by v37)
select v37, v23, v49 as v49 from aggJoin5425790928130260225 join aggView8151490325536352341 using(v37));
create or replace view aggJoin581683855250705499 as (
with aggView4856473201424147727 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView4856473201424147727 where mk.keyword_id=aggView4856473201424147727.v14);
create or replace view aggJoin2772876364264959575 as (
with aggView1040705435014307328 as (select v37 from aggJoin581683855250705499 group by v37)
select v37, v23, v49 as v49 from aggJoin9093810429640019930 join aggView1040705435014307328 using(v37));
create or replace view aggJoin6403086670593478709 as (
with aggView7332891191095668117 as (select v37, MIN(v49) as v49 from aggJoin2772876364264959575 group by v37,v49)
select v38, v37, v49 from aggView4180773690830958669 join aggView7332891191095668117 using(v37));
create or replace view aggJoin7267266407863227804 as (
with aggView1461345929882956287 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin6403086670593478709 group by v37,v49)
select v32, v49, v51 from aggView708081813514996283 join aggView1461345929882956287 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin7267266407863227804;
