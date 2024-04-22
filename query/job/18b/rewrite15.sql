create or replace view aggJoin5770992643970084791 as (
with aggView5483941334412906054 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView5483941334412906054 where ci.person_id=aggView5483941334412906054.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6697767652694219833 as (
with aggView6354644128135042675 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView6354644128135042675 where mi_idx.info_type_id=aggView6354644128135042675.v10 and info>'8.0');
create or replace view aggJoin2363361884353414364 as (
with aggView6548384198007743664 as (select v31, MIN(v20) as v44 from aggJoin6697767652694219833 group by v31)
select id as v31, title as v32, production_year as v35, v44 from title as t, aggView6548384198007743664 where t.id=aggView6548384198007743664.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggJoin8042782535499991359 as (
with aggView5775014358840391021 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin2363361884353414364 group by v31,v44)
select movie_id as v31, info_type_id as v8, info as v15, v44, v45 from movie_info as mi, aggView5775014358840391021 where mi.movie_id=aggView5775014358840391021.v31 and info IN ('Horror','Thriller'));
create or replace view aggJoin9177874148079605014 as (
with aggView6614465529121411073 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v44, v45 from aggJoin8042782535499991359 join aggView6614465529121411073 using(v8));
create or replace view aggJoin1785147929292039991 as (
with aggView4480045518031440622 as (select v31, MIN(v44) as v44, MIN(v45) as v45, MIN(v15) as v43 from aggJoin9177874148079605014 group by v31,v44,v45)
select v44, v45, v43 from aggJoin5770992643970084791 join aggView4480045518031440622 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1785147929292039991;
