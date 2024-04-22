create or replace view aggJoin1284968553801238689 as (
with aggView5750301687161262838 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView5750301687161262838 where ci.person_id=aggView5750301687161262838.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3061543063326792747 as (
with aggView7925838427758552623 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView7925838427758552623 where mi_idx.info_type_id=aggView7925838427758552623.v10 and info>'8.0');
create or replace view aggJoin2991960000392993289 as (
with aggView4761718689638591966 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView4761718689638591966 where mi.info_type_id=aggView4761718689638591966.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin2615840755084198454 as (
with aggView8798642066177396446 as (select v31, MIN(v15) as v43 from aggJoin2991960000392993289 group by v31)
select id as v31, title as v32, production_year as v35, v43 from title as t, aggView8798642066177396446 where t.id=aggView8798642066177396446.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggJoin2965307197741738805 as (
with aggView2586973444091301057 as (select v31, MIN(v43) as v43, MIN(v32) as v45 from aggJoin2615840755084198454 group by v31,v43)
select v31, v20, v43, v45 from aggJoin3061543063326792747 join aggView2586973444091301057 using(v31));
create or replace view aggJoin1307345654253854922 as (
with aggView1614071629897485034 as (select v31, MIN(v43) as v43, MIN(v45) as v45, MIN(v20) as v44 from aggJoin2965307197741738805 group by v31,v43,v45)
select v43, v45, v44 from aggJoin1284968553801238689 join aggView1614071629897485034 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1307345654253854922;
