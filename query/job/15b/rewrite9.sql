create or replace view aggView5080069504017202587 as select id as v40, title as v41 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin2888649191020983448 as (
with aggView3153961423396848388 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3153961423396848388 where mi.info_type_id=aggView3153961423396848388.v22 and note LIKE '%internet%');
create or replace view aggJoin1552906461483032098 as (
with aggView8532342517347431977 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8532342517347431977 where mc.company_id=aggView8532342517347431977.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin8269319744597390982 as (
with aggView9118147437747423944 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin1552906461483032098 join aggView9118147437747423944 using(v20));
create or replace view aggJoin7549819532647430251 as (
with aggView5210794031264822934 as (select v40 from aggJoin8269319744597390982 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView5210794031264822934 where aka_t.movie_id=aggView5210794031264822934.v40);
create or replace view aggJoin1937361798451091554 as (
with aggView442112244778176865 as (select v40 from aggJoin7549819532647430251 group by v40)
select v40, v35, v36 from aggJoin2888649191020983448 join aggView442112244778176865 using(v40));
create or replace view aggJoin2937298680931312417 as (
with aggView5623436297954814653 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5623436297954814653 where mk.keyword_id=aggView5623436297954814653.v24);
create or replace view aggJoin4043885294045553875 as (
with aggView7521937811510953978 as (select v40 from aggJoin2937298680931312417 group by v40)
select v40, v35, v36 from aggJoin1937361798451091554 join aggView7521937811510953978 using(v40));
create or replace view aggJoin8065944671122620332 as (
with aggView939767902972526823 as (select v40, v35 from aggJoin4043885294045553875 group by v40,v35)
select v40, v35 from aggView939767902972526823 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin5537611871649275205 as (
with aggView7886793254834394292 as (select v40, MIN(v35) as v52 from aggJoin8065944671122620332 group by v40)
select v41, v52 from aggView5080069504017202587 join aggView7886793254834394292 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin5537611871649275205;
