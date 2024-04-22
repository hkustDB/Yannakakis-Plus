create or replace view aggJoin2851513413949723713 as (
with aggView4325958180046519000 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4325958180046519000 where ci.person_role_id=aggView4325958180046519000.v9);
create or replace view aggJoin6572325997151160261 as (
with aggView9067005275336457446 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView9067005275336457446 where cc.status_id=aggView9067005275336457446.v7);
create or replace view aggJoin459423265589461187 as (
with aggView5650631048240144014 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin6572325997151160261 join aggView5650631048240144014 using(v5));
create or replace view aggJoin2776286075772797970 as (
with aggView6144177651347479836 as (select v47 from aggJoin459423265589461187 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView6144177651347479836 where mk.movie_id=aggView6144177651347479836.v47);
create or replace view aggJoin883191933117579959 as (
with aggView5662604531505492785 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5662604531505492785 where mi_idx.info_type_id=aggView5662604531505492785.v23);
create or replace view aggJoin8099263569625500454 as (
with aggView2402659803190003671 as (select v47, MIN(v33) as v60 from aggJoin883191933117579959 group by v47)
select v38, v47, v59 as v59, v60 from aggJoin2851513413949723713 join aggView2402659803190003671 using(v47));
create or replace view aggJoin2812091936554439662 as (
with aggView4014358739468837958 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4014358739468837958 where t.kind_id=aggView4014358739468837958.v28 and production_year>2000);
create or replace view aggJoin3194398023190664431 as (
with aggView4688602076356775470 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47 from aggJoin2776286075772797970 join aggView4688602076356775470 using(v25));
create or replace view aggJoin5841643203746122333 as (
with aggView7108298528546289138 as (select v47 from aggJoin3194398023190664431 group by v47)
select v47, v48, v51 from aggJoin2812091936554439662 join aggView7108298528546289138 using(v47));
create or replace view aggJoin8310498410908672989 as (
with aggView192903027847549446 as (select v47, MIN(v48) as v61 from aggJoin5841643203746122333 group by v47)
select v38, v59 as v59, v60 as v60, v61 from aggJoin8099263569625500454 join aggView192903027847549446 using(v47));
create or replace view aggJoin3770266772552458681 as (
with aggView1327194562423717555 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin8310498410908672989 join aggView1327194562423717555 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3770266772552458681;
