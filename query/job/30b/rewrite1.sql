create or replace view aggView4669982233673061244 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggView5694343016442971128 as select title as v46, id as v45 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view aggJoin2271836112142348271 as (
with aggView3813101206120894943 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3813101206120894943 where cc.status_id=aggView3813101206120894943.v7);
create or replace view aggJoin4589826566721787941 as (
with aggView673373138011435589 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView673373138011435589 where mi.info_type_id=aggView673373138011435589.v16);
create or replace view aggJoin2190500637290787486 as (
with aggView4697695521582864147 as (select v26, v45 from aggJoin4589826566721787941 group by v26,v45)
select v45, v26 from aggView4697695521582864147 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin6191996753166874180 as (
with aggView850235289118977518 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin2271836112142348271 join aggView850235289118977518 using(v5));
create or replace view aggJoin2218442753199772468 as (
with aggView2963237252677136740 as (select v45 from aggJoin6191996753166874180 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView2963237252677136740 where mi_idx.movie_id=aggView2963237252677136740.v45);
create or replace view aggJoin1384013914186931454 as (
with aggView3534724808344077137 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin2218442753199772468 join aggView3534724808344077137 using(v18));
create or replace view aggView9081310603794093718 as select v31, v45 from aggJoin1384013914186931454 group by v31,v45;
create or replace view aggJoin7744936769944367013 as (
with aggView9161487136146458204 as (select v36, MIN(v37) as v59 from aggView4669982233673061244 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView9161487136146458204 where ci.person_id=aggView9161487136146458204.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3938112648244243552 as (
with aggView80426867226876066 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView80426867226876066 where mk.keyword_id=aggView80426867226876066.v20);
create or replace view aggJoin3307815854819408132 as (
with aggView3810484183627085962 as (select v45 from aggJoin3938112648244243552 group by v45)
select v45, v13, v59 as v59 from aggJoin7744936769944367013 join aggView3810484183627085962 using(v45));
create or replace view aggJoin1013651591766691317 as (
with aggView7998035117881940106 as (select v45, MIN(v59) as v59 from aggJoin3307815854819408132 group by v45,v59)
select v31, v45, v59 from aggView9081310603794093718 join aggView7998035117881940106 using(v45));
create or replace view aggJoin6979641206604055943 as (
with aggView2025417685234356714 as (select v45, MIN(v59) as v59, MIN(v31) as v58 from aggJoin1013651591766691317 group by v45,v59)
select v45, v26, v59, v58 from aggJoin2190500637290787486 join aggView2025417685234356714 using(v45));
create or replace view aggJoin5553830159019101734 as (
with aggView6703256423757674319 as (select v45, MIN(v59) as v59, MIN(v58) as v58, MIN(v26) as v57 from aggJoin6979641206604055943 group by v45,v58,v59)
select v46, v59, v58, v57 from aggView5694343016442971128 join aggView6703256423757674319 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin5553830159019101734;
