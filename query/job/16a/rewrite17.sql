create or replace view aggJoin2894855123298383828 as (
with aggView4444653593787950320 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView4444653593787950320 where n.id=aggView4444653593787950320.v2);
create or replace view aggJoin7613199011929206450 as (
with aggView46183914161679723 as (select id as v11, title as v56 from title as t where episode_nr>=50 and episode_nr<100)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView46183914161679723 where ci.movie_id=aggView46183914161679723.v11);
create or replace view aggJoin7251520528902505291 as (
with aggView4706411587454219072 as (select v2, MIN(v55) as v55 from aggJoin2894855123298383828 group by v2,v55)
select v11, v56 as v56, v55 from aggJoin7613199011929206450 join aggView4706411587454219072 using(v2));
create or replace view aggJoin8248437769879714631 as (
with aggView5866106548245261932 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5866106548245261932 where mc.company_id=aggView5866106548245261932.v28);
create or replace view aggJoin7062892953009477159 as (
with aggView4622304773136298647 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4622304773136298647 where mk.keyword_id=aggView4622304773136298647.v33);
create or replace view aggJoin56369750381757892 as (
with aggView7360927062840355070 as (select v11 from aggJoin8248437769879714631 group by v11)
select v11 from aggJoin7062892953009477159 join aggView7360927062840355070 using(v11));
create or replace view aggJoin1746077081075452488 as (
with aggView7876514324242124541 as (select v11 from aggJoin56369750381757892 group by v11)
select v56 as v56, v55 as v55 from aggJoin7251520528902505291 join aggView7876514324242124541 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1746077081075452488;
