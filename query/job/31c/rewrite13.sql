create or replace view aggJoin7638358750468494852 as (
with aggView2047664770043140476 as (select id as v49, title as v64 from title as t)
select person_id as v40, movie_id as v49, note as v5, v64 from cast_info as ci, aggView2047664770043140476 where ci.movie_id=aggView2047664770043140476.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7245526387530071542 as (
with aggView4310258293054804304 as (select id as v40, name as v63 from name as n)
select v49, v5, v64, v63 from aggJoin7638358750468494852 join aggView4310258293054804304 using(v40));
create or replace view aggJoin6352436597543922171 as (
with aggView5989498452765896760 as (select v49, MIN(v64) as v64, MIN(v63) as v63 from aggJoin7245526387530071542 group by v49,v63,v64)
select movie_id as v49, info_type_id as v15, info as v30, v64, v63 from movie_info as mi, aggView5989498452765896760 where mi.movie_id=aggView5989498452765896760.v49 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5264528014896702562 as (
with aggView3131861292215138139 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView3131861292215138139 where mk.keyword_id=aggView3131861292215138139.v19);
create or replace view aggJoin280984498079283334 as (
with aggView4438930009688598976 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4438930009688598976 where mi_idx.info_type_id=aggView4438930009688598976.v17);
create or replace view aggJoin6789212622880241549 as (
with aggView5323972303251485367 as (select v49, MIN(v35) as v62 from aggJoin280984498079283334 group by v49)
select v49, v15, v30, v64 as v64, v63 as v63, v62 from aggJoin6352436597543922171 join aggView5323972303251485367 using(v49));
create or replace view aggJoin3114328081291149503 as (
with aggView799644209660967148 as (select id as v15 from info_type as it1 where info= 'genres')
select v49, v30, v64, v63, v62 from aggJoin6789212622880241549 join aggView799644209660967148 using(v15));
create or replace view aggJoin3462785316399723588 as (
with aggView6541287120483090001 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v62) as v62, MIN(v30) as v61 from aggJoin3114328081291149503 group by v49,v63,v64,v62)
select movie_id as v49, company_id as v8, v64, v63, v62, v61 from movie_companies as mc, aggView6541287120483090001 where mc.movie_id=aggView6541287120483090001.v49);
create or replace view aggJoin871666253850875469 as (
with aggView7720006079659500494 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v64, v63, v62, v61 from aggJoin3462785316399723588 join aggView7720006079659500494 using(v8));
create or replace view aggJoin5507379252992519622 as (
with aggView8919194320055876266 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v62) as v62, MIN(v61) as v61 from aggJoin871666253850875469 group by v49,v63,v64,v61,v62)
select v64, v63, v62, v61 from aggJoin5264528014896702562 join aggView8919194320055876266 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin5507379252992519622;
