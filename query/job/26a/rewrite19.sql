create or replace view aggJoin256642898933731823 as (
with aggView8265954336672720964 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView8265954336672720964 where ci.person_role_id=aggView8265954336672720964.v9);
create or replace view aggJoin6016468433502822171 as (
with aggView8684501516879758108 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin256642898933731823 join aggView8684501516879758108 using(v38));
create or replace view aggJoin9007637589020568282 as (
with aggView4289422193227164311 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4289422193227164311 where t.kind_id=aggView4289422193227164311.v28 and production_year>2000);
create or replace view aggJoin7692451286318199460 as (
with aggView154364847522504701 as (select v47, MIN(v48) as v62 from aggJoin9007637589020568282 group by v47)
select v47, v59 as v59, v61 as v61, v62 from aggJoin6016468433502822171 join aggView154364847522504701 using(v47));
create or replace view aggJoin7895494187307485325 as (
with aggView2799368902874045645 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView2799368902874045645 where mi_idx.info_type_id=aggView2799368902874045645.v23 and info>'7.0');
create or replace view aggJoin2585884062003143118 as (
with aggView7687547762781976053 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView7687547762781976053 where cc.subject_id=aggView7687547762781976053.v5);
create or replace view aggJoin7501141227591809672 as (
with aggView2777546954115177398 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin2585884062003143118 join aggView2777546954115177398 using(v7));
create or replace view aggJoin6165488730862494701 as (
with aggView825549341266866169 as (select v47 from aggJoin7501141227591809672 group by v47)
select v47, v59 as v59, v61 as v61, v62 as v62 from aggJoin7692451286318199460 join aggView825549341266866169 using(v47));
create or replace view aggJoin8122764412709305170 as (
with aggView9197203074177315656 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView9197203074177315656 where mk.keyword_id=aggView9197203074177315656.v25);
create or replace view aggJoin4683636918554513519 as (
with aggView361740973139275589 as (select v47 from aggJoin8122764412709305170 group by v47)
select v47, v33 from aggJoin7895494187307485325 join aggView361740973139275589 using(v47));
create or replace view aggJoin7890391141466369649 as (
with aggView6315920798153114202 as (select v47, MIN(v33) as v60 from aggJoin4683636918554513519 group by v47)
select v59 as v59, v61 as v61, v62 as v62, v60 from aggJoin6165488730862494701 join aggView6315920798153114202 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin7890391141466369649;
