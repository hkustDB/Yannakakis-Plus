create or replace view aggJoin3376983557787704940 as (
with aggView9124498235959807939 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView9124498235959807939 where mk.keyword_id=aggView9124498235959807939.v18);
create or replace view aggJoin8325916652618621416 as (
with aggView6930047223099641619 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView6930047223099641619 where mc.company_type_id=aggView6930047223099641619.v14);
create or replace view aggJoin8635802397872365193 as (
with aggView4467432768400545827 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView4467432768400545827 where mi.info_type_id=aggView4467432768400545827.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin5934579259714319735 as (
with aggView4487837053293390849 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4487837053293390849 where cc.status_id=aggView4487837053293390849.v5);
create or replace view aggJoin4071885480774008755 as (
with aggView3792039702435240873 as (select v36 from aggJoin5934579259714319735 group by v36)
select v36 from aggJoin3376983557787704940 join aggView3792039702435240873 using(v36));
create or replace view aggJoin448083463465166799 as (
with aggView4609040916047528803 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin8325916652618621416 join aggView4609040916047528803 using(v7));
create or replace view aggJoin4309713153109354291 as (
with aggView948995537369284724 as (select v36 from aggJoin4071885480774008755 group by v36)
select v36 from aggJoin448083463465166799 join aggView948995537369284724 using(v36));
create or replace view aggJoin1897695441302189502 as (
with aggView7332895657064734498 as (select v36 from aggJoin4309713153109354291 group by v36)
select v36, v31, v32 from aggJoin8635802397872365193 join aggView7332895657064734498 using(v36));
create or replace view aggJoin7734195256888353766 as (
with aggView3192093098081751472 as (select v36 from aggJoin1897695441302189502 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView3192093098081751472 where t.id=aggView3192093098081751472.v36 and production_year>2000);
create or replace view aggView576196920284439626 as select v37, v21 from aggJoin7734195256888353766 group by v37,v21;
create or replace view aggJoin4206581960997563169 as (
with aggView4100887136736405542 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView576196920284439626 join aggView4100887136736405542 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin4206581960997563169;
