create or replace view aggJoin459830330656707409 as (
with aggView6075141542055021151 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView6075141542055021151 where ci.person_role_id=aggView6075141542055021151.v9);
create or replace view aggJoin9069641264279234144 as (
with aggView2997095848350463572 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView2997095848350463572 where cc.status_id=aggView2997095848350463572.v7);
create or replace view aggJoin3164839362875458232 as (
with aggView2339409693408544654 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin9069641264279234144 join aggView2339409693408544654 using(v5));
create or replace view aggJoin8232832592445679842 as (
with aggView1111262094408221750 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView1111262094408221750 where mi_idx.info_type_id=aggView1111262094408221750.v23);
create or replace view aggJoin802761940071498386 as (
with aggView6847172540364011607 as (select v47, MIN(v33) as v60 from aggJoin8232832592445679842 group by v47)
select movie_id as v47, keyword_id as v25, v60 from movie_keyword as mk, aggView6847172540364011607 where mk.movie_id=aggView6847172540364011607.v47);
create or replace view aggJoin5704151066232914389 as (
with aggView496571896052669638 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView496571896052669638 where t.kind_id=aggView496571896052669638.v28 and production_year>2000);
create or replace view aggJoin2606470303174388313 as (
with aggView1353234480985292874 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v60 from aggJoin802761940071498386 join aggView1353234480985292874 using(v25));
create or replace view aggJoin4744718407797965198 as (
with aggView6507537988759808641 as (select v47, MIN(v60) as v60 from aggJoin2606470303174388313 group by v47,v60)
select v47, v48, v51, v60 from aggJoin5704151066232914389 join aggView6507537988759808641 using(v47));
create or replace view aggJoin1736936565645563758 as (
with aggView4326376138274510038 as (select v47 from aggJoin3164839362875458232 group by v47)
select v47, v48, v51, v60 as v60 from aggJoin4744718407797965198 join aggView4326376138274510038 using(v47));
create or replace view aggJoin8422837282968711976 as (
with aggView6835368182637069430 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin1736936565645563758 group by v47,v60)
select v38, v59 as v59, v60, v61 from aggJoin459830330656707409 join aggView6835368182637069430 using(v47));
create or replace view aggJoin3844116511934967920 as (
with aggView1818835501411806280 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin8422837282968711976 join aggView1818835501411806280 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3844116511934967920;
