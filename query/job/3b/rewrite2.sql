create or replace view aggJoin2447076019202037778 as (
with aggView7298551817543001058 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v12 from movie_keyword as mk, aggView7298551817543001058 where mk.keyword_id=aggView7298551817543001058.v1);
create or replace view aggJoin8609869112981913647 as (
with aggView7028693700709863680 as (select v12 from aggJoin2447076019202037778 group by v12)
select id as v12, title as v13, production_year as v16 from title as t, aggView7028693700709863680 where t.id=aggView7028693700709863680.v12 and production_year>2010);
create or replace view aggJoin427687172453112093 as (
with aggView7684293247491341824 as (select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id)
select v13, v16 from aggJoin8609869112981913647 join aggView7684293247491341824 using(v12));
create or replace view aggView7190949238285776078 as select v13 from aggJoin427687172453112093 group by v13;
select MIN(v13) as v24 from aggView7190949238285776078;
