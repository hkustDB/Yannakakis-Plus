create or replace view aggJoin1686582379449657612 as (
with aggView6062454242096425102 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView6062454242096425102 where ci.person_id=aggView6062454242096425102.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1577843405044432125 as (
with aggView4055618587604975595 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4055618587604975595 where mi_idx.info_type_id=aggView4055618587604975595.v17);
create or replace view aggJoin1463623121975376422 as (
with aggView2351775931959576854 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2351775931959576854 where mk.keyword_id=aggView2351775931959576854.v19);
create or replace view aggJoin571638354575274935 as (
with aggView8702652228303389287 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView8702652228303389287 where mi.info_type_id=aggView8702652228303389287.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin471895062673602653 as (
with aggView3014612774422666273 as (select v49, MIN(v30) as v61 from aggJoin571638354575274935 group by v49)
select v49, v35, v61 from aggJoin1577843405044432125 join aggView3014612774422666273 using(v49));
create or replace view aggJoin4312668756282687327 as (
with aggView2454204209125478959 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView2454204209125478959 where mc.company_id=aggView2454204209125478959.v8);
create or replace view aggJoin3112670651667842725 as (
with aggView4387581272555951047 as (select v49, MIN(v63) as v63 from aggJoin1686582379449657612 group by v49,v63)
select v49, v35, v61 as v61, v63 from aggJoin471895062673602653 join aggView4387581272555951047 using(v49));
create or replace view aggJoin1203671618160205597 as (
with aggView1428334211670971577 as (select v49, MIN(v61) as v61, MIN(v63) as v63, MIN(v35) as v62 from aggJoin3112670651667842725 group by v49,v61,v63)
select v49, v61, v63, v62 from aggJoin1463623121975376422 join aggView1428334211670971577 using(v49));
create or replace view aggJoin8956274626923124245 as (
with aggView3424668474216928608 as (select v49 from aggJoin4312668756282687327 group by v49)
select id as v49, title as v50 from title as t, aggView3424668474216928608 where t.id=aggView3424668474216928608.v49);
create or replace view aggJoin8953936980641823025 as (
with aggView12856884059137862 as (select v49, MIN(v50) as v64 from aggJoin8956274626923124245 group by v49)
select v61 as v61, v63 as v63, v62 as v62, v64 from aggJoin1203671618160205597 join aggView12856884059137862 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin8953936980641823025;
