create or replace view aggJoin1131202239274592085 as (
with aggView2597579735897407737 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2597579735897407737 where mc.company_type_id=aggView2597579735897407737.v14);
create or replace view aggJoin6927000461028677372 as (
with aggView2325393895914611209 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView2325393895914611209 where mk.keyword_id=aggView2325393895914611209.v18);
create or replace view aggJoin7209639031320447286 as (
with aggView5091409866126450063 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5091409866126450063 where mi.info_type_id=aggView5091409866126450063.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin2940887786518812031 as (
with aggView7221567795652191607 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7221567795652191607 where cc.status_id=aggView7221567795652191607.v5);
create or replace view aggJoin8814617324087844889 as (
with aggView8401780681892777860 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1131202239274592085 join aggView8401780681892777860 using(v7));
create or replace view aggJoin7214077202149637820 as (
with aggView2897987908269200295 as (select v36 from aggJoin2940887786518812031 group by v36)
select v36 from aggJoin8814617324087844889 join aggView2897987908269200295 using(v36));
create or replace view aggJoin2570143364032541014 as (
with aggView1091908158186849775 as (select v36 from aggJoin7214077202149637820 group by v36)
select v36 from aggJoin6927000461028677372 join aggView1091908158186849775 using(v36));
create or replace view aggJoin7480319789953266936 as (
with aggView8028749615623409017 as (select v36 from aggJoin2570143364032541014 group by v36)
select v36, v31, v32 from aggJoin7209639031320447286 join aggView8028749615623409017 using(v36));
create or replace view aggJoin3380048429098926859 as (
with aggView7273145679081528500 as (select v36 from aggJoin7480319789953266936 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView7273145679081528500 where t.id=aggView7273145679081528500.v36 and production_year>2000);
create or replace view aggView7475415860563339732 as select v37, v21 from aggJoin3380048429098926859 group by v37,v21;
create or replace view aggJoin5712555459447697868 as (
with aggView5958632235578963826 as (select v21, MIN(v37) as v49 from aggView7475415860563339732 group by v21)
select kind as v22, v49 from kind_type as kt, aggView5958632235578963826 where kt.id=aggView5958632235578963826.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin5712555459447697868;
