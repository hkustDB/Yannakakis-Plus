create or replace view aggJoin7238767282248425180 as (
with aggView6293316145458022191 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6293316145458022191 where mc.company_id=aggView6293316145458022191.v28);
create or replace view aggJoin8099328036018093275 as (
with aggView2872763980413621763 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView2872763980413621763 where mk.keyword_id=aggView2872763980413621763.v33);
create or replace view aggJoin266976210900640038 as (
with aggView7611881034325549477 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView7611881034325549477 where an.person_id=aggView7611881034325549477.v2);
create or replace view aggJoin4061304576477199283 as (
with aggView4503852963986024629 as (select v2, MIN(v3) as v55 from aggJoin266976210900640038 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView4503852963986024629 where ci.person_id=aggView4503852963986024629.v2);
create or replace view aggJoin3840238398485299867 as (
with aggView8411589720571550591 as (select v11 from aggJoin8099328036018093275 group by v11)
select id as v11, title as v44 from title as t, aggView8411589720571550591 where t.id=aggView8411589720571550591.v11);
create or replace view aggJoin4750808623566963986 as (
with aggView4505303047441174309 as (select v11, MIN(v44) as v56 from aggJoin3840238398485299867 group by v11)
select v11, v55 as v55, v56 from aggJoin4061304576477199283 join aggView4505303047441174309 using(v11));
create or replace view aggJoin3329416717388400893 as (
with aggView5525231697131130074 as (select v11 from aggJoin7238767282248425180 group by v11)
select v55 as v55, v56 as v56 from aggJoin4750808623566963986 join aggView5525231697131130074 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin3329416717388400893;
