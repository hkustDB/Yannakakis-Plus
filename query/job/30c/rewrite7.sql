create or replace view aggView7038305525103743298 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin725238013319125455 as (
with aggView542736495486048726 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView542736495486048726 where mk.keyword_id=aggView542736495486048726.v20);
create or replace view aggJoin4151374789107991188 as (
with aggView3204151453213526329 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3204151453213526329 where cc.status_id=aggView3204151453213526329.v7);
create or replace view aggJoin432422597481856667 as (
with aggView7958043959426673728 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView7958043959426673728 where mi.info_type_id=aggView7958043959426673728.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView9122078357829973210 as select v45, v26 from aggJoin432422597481856667 group by v45,v26;
create or replace view aggJoin1906256332007777689 as (
with aggView2437363824841946008 as (select v45 from aggJoin725238013319125455 group by v45)
select v45, v5 from aggJoin4151374789107991188 join aggView2437363824841946008 using(v45));
create or replace view aggJoin1898977435713313608 as (
with aggView4027113693004365845 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin1906256332007777689 join aggView4027113693004365845 using(v5));
create or replace view aggJoin781708151967164679 as (
with aggView6196173741016673054 as (select v45 from aggJoin1898977435713313608 group by v45)
select id as v45, title as v46 from title as t, aggView6196173741016673054 where t.id=aggView6196173741016673054.v45);
create or replace view aggView5145249759905460829 as select v45, v46 from aggJoin781708151967164679 group by v45,v46;
create or replace view aggJoin293759599213392195 as (
with aggView7510202177235466526 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView7510202177235466526 where mi_idx.info_type_id=aggView7510202177235466526.v18);
create or replace view aggView2049760877109840612 as select v45, v31 from aggJoin293759599213392195 group by v45,v31;
create or replace view aggJoin159009446997121225 as (
with aggView3087802487555028720 as (select v45, MIN(v46) as v60 from aggView5145249759905460829 group by v45)
select v45, v26, v60 from aggView9122078357829973210 join aggView3087802487555028720 using(v45));
create or replace view aggJoin3599941599055107373 as (
with aggView4009911907427840277 as (select v45, MIN(v60) as v60, MIN(v26) as v57 from aggJoin159009446997121225 group by v45,v60)
select person_id as v36, movie_id as v45, note as v13, v60, v57 from cast_info as ci, aggView4009911907427840277 where ci.movie_id=aggView4009911907427840277.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3141941674113363795 as (
with aggView3792022237155214794 as (select v36, MIN(v37) as v59 from aggView7038305525103743298 group by v36)
select v45, v13, v60 as v60, v57 as v57, v59 from aggJoin3599941599055107373 join aggView3792022237155214794 using(v36));
create or replace view aggJoin783699919766667558 as (
with aggView3466211359588262151 as (select v45, MIN(v60) as v60, MIN(v57) as v57, MIN(v59) as v59 from aggJoin3141941674113363795 group by v45,v59,v57,v60)
select v31, v60, v57, v59 from aggView2049760877109840612 join aggView3466211359588262151 using(v45));
select MIN(v57) as v57,MIN(v31) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin783699919766667558;
