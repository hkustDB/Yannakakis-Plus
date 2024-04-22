create or replace view aggJoin7548310490848923045 as (
with aggView3149536145453509985 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView3149536145453509985 where mk.keyword_id=aggView3149536145453509985.v5);
create or replace view aggJoin2793105132631630803 as (
with aggView7042872113290994645 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView7042872113290994645 where mi_idx.info_type_id=aggView7042872113290994645.v3);
create or replace view aggJoin5344741640842839280 as (
with aggView1394782093578150059 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1394782093578150059 where mi.info_type_id=aggView1394782093578150059.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4680232653106005961 as (
with aggView4429815187585264698 as (select v23 from aggJoin7548310490848923045 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27 from title as t, aggView4429815187585264698 where t.id=aggView4429815187585264698.v23 and production_year>2010);
create or replace view aggJoin3742937708042891836 as (
with aggView8055916694827813338 as (select v23 from aggJoin5344741640842839280 group by v23)
select v23, v18 from aggJoin2793105132631630803 join aggView8055916694827813338 using(v23));
create or replace view aggJoin666470924344853337 as (
with aggView6948098848557963344 as (select v23, v18 from aggJoin3742937708042891836 group by v23,v18)
select v23, v18 from aggView6948098848557963344 where v18<'8.5');
create or replace view aggJoin730251379458792616 as (
with aggView6628513031039406318 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27 from aggJoin4680232653106005961 join aggView6628513031039406318 using(v8));
create or replace view aggView2161450916103894844 as select v23, v24 from aggJoin730251379458792616 group by v23,v24;
create or replace view aggJoin534558031360354260 as (
with aggView951059326496018875 as (select v23, MIN(v24) as v36 from aggView2161450916103894844 group by v23)
select v18, v36 from aggJoin666470924344853337 join aggView951059326496018875 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin534558031360354260;
