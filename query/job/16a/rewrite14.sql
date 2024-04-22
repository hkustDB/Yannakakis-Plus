create or replace view aggJoin3343794367506824301 as (
with aggView7016775181004435463 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7016775181004435463 where mk.keyword_id=aggView7016775181004435463.v33);
create or replace view aggJoin7872796329582417514 as (
with aggView5466414685536559139 as (select v11 from aggJoin3343794367506824301 group by v11)
select person_id as v2, movie_id as v11 from cast_info as ci, aggView5466414685536559139 where ci.movie_id=aggView5466414685536559139.v11);
create or replace view aggJoin1551923151970395755 as (
with aggView492764900664193782 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView492764900664193782 where mc.company_id=aggView492764900664193782.v28);
create or replace view aggJoin3496548953949030262 as (
with aggView2034975090047297694 as (select v11 from aggJoin1551923151970395755 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2034975090047297694 where t.id=aggView2034975090047297694.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggJoin6526120742606502680 as (
with aggView7471763160357970224 as (select v11, MIN(v44) as v56 from aggJoin3496548953949030262 group by v11)
select v2, v56 from aggJoin7872796329582417514 join aggView7471763160357970224 using(v11));
create or replace view aggJoin6496854018379861889 as (
with aggView5109595897973137889 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5109595897973137889 where an.person_id=aggView5109595897973137889.v2);
create or replace view aggJoin8333293288150582432 as (
with aggView7403472104097742508 as (select v2, MIN(v3) as v55 from aggJoin6496854018379861889 group by v2)
select v56 as v56, v55 from aggJoin6526120742606502680 join aggView7403472104097742508 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin8333293288150582432;
