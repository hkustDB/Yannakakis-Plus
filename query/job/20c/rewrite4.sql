create or replace view aggView4371517915253673495 as select name as v32, id as v31 from name as n;
create or replace view aggJoin3878217809024499161 as (
with aggView9102160292219636557 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView9102160292219636557 where t.kind_id=aggView9102160292219636557.v26 and production_year>2000);
create or replace view aggJoin552706677979197661 as (
with aggView7214405994618685482 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView7214405994618685482 where cc.status_id=aggView7214405994618685482.v7);
create or replace view aggJoin4485337458856859542 as (
with aggView7734362174294747671 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin552706677979197661 join aggView7734362174294747671 using(v5));
create or replace view aggJoin1720557906819575305 as (
with aggView7714173664432059718 as (select v40 from aggJoin4485337458856859542 group by v40)
select v40, v41, v44 from aggJoin3878217809024499161 join aggView7714173664432059718 using(v40));
create or replace view aggView231552981373958418 as select v40, v41 from aggJoin1720557906819575305 group by v40,v41;
create or replace view aggJoin4360720768347743939 as (
with aggView7110023403601733283 as (select v31, MIN(v32) as v52 from aggView4371517915253673495 group by v31)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView7110023403601733283 where ci.person_id=aggView7110023403601733283.v31);
create or replace view aggJoin173972616441570036 as (
with aggView6012979358299210213 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin4360720768347743939 join aggView6012979358299210213 using(v9));
create or replace view aggJoin1540237730197669738 as (
with aggView2285334880721384766 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView2285334880721384766 where mk.keyword_id=aggView2285334880721384766.v23);
create or replace view aggJoin8194212105226512423 as (
with aggView3402095365858090725 as (select v40 from aggJoin1540237730197669738 group by v40)
select v40, v52 as v52 from aggJoin173972616441570036 join aggView3402095365858090725 using(v40));
create or replace view aggJoin9165671447297322261 as (
with aggView6829361632399418081 as (select v40, MIN(v52) as v52 from aggJoin8194212105226512423 group by v40,v52)
select v41, v52 from aggView231552981373958418 join aggView6829361632399418081 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin9165671447297322261;
