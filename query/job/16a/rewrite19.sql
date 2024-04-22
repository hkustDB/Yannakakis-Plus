create or replace view aggJoin4783266075554659379 as (
with aggView4948771420475450042 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView4948771420475450042 where ci.person_id=aggView4948771420475450042.v2);
create or replace view aggJoin1839736583859188701 as (
with aggView1209093813029346181 as (select id as v2 from name as n)
select v11, v55 from aggJoin4783266075554659379 join aggView1209093813029346181 using(v2));
create or replace view aggJoin353683661099094445 as (
with aggView4512896821528962941 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4512896821528962941 where mk.keyword_id=aggView4512896821528962941.v33);
create or replace view aggJoin8068991389718158768 as (
with aggView7460734234701743302 as (select v11 from aggJoin353683661099094445 group by v11)
select v11, v55 as v55 from aggJoin1839736583859188701 join aggView7460734234701743302 using(v11));
create or replace view aggJoin9213672994687001792 as (
with aggView3660801109048674688 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView3660801109048674688 where mc.company_id=aggView3660801109048674688.v28);
create or replace view aggJoin4408590069342864874 as (
with aggView2402021164628315244 as (select v11 from aggJoin9213672994687001792 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2402021164628315244 where t.id=aggView2402021164628315244.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggJoin206548694496496435 as (
with aggView475506901896970722 as (select v11, MIN(v44) as v56 from aggJoin4408590069342864874 group by v11)
select v55 as v55, v56 from aggJoin8068991389718158768 join aggView475506901896970722 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin206548694496496435;
