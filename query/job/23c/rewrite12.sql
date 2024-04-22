create or replace view aggJoin5361684428202019250 as (
with aggView186252426305896843 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView186252426305896843 where t.kind_id=aggView186252426305896843.v21 and production_year>1990);
create or replace view aggJoin1394523218751215217 as (
with aggView7572412098461205572 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView7572412098461205572 where mi.info_type_id=aggView7572412098461205572.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2186248967151983592 as (
with aggView64902422810148669 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView64902422810148669 where mc.company_type_id=aggView64902422810148669.v14);
create or replace view aggJoin8624344209589521595 as (
with aggView9063703510174247819 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView9063703510174247819 where mk.keyword_id=aggView9063703510174247819.v18);
create or replace view aggJoin5960696177837151125 as (
with aggView7628828509291244120 as (select v36 from aggJoin1394523218751215217 group by v36)
select movie_id as v36, status_id as v5 from complete_cast as cc, aggView7628828509291244120 where cc.movie_id=aggView7628828509291244120.v36);
create or replace view aggJoin4637378524299441606 as (
with aggView1063146291216020806 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2186248967151983592 join aggView1063146291216020806 using(v7));
create or replace view aggJoin2792058846484463285 as (
with aggView7654699624902514720 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36 from aggJoin5960696177837151125 join aggView7654699624902514720 using(v5));
create or replace view aggJoin6351171526708778643 as (
with aggView2579532969627208245 as (select v36 from aggJoin4637378524299441606 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin5361684428202019250 join aggView2579532969627208245 using(v36));
create or replace view aggJoin1016164837810635280 as (
with aggView5658211070644994104 as (select v36 from aggJoin2792058846484463285 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin6351171526708778643 join aggView5658211070644994104 using(v36));
create or replace view aggJoin6016222876580984282 as (
with aggView802872319819508629 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin1016164837810635280 group by v36,v48)
select v48, v49 from aggJoin8624344209589521595 join aggView802872319819508629 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin6016222876580984282;
