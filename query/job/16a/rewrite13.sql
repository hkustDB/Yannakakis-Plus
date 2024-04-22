create or replace view aggJoin842042891598362862 as (
with aggView7493429440910043498 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView7493429440910043498 where ci.person_id=aggView7493429440910043498.v2);
create or replace view aggJoin3775985746416895876 as (
with aggView7419982843213736908 as (select id as v2 from name as n)
select v11, v55 from aggJoin842042891598362862 join aggView7419982843213736908 using(v2));
create or replace view aggJoin1747211149107364157 as (
with aggView6823279367304173339 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6823279367304173339 where mk.keyword_id=aggView6823279367304173339.v33);
create or replace view aggJoin8973899709191461139 as (
with aggView6071700882246626426 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6071700882246626426 where mc.company_id=aggView6071700882246626426.v28);
create or replace view aggJoin6513444467252815070 as (
with aggView388746945407544206 as (select v11 from aggJoin1747211149107364157 group by v11)
select v11 from aggJoin8973899709191461139 join aggView388746945407544206 using(v11));
create or replace view aggJoin1658923836005911389 as (
with aggView2670887122659763159 as (select v11 from aggJoin6513444467252815070 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2670887122659763159 where t.id=aggView2670887122659763159.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggJoin5250557005343890260 as (
with aggView7986586586858734763 as (select v11, MIN(v44) as v56 from aggJoin1658923836005911389 group by v11)
select v55 as v55, v56 from aggJoin3775985746416895876 join aggView7986586586858734763 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin5250557005343890260;
