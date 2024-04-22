create or replace view aggView5763259080382351748 as select title as v32, id as v31 from title as t where production_year>=2008 and production_year<=2014;
create or replace view aggJoin6513227052748833951 as (
with aggView1340779850282176496 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView1340779850282176496 where ci.person_id=aggView1340779850282176496.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5598902986855036319 as (
with aggView6307163792630030744 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView6307163792630030744 where mi_idx.info_type_id=aggView6307163792630030744.v10);
create or replace view aggJoin1548933164165146728 as (
with aggView8657783041396489279 as (select v31, v20 from aggJoin5598902986855036319 group by v31,v20)
select v31, v20 from aggView8657783041396489279 where v20>'8.0');
create or replace view aggJoin3130784664109809972 as (
with aggView2252915581586749963 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView2252915581586749963 where mi.info_type_id=aggView2252915581586749963.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin9163754446935389608 as (
with aggView897961356892411874 as (select v31 from aggJoin6513227052748833951 group by v31)
select v31, v15 from aggJoin3130784664109809972 join aggView897961356892411874 using(v31));
create or replace view aggView4535243245514644598 as select v15, v31 from aggJoin9163754446935389608 group by v15,v31;
create or replace view aggJoin7456802068734793987 as (
with aggView1211047379502261690 as (select v31, MIN(v20) as v44 from aggJoin1548933164165146728 group by v31)
select v32, v31, v44 from aggView5763259080382351748 join aggView1211047379502261690 using(v31));
create or replace view aggJoin9219599380035798663 as (
with aggView4451142067101658226 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin7456802068734793987 group by v31,v44)
select v15, v44, v45 from aggView4535243245514644598 join aggView4451142067101658226 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin9219599380035798663;
