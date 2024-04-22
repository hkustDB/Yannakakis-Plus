create or replace view aggView3348000076824936469 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2884621142215371610 as (
with aggView3394601736717135052 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3394601736717135052 where t.kind_id=aggView3394601736717135052.v17 and production_year>2005);
create or replace view aggJoin4763854976633147000 as (
with aggView3654971517841056978 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3654971517841056978 where mi_idx.info_type_id=aggView3654971517841056978.v12 and info<'8.5');
create or replace view aggView5996097334012684319 as select v37, v32 from aggJoin4763854976633147000 group by v37,v32;
create or replace view aggJoin7888487187895050666 as (
with aggView3365316341056487848 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView3365316341056487848 where mk.keyword_id=aggView3365316341056487848.v14);
create or replace view aggJoin260428201843888768 as (
with aggView2021742853447375112 as (select v37 from aggJoin7888487187895050666 group by v37)
select v37, v38, v41 from aggJoin2884621142215371610 join aggView2021742853447375112 using(v37));
create or replace view aggView4006553593652525094 as select v38, v37 from aggJoin260428201843888768 group by v38,v37;
create or replace view aggJoin7972178868436042386 as (
with aggView5286342498526444794 as (select v37, MIN(v32) as v50 from aggView5996097334012684319 group by v37)
select v38, v37, v50 from aggView4006553593652525094 join aggView5286342498526444794 using(v37));
create or replace view aggJoin7436434574411984068 as (
with aggView5034921346845338954 as (select v1, MIN(v2) as v49 from aggView3348000076824936469 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView5034921346845338954 where mc.company_id=aggView5034921346845338954.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4554418207897750968 as (
with aggView8811102623757648520 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin7436434574411984068 join aggView8811102623757648520 using(v8));
create or replace view aggJoin1925235718083105790 as (
with aggView576927158386061191 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView576927158386061191 where mi.info_type_id=aggView576927158386061191.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2854814210006123346 as (
with aggView1391766086805710594 as (select v37 from aggJoin1925235718083105790 group by v37)
select v37, v23, v49 as v49 from aggJoin4554418207897750968 join aggView1391766086805710594 using(v37));
create or replace view aggJoin2085416247606841029 as (
with aggView676224031877235861 as (select v37, MIN(v49) as v49 from aggJoin2854814210006123346 group by v37,v49)
select v38, v50 as v50, v49 from aggJoin7972178868436042386 join aggView676224031877235861 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin2085416247606841029;
