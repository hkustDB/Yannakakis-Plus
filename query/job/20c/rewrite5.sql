create or replace view aggView5199067121479708523 as select name as v32, id as v31 from name as n;
create or replace view aggJoin2266687391552130419 as (
with aggView2523674479946802896 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView2523674479946802896 where t.kind_id=aggView2523674479946802896.v26 and production_year>2000);
create or replace view aggJoin5950418178396664572 as (
with aggView3332031652435219488 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3332031652435219488 where cc.status_id=aggView3332031652435219488.v7);
create or replace view aggJoin3646786730283252839 as (
with aggView8874268454950620095 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView8874268454950620095 where mk.keyword_id=aggView8874268454950620095.v23);
create or replace view aggJoin7690714662982738550 as (
with aggView2608860237401294624 as (select v40 from aggJoin3646786730283252839 group by v40)
select v40, v41, v44 from aggJoin2266687391552130419 join aggView2608860237401294624 using(v40));
create or replace view aggJoin1774508986871382187 as (
with aggView6536884512377375547 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin5950418178396664572 join aggView6536884512377375547 using(v5));
create or replace view aggJoin162037023312911200 as (
with aggView2827521724566604165 as (select v40 from aggJoin1774508986871382187 group by v40)
select v40, v41, v44 from aggJoin7690714662982738550 join aggView2827521724566604165 using(v40));
create or replace view aggView3254164164351387996 as select v40, v41 from aggJoin162037023312911200 group by v40,v41;
create or replace view aggJoin1014648295080638804 as (
with aggView8786825172826176217 as (select v31, MIN(v32) as v52 from aggView5199067121479708523 group by v31)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView8786825172826176217 where ci.person_id=aggView8786825172826176217.v31);
create or replace view aggJoin5021345116561096581 as (
with aggView1298295914243992649 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin1014648295080638804 join aggView1298295914243992649 using(v9));
create or replace view aggJoin7150153846855121221 as (
with aggView2984493524914000206 as (select v40, MIN(v52) as v52 from aggJoin5021345116561096581 group by v40,v52)
select v41, v52 from aggView3254164164351387996 join aggView2984493524914000206 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin7150153846855121221;
