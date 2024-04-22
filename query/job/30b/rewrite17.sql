create or replace view aggJoin5588560405171140173 as (
with aggView4496973951723480314 as (select id as v45, title as v60 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000)
select movie_id as v45, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView4496973951723480314 where cc.movie_id=aggView4496973951723480314.v45);
create or replace view aggJoin3156463858232902258 as (
with aggView488154733649822085 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView488154733649822085 where ci.person_id=aggView488154733649822085.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3298755929621522713 as (
with aggView1344744974398598265 as (select v45, MIN(v59) as v59 from aggJoin3156463858232902258 group by v45,v59)
select movie_id as v45, info_type_id as v16, info as v26, v59 from movie_info as mi, aggView1344744974398598265 where mi.movie_id=aggView1344744974398598265.v45 and info IN ('Horror','Thriller'));
create or replace view aggJoin6686680571123592614 as (
with aggView7892068138189458960 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select v45, v5, v60 from aggJoin5588560405171140173 join aggView7892068138189458960 using(v7));
create or replace view aggJoin750246047081661872 as (
with aggView982605837770011581 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView982605837770011581 where mk.keyword_id=aggView982605837770011581.v20);
create or replace view aggJoin6877325845546107332 as (
with aggView8749113537751185800 as (select id as v16 from info_type as it1 where info= 'genres')
select v45, v26, v59 from aggJoin3298755929621522713 join aggView8749113537751185800 using(v16));
create or replace view aggJoin4595120882445567280 as (
with aggView8166704968513803073 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45, v60 from aggJoin6686680571123592614 join aggView8166704968513803073 using(v5));
create or replace view aggJoin5415056966936686494 as (
with aggView331926204967533918 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView331926204967533918 where mi_idx.info_type_id=aggView331926204967533918.v18);
create or replace view aggJoin4517570118631386802 as (
with aggView2782960804011613616 as (select v45, MIN(v31) as v58 from aggJoin5415056966936686494 group by v45)
select v45, v26, v59 as v59, v58 from aggJoin6877325845546107332 join aggView2782960804011613616 using(v45));
create or replace view aggJoin3617683033044573099 as (
with aggView8560303693168678656 as (select v45, MIN(v59) as v59, MIN(v58) as v58, MIN(v26) as v57 from aggJoin4517570118631386802 group by v45,v58,v59)
select v45, v60 as v60, v59, v58, v57 from aggJoin4595120882445567280 join aggView8560303693168678656 using(v45));
create or replace view aggJoin3585444255403144886 as (
with aggView2559514131670613187 as (select v45, MIN(v60) as v60, MIN(v59) as v59, MIN(v58) as v58, MIN(v57) as v57 from aggJoin3617683033044573099 group by v45,v58,v59,v60,v57)
select v60, v59, v58, v57 from aggJoin750246047081661872 join aggView2559514131670613187 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin3585444255403144886;
