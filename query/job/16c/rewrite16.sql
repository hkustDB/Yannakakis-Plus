create or replace view aggJoin8303097205883365201 as (
with aggView3103990192406221861 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView3103990192406221861 where n.id=aggView3103990192406221861.v2);
create or replace view aggJoin129669448794240204 as (
with aggView975599662032295584 as (select id as v11, title as v56 from title as t where episode_nr<100)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView975599662032295584 where mk.movie_id=aggView975599662032295584.v11);
create or replace view aggJoin4216979303376048099 as (
with aggView6843967986365191021 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin129669448794240204 join aggView6843967986365191021 using(v33));
create or replace view aggJoin7074714908437064478 as (
with aggView8985361617414620014 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8985361617414620014 where mc.company_id=aggView8985361617414620014.v28);
create or replace view aggJoin4386930252358796152 as (
with aggView7085424455945926007 as (select v11 from aggJoin7074714908437064478 group by v11)
select person_id as v2, movie_id as v11 from cast_info as ci, aggView7085424455945926007 where ci.movie_id=aggView7085424455945926007.v11);
create or replace view aggJoin1231953676396912002 as (
with aggView7941325886867383639 as (select v11, MIN(v56) as v56 from aggJoin4216979303376048099 group by v11,v56)
select v2, v56 from aggJoin4386930252358796152 join aggView7941325886867383639 using(v11));
create or replace view aggJoin2074920552951650256 as (
with aggView8946226730577831552 as (select v2, MIN(v55) as v55 from aggJoin8303097205883365201 group by v2,v55)
select v56 as v56, v55 from aggJoin1231953676396912002 join aggView8946226730577831552 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin2074920552951650256;
