create or replace view aggJoin1364126745742948980 as (
with aggView1477040362180838858 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView1477040362180838858 where ci.person_id=aggView1477040362180838858.v2);
create or replace view aggJoin2344121337358050992 as (
with aggView6452725499399564288 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6452725499399564288 where mk.keyword_id=aggView6452725499399564288.v33);
create or replace view aggJoin3981485367024668181 as (
with aggView7241796960732175488 as (select v11 from aggJoin2344121337358050992 group by v11)
select movie_id as v11, company_id as v28 from movie_companies as mc, aggView7241796960732175488 where mc.movie_id=aggView7241796960732175488.v11);
create or replace view aggJoin589800856631749080 as (
with aggView8729947670697245348 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11 from aggJoin3981485367024668181 join aggView8729947670697245348 using(v28));
create or replace view aggJoin2853402309492246777 as (
with aggView2767150571269176827 as (select v11 from aggJoin589800856631749080 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2767150571269176827 where t.id=aggView2767150571269176827.v11 and episode_nr<100);
create or replace view aggJoin7790775282126142181 as (
with aggView4250783578800017257 as (select v11, MIN(v44) as v56 from aggJoin2853402309492246777 group by v11)
select v2, v55 as v55, v56 from aggJoin1364126745742948980 join aggView4250783578800017257 using(v11));
create or replace view aggJoin8832484549262701671 as (
with aggView1456860230971493962 as (select id as v2 from name as n)
select v55, v56 from aggJoin7790775282126142181 join aggView1456860230971493962 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin8832484549262701671;
