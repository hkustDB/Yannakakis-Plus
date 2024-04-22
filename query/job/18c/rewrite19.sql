create or replace view aggView608965148646407711 as select title as v32, id as v31 from title as t;
create or replace view aggJoin3665560081901884721 as (
with aggView6885336274373753641 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView6885336274373753641 where ci.person_id=aggView6885336274373753641.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8010990199597326910 as (
with aggView4492628657569619223 as (select v31 from aggJoin3665560081901884721 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView4492628657569619223 where mi_idx.movie_id=aggView4492628657569619223.v31);
create or replace view aggJoin3032170719049990743 as (
with aggView5237479515213000655 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView5237479515213000655 where mi.info_type_id=aggView5237479515213000655.v8);
create or replace view aggJoin6324825765114967916 as (
with aggView811507880243362094 as (select v31, v15 from aggJoin3032170719049990743 group by v31,v15)
select v31, v15 from aggView811507880243362094 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2280871652330302399 as (
with aggView8943471052852596159 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin8010990199597326910 join aggView8943471052852596159 using(v10));
create or replace view aggView4544808987212843948 as select v31, v20 from aggJoin2280871652330302399 group by v31,v20;
create or replace view aggJoin1463379659122910398 as (
with aggView1826713634592343969 as (select v31, MIN(v20) as v44 from aggView4544808987212843948 group by v31)
select v32, v31, v44 from aggView608965148646407711 join aggView1826713634592343969 using(v31));
create or replace view aggJoin3329375627212896338 as (
with aggView2551500377717194436 as (select v31, MIN(v15) as v43 from aggJoin6324825765114967916 group by v31)
select v32, v44 as v44, v43 from aggJoin1463379659122910398 join aggView2551500377717194436 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3329375627212896338;
