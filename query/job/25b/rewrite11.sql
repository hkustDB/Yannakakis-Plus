create or replace view aggJoin3458595974403521581 as (
with aggView487192223751893743 as (select id as v37, title as v52 from title as t where production_year>2010 and title LIKE 'Vampire%')
select movie_id as v37, info_type_id as v10, info as v23, v52 from movie_info_idx as mi_idx, aggView487192223751893743 where mi_idx.movie_id=aggView487192223751893743.v37);
create or replace view aggJoin8517568475147538114 as (
with aggView1804561700603788262 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView1804561700603788262 where ci.person_id=aggView1804561700603788262.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3102201142270077659 as (
with aggView3115491481551977097 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3115491481551977097 where mi.info_type_id=aggView3115491481551977097.v8 and info= 'Horror');
create or replace view aggJoin7726714077969531838 as (
with aggView7831045125547311185 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView7831045125547311185 where mk.keyword_id=aggView7831045125547311185.v12);
create or replace view aggJoin5843353174137420189 as (
with aggView2987898619858727330 as (select v37, MIN(v51) as v51 from aggJoin8517568475147538114 group by v37,v51)
select v37, v18, v51 from aggJoin3102201142270077659 join aggView2987898619858727330 using(v37));
create or replace view aggJoin1024934168141627585 as (
with aggView2389830721602749174 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52 from aggJoin3458595974403521581 join aggView2389830721602749174 using(v10));
create or replace view aggJoin6551703982472113235 as (
with aggView6784434920209407362 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin1024934168141627585 group by v37,v52)
select v37, v18, v51 as v51, v52, v50 from aggJoin5843353174137420189 join aggView6784434920209407362 using(v37));
create or replace view aggJoin8376080000533326192 as (
with aggView5156034624294758083 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v50) as v50, MIN(v18) as v49 from aggJoin6551703982472113235 group by v37,v50,v52,v51)
select v51, v52, v50, v49 from aggJoin7726714077969531838 join aggView5156034624294758083 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin8376080000533326192;
