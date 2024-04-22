create or replace view aggView1090239044618077745 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggView3979224023231699021 as select title as v46, id as v45 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view aggJoin7076233212659352881 as (
with aggView3661195920905296599 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3661195920905296599 where cc.status_id=aggView3661195920905296599.v7);
create or replace view aggJoin8648007098532844653 as (
with aggView3598493725060784033 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView3598493725060784033 where mi.info_type_id=aggView3598493725060784033.v16);
create or replace view aggJoin3287513576898808301 as (
with aggView6907951022233213752 as (select v26, v45 from aggJoin8648007098532844653 group by v26,v45)
select v45, v26 from aggView6907951022233213752 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin6546200349715940981 as (
with aggView8125846938357823422 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin7076233212659352881 join aggView8125846938357823422 using(v5));
create or replace view aggJoin5162945656396223650 as (
with aggView5883943654471092128 as (select v45 from aggJoin6546200349715940981 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView5883943654471092128 where mi_idx.movie_id=aggView5883943654471092128.v45);
create or replace view aggJoin3306650036289154316 as (
with aggView408996123346169546 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin5162945656396223650 join aggView408996123346169546 using(v18));
create or replace view aggView2821521347422467766 as select v31, v45 from aggJoin3306650036289154316 group by v31,v45;
create or replace view aggJoin3539699979470008308 as (
with aggView7761508449171420866 as (select v45, MIN(v31) as v58 from aggView2821521347422467766 group by v45)
select person_id as v36, movie_id as v45, note as v13, v58 from cast_info as ci, aggView7761508449171420866 where ci.movie_id=aggView7761508449171420866.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3922118262413920413 as (
with aggView8354329420821466132 as (select v36, MIN(v37) as v59 from aggView1090239044618077745 group by v36)
select v45, v13, v58 as v58, v59 from aggJoin3539699979470008308 join aggView8354329420821466132 using(v36));
create or replace view aggJoin4089125908621809906 as (
with aggView6373503643531834904 as (select v45, MIN(v46) as v60 from aggView3979224023231699021 group by v45)
select v45, v13, v58 as v58, v59 as v59, v60 from aggJoin3922118262413920413 join aggView6373503643531834904 using(v45));
create or replace view aggJoin2041485636058474130 as (
with aggView5008270500177756469 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView5008270500177756469 where mk.keyword_id=aggView5008270500177756469.v20);
create or replace view aggJoin726906113784215079 as (
with aggView5814385830382995945 as (select v45 from aggJoin2041485636058474130 group by v45)
select v45, v13, v58 as v58, v59 as v59, v60 as v60 from aggJoin4089125908621809906 join aggView5814385830382995945 using(v45));
create or replace view aggJoin1905569718687574171 as (
with aggView6323857013613586012 as (select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v60) as v60 from aggJoin726906113784215079 group by v45,v58,v59,v60)
select v26, v58, v59, v60 from aggJoin3287513576898808301 join aggView6323857013613586012 using(v45));
select MIN(v26) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1905569718687574171;
