create or replace view aggJoin7930315860976467319 as (
with aggView1477621446511092661 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView1477621446511092661 where mc.company_id=aggView1477621446511092661.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin378166536940111444 as (
with aggView6919494646203284135 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin7930315860976467319 join aggView6919494646203284135 using(v8));
create or replace view aggJoin2865856968857749632 as (
with aggView6210581757620967368 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6210581757620967368 where t.kind_id=aggView6210581757620967368.v17 and production_year>2005);
create or replace view aggJoin9218972289552927157 as (
with aggView2540598195266480235 as (select v37, MIN(v38) as v51 from aggJoin2865856968857749632 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v51 from movie_info as mi, aggView2540598195266480235 where mi.movie_id=aggView2540598195266480235.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin485672380647201858 as (
with aggView3685536180025299115 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3685536180025299115 where mi_idx.info_type_id=aggView3685536180025299115.v12 and info<'8.5');
create or replace view aggJoin8750071766267525774 as (
with aggView1043463020240752004 as (select v37, MIN(v32) as v50 from aggJoin485672380647201858 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView1043463020240752004 where mk.movie_id=aggView1043463020240752004.v37);
create or replace view aggJoin1179288505259841891 as (
with aggView761319645500856095 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v51 from aggJoin9218972289552927157 join aggView761319645500856095 using(v10));
create or replace view aggJoin519369551151921624 as (
with aggView8657158266136590488 as (select v37, MIN(v51) as v51 from aggJoin1179288505259841891 group by v37,v51)
select v37, v23, v49 as v49, v51 from aggJoin378166536940111444 join aggView8657158266136590488 using(v37));
create or replace view aggJoin1159542911896395957 as (
with aggView2191593498887450918 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin519369551151921624 group by v37,v49,v51)
select v14, v50 as v50, v49, v51 from aggJoin8750071766267525774 join aggView2191593498887450918 using(v37));
create or replace view aggJoin6428258409356669364 as (
with aggView1940241898656727035 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v49, v51 from aggJoin1159542911896395957 join aggView1940241898656727035 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin6428258409356669364;
