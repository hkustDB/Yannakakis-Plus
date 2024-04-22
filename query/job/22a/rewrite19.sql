create or replace view aggJoin7488096625852798132 as (
with aggView6926675535609468022 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView6926675535609468022 where mc.company_id=aggView6926675535609468022.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4366161677255154611 as (
with aggView3531213895284148886 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin7488096625852798132 join aggView3531213895284148886 using(v8));
create or replace view aggJoin8121289987584412886 as (
with aggView4389975955881120626 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4389975955881120626 where mi_idx.info_type_id=aggView4389975955881120626.v12 and info<'7.0');
create or replace view aggJoin5087555620030277169 as (
with aggView7053586650752645298 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView7053586650752645298 where t.kind_id=aggView7053586650752645298.v17 and production_year>2008);
create or replace view aggJoin533601466360101522 as (
with aggView2971354423276027257 as (select v37, MIN(v38) as v51 from aggJoin5087555620030277169 group by v37)
select v37, v32, v51 from aggJoin8121289987584412886 join aggView2971354423276027257 using(v37));
create or replace view aggJoin9174362220499389572 as (
with aggView8814330566164180389 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin533601466360101522 group by v37,v51)
select movie_id as v37, keyword_id as v14, v51, v50 from movie_keyword as mk, aggView8814330566164180389 where mk.movie_id=aggView8814330566164180389.v37);
create or replace view aggJoin9044379929635670917 as (
with aggView3839147332129469412 as (select v37, MIN(v49) as v49 from aggJoin4366161677255154611 group by v37,v49)
select v37, v14, v51 as v51, v50 as v50, v49 from aggJoin9174362220499389572 join aggView3839147332129469412 using(v37));
create or replace view aggJoin1559300325578620337 as (
with aggView9128731683364173481 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView9128731683364173481 where mi.info_type_id=aggView9128731683364173481.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin3805678488326360964 as (
with aggView7707334920689256533 as (select v37 from aggJoin1559300325578620337 group by v37)
select v14, v51 as v51, v50 as v50, v49 as v49 from aggJoin9044379929635670917 join aggView7707334920689256533 using(v37));
create or replace view aggJoin8671136283368698785 as (
with aggView8736650778384408633 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v51, v50, v49 from aggJoin3805678488326360964 join aggView8736650778384408633 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8671136283368698785;
