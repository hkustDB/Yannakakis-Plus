create or replace view aggJoin3076092560212898623 as (
with aggView4433953318767353278 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4433953318767353278 where ci.person_role_id=aggView4433953318767353278.v9);
create or replace view aggJoin7577728133075340992 as (
with aggView8579273073882952052 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView8579273073882952052 where t.kind_id=aggView8579273073882952052.v28 and production_year>2005);
create or replace view aggJoin144156075916851031 as (
with aggView4517748872193721823 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView4517748872193721823 where mk.keyword_id=aggView4517748872193721823.v25);
create or replace view aggJoin8761369294590057297 as (
with aggView5348702217167520600 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5348702217167520600 where mi_idx.info_type_id=aggView5348702217167520600.v23 and info>'8.0');
create or replace view aggJoin317949719708969630 as (
with aggView6638903652876045969 as (select v47, MIN(v33) as v60 from aggJoin8761369294590057297 group by v47)
select v47, v48, v51, v60 from aggJoin7577728133075340992 join aggView6638903652876045969 using(v47));
create or replace view aggJoin758676042001529960 as (
with aggView6578271553345239653 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView6578271553345239653 where cc.status_id=aggView6578271553345239653.v7);
create or replace view aggJoin3980530718305651342 as (
with aggView8013969878274537067 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin758676042001529960 join aggView8013969878274537067 using(v5));
create or replace view aggJoin5564964395045890208 as (
with aggView4939135327814041499 as (select v47 from aggJoin3980530718305651342 group by v47)
select v47 from aggJoin144156075916851031 join aggView4939135327814041499 using(v47));
create or replace view aggJoin1945197787551956575 as (
with aggView4289608599684541172 as (select v47 from aggJoin5564964395045890208 group by v47)
select v47, v48, v51, v60 as v60 from aggJoin317949719708969630 join aggView4289608599684541172 using(v47));
create or replace view aggJoin3075736300050474380 as (
with aggView7236861486309425972 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin1945197787551956575 group by v47,v60)
select v38, v59 as v59, v60, v61 from aggJoin3076092560212898623 join aggView7236861486309425972 using(v47));
create or replace view aggJoin8543749806048711666 as (
with aggView2445814434444772895 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin3075736300050474380 join aggView2445814434444772895 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8543749806048711666;
