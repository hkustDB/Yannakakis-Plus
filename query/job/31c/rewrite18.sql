create or replace view aggJoin1076513594114570250 as (
with aggView2526183845385021390 as (select id as v40, name as v63 from name as n)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView2526183845385021390 where ci.person_id=aggView2526183845385021390.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5116669745786293727 as (
with aggView3773486414380391907 as (select id as v49, title as v64 from title as t)
select movie_id as v49, info_type_id as v17, info as v35, v64 from movie_info_idx as mi_idx, aggView3773486414380391907 where mi_idx.movie_id=aggView3773486414380391907.v49);
create or replace view aggJoin1814494474258777143 as (
with aggView1039349708678266814 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView1039349708678266814 where mk.keyword_id=aggView1039349708678266814.v19);
create or replace view aggJoin4807811757339803414 as (
with aggView3551529220734406427 as (select v49, MIN(v63) as v63 from aggJoin1076513594114570250 group by v49,v63)
select v49, v17, v35, v64 as v64, v63 from aggJoin5116669745786293727 join aggView3551529220734406427 using(v49));
create or replace view aggJoin6290010035993727745 as (
with aggView8231212782869281315 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView8231212782869281315 where mc.company_id=aggView8231212782869281315.v8);
create or replace view aggJoin750022989285787893 as (
with aggView6346293108460428601 as (select v49 from aggJoin6290010035993727745 group by v49)
select v49, v17, v35, v64 as v64, v63 as v63 from aggJoin4807811757339803414 join aggView6346293108460428601 using(v49));
create or replace view aggJoin7694309992210498760 as (
with aggView4210398507714461405 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35, v64, v63 from aggJoin750022989285787893 join aggView4210398507714461405 using(v17));
create or replace view aggJoin1251061161684213820 as (
with aggView2543507557633912496 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v35) as v62 from aggJoin7694309992210498760 group by v49,v63,v64)
select v49, v64, v63, v62 from aggJoin1814494474258777143 join aggView2543507557633912496 using(v49));
create or replace view aggJoin6559804649489622396 as (
with aggView3333396750101777545 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView3333396750101777545 where mi.info_type_id=aggView3333396750101777545.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7078123049625330603 as (
with aggView1838986909976956945 as (select v49, MIN(v30) as v61 from aggJoin6559804649489622396 group by v49)
select v64 as v64, v63 as v63, v62 as v62, v61 from aggJoin1251061161684213820 join aggView1838986909976956945 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin7078123049625330603;
