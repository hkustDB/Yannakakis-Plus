create or replace view aggView2159195631214199900 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin5149982538847586473 as (
with aggView4588516280278629759 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4588516280278629759 where mi_idx.info_type_id=aggView4588516280278629759.v23);
create or replace view aggView398847167727145727 as select v33, v47 from aggJoin5149982538847586473 group by v33,v47;
create or replace view aggJoin5054138730619575327 as (
with aggView2617697702553992143 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView2617697702553992143 where t.kind_id=aggView2617697702553992143.v28 and production_year>2000);
create or replace view aggJoin1697819412043321008 as (
with aggView5494366863444768160 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5494366863444768160 where mk.keyword_id=aggView5494366863444768160.v25);
create or replace view aggJoin6100089811161793827 as (
with aggView916770721013162016 as (select v47 from aggJoin1697819412043321008 group by v47)
select v47, v48, v51 from aggJoin5054138730619575327 join aggView916770721013162016 using(v47));
create or replace view aggView7142483425449859712 as select v48, v47 from aggJoin6100089811161793827 group by v48,v47;
create or replace view aggJoin2259227549641358311 as (
with aggView7767057008726485600 as (select v9, MIN(v10) as v59 from aggView2159195631214199900 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView7767057008726485600 where ci.person_role_id=aggView7767057008726485600.v9);
create or replace view aggJoin814204454344252048 as (
with aggView856501243045166276 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView856501243045166276 where cc.status_id=aggView856501243045166276.v7);
create or replace view aggJoin2774335148218919296 as (
with aggView1181979847485430828 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin814204454344252048 join aggView1181979847485430828 using(v5));
create or replace view aggJoin8919402324198424832 as (
with aggView8221544182551323804 as (select v47 from aggJoin2774335148218919296 group by v47)
select v38, v47, v59 as v59 from aggJoin2259227549641358311 join aggView8221544182551323804 using(v47));
create or replace view aggJoin7296685453111269983 as (
with aggView7222037334841267141 as (select id as v38 from name as n)
select v47, v59 from aggJoin8919402324198424832 join aggView7222037334841267141 using(v38));
create or replace view aggJoin8921997448587371984 as (
with aggView5922439807988235157 as (select v47, MIN(v59) as v59 from aggJoin7296685453111269983 group by v47,v59)
select v48, v47, v59 from aggView7142483425449859712 join aggView5922439807988235157 using(v47));
create or replace view aggJoin5793750264034827212 as (
with aggView155869410550074523 as (select v47, MIN(v59) as v59, MIN(v48) as v61 from aggJoin8921997448587371984 group by v47,v59)
select v33, v59, v61 from aggView398847167727145727 join aggView155869410550074523 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin5793750264034827212;
