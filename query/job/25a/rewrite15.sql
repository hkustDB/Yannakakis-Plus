create or replace view aggJoin7411391954850880135 as (
with aggView1446855402685606569 as (select id as v37, title as v52 from title as t)
select movie_id as v37, info_type_id as v8, info as v18, v52 from movie_info as mi, aggView1446855402685606569 where mi.movie_id=aggView1446855402685606569.v37 and info= 'Horror');
create or replace view aggJoin4779363144960467684 as (
with aggView2223743071940331406 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2223743071940331406 where ci.person_id=aggView2223743071940331406.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2317892722447613284 as (
with aggView5669633167531306178 as (select v37, MIN(v51) as v51 from aggJoin4779363144960467684 group by v37,v51)
select movie_id as v37, keyword_id as v12, v51 from movie_keyword as mk, aggView5669633167531306178 where mk.movie_id=aggView5669633167531306178.v37);
create or replace view aggJoin965247155054385869 as (
with aggView4146276393350685171 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView4146276393350685171 where mi_idx.info_type_id=aggView4146276393350685171.v10);
create or replace view aggJoin5306639685943175726 as (
with aggView3978576356011273011 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v51 from aggJoin2317892722447613284 join aggView3978576356011273011 using(v12));
create or replace view aggJoin3757590837041627944 as (
with aggView8901782033916121320 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v52 from aggJoin7411391954850880135 join aggView8901782033916121320 using(v8));
create or replace view aggJoin4952725622638607443 as (
with aggView7707604323516152878 as (select v37, MIN(v52) as v52, MIN(v18) as v49 from aggJoin3757590837041627944 group by v37,v52)
select v37, v23, v52, v49 from aggJoin965247155054385869 join aggView7707604323516152878 using(v37));
create or replace view aggJoin4513052214251676374 as (
with aggView6430478847504343684 as (select v37, MIN(v52) as v52, MIN(v49) as v49, MIN(v23) as v50 from aggJoin4952725622638607443 group by v37,v49,v52)
select v51 as v51, v52, v49, v50 from aggJoin5306639685943175726 join aggView6430478847504343684 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin4513052214251676374;
