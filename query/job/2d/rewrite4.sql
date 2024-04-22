create or replace view aggJoin4676449540545851966 as (
with aggView7458250036984721530 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v12 from movie_companies as mc, aggView7458250036984721530 where mc.company_id=aggView7458250036984721530.v1);
create or replace view aggJoin1827129850007260593 as (
with aggView4351763125480467302 as (select v12 from aggJoin4676449540545851966 group by v12)
select id as v12, title as v20 from title as t, aggView4351763125480467302 where t.id=aggView4351763125480467302.v12);
create or replace view aggJoin4144154749223980854 as (
with aggView5019672911432418012 as (select v12, MIN(v20) as v31 from aggJoin1827129850007260593 group by v12)
select keyword_id as v18, v31 from movie_keyword as mk, aggView5019672911432418012 where mk.movie_id=aggView5019672911432418012.v12);
create or replace view aggJoin6409387463887613999 as (
with aggView3939821698187539613 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin4144154749223980854 join aggView3939821698187539613 using(v18));
select MIN(v31) as v31 from aggJoin6409387463887613999;
