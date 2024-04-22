create or replace view aggJoin7174406125579540348 as (
with aggView4504502183735924798 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4504502183735924798 where ci.person_role_id=aggView4504502183735924798.v9);
create or replace view aggJoin6105222302127233490 as (
with aggView2090668657657309909 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView2090668657657309909 where cc.status_id=aggView2090668657657309909.v7);
create or replace view aggJoin4110720253496955405 as (
with aggView1371045964681069485 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin6105222302127233490 join aggView1371045964681069485 using(v5));
create or replace view aggJoin5507982923988845441 as (
with aggView4558396175581066189 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4558396175581066189 where mi_idx.info_type_id=aggView4558396175581066189.v23);
create or replace view aggJoin6455470011851961920 as (
with aggView1262265362582149968 as (select v47, MIN(v33) as v60 from aggJoin5507982923988845441 group by v47)
select id as v47, title as v48, kind_id as v28, production_year as v51, v60 from title as t, aggView1262265362582149968 where t.id=aggView1262265362582149968.v47 and production_year>2000);
create or replace view aggJoin7026229092383102359 as (
with aggView1432819292001126578 as (select id as v28 from kind_type as kt where kind= 'movie')
select v47, v48, v51, v60 from aggJoin6455470011851961920 join aggView1432819292001126578 using(v28));
create or replace view aggJoin7021189180302809362 as (
with aggView5466508728324150628 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin7026229092383102359 group by v47,v60)
select v38, v47, v59 as v59, v60, v61 from aggJoin7174406125579540348 join aggView5466508728324150628 using(v47));
create or replace view aggJoin3021844579819301635 as (
with aggView2685216461728255097 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView2685216461728255097 where mk.keyword_id=aggView2685216461728255097.v25);
create or replace view aggJoin3452824982027118371 as (
with aggView1191629687727160752 as (select v47 from aggJoin3021844579819301635 group by v47)
select v38, v47, v59 as v59, v60 as v60, v61 as v61 from aggJoin7021189180302809362 join aggView1191629687727160752 using(v47));
create or replace view aggJoin6024584418757232023 as (
with aggView8749350185541121915 as (select v47 from aggJoin4110720253496955405 group by v47)
select v38, v59 as v59, v60 as v60, v61 as v61 from aggJoin3452824982027118371 join aggView8749350185541121915 using(v47));
create or replace view aggJoin6945032326464403009 as (
with aggView8195143050546757640 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin6024584418757232023 join aggView8195143050546757640 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6945032326464403009;
