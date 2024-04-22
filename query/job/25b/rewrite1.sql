create or replace view aggView8875477496154264197 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin6921705867102216620 as (
with aggView7024879568975179718 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView7024879568975179718 where v38 LIKE 'Vampire%');
create or replace view aggJoin7065698045170178565 as (
with aggView5021090516856714079 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView5021090516856714079 where mi.info_type_id=aggView5021090516856714079.v8 and info= 'Horror');
create or replace view aggView4834361185592003077 as select v18, v37 from aggJoin7065698045170178565 group by v18,v37;
create or replace view aggJoin8116070735582059372 as (
with aggView1299618349727410268 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView1299618349727410268 where mk.keyword_id=aggView1299618349727410268.v12);
create or replace view aggJoin6671857115548368945 as (
with aggView3486792978608415739 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView3486792978608415739 where mi_idx.info_type_id=aggView3486792978608415739.v10);
create or replace view aggJoin3074286711652242782 as (
with aggView4157459582160555769 as (select v37 from aggJoin8116070735582059372 group by v37)
select v37, v23 from aggJoin6671857115548368945 join aggView4157459582160555769 using(v37));
create or replace view aggView5467045971895074071 as select v23, v37 from aggJoin3074286711652242782 group by v23,v37;
create or replace view aggJoin6609391944862777585 as (
with aggView6858616100563219024 as (select v37, MIN(v18) as v49 from aggView4834361185592003077 group by v37)
select person_id as v28, movie_id as v37, note as v5, v49 from cast_info as ci, aggView6858616100563219024 where ci.movie_id=aggView6858616100563219024.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6431865640207025202 as (
with aggView7260664927790683808 as (select v28, MIN(v29) as v51 from aggView8875477496154264197 group by v28)
select v37, v5, v49 as v49, v51 from aggJoin6609391944862777585 join aggView7260664927790683808 using(v28));
create or replace view aggJoin2070391533082600079 as (
with aggView7946175382602235332 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin6431865640207025202 group by v37,v51,v49)
select v23, v37, v49, v51 from aggView5467045971895074071 join aggView7946175382602235332 using(v37));
create or replace view aggJoin3556762188134609894 as (
with aggView5153192995728230089 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v23) as v50 from aggJoin2070391533082600079 group by v37,v51,v49)
select v38, v49, v51, v50 from aggJoin6921705867102216620 join aggView5153192995728230089 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin3556762188134609894;
