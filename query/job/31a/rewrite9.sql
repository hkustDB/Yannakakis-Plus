create or replace view aggView7819191753884945729 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin7521658919269036917 as (
with aggView7113473879880630381 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView7113473879880630381 where mi_idx.info_type_id=aggView7113473879880630381.v17);
create or replace view aggView8626990349516450905 as select v49, v35 from aggJoin7521658919269036917 group by v49,v35;
create or replace view aggJoin139523460872419421 as (
with aggView6280803652966290814 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView6280803652966290814 where mc.company_id=aggView6280803652966290814.v8);
create or replace view aggJoin7194180798299607917 as (
with aggView7150563229372013731 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView7150563229372013731 where mi.info_type_id=aggView7150563229372013731.v15 and info IN ('Horror','Thriller'));
create or replace view aggView1927846765041051762 as select v30, v49 from aggJoin7194180798299607917 group by v30,v49;
create or replace view aggJoin6111762836142515185 as (
with aggView686708859876132337 as (select v49 from aggJoin139523460872419421 group by v49)
select id as v49, title as v50 from title as t, aggView686708859876132337 where t.id=aggView686708859876132337.v49);
create or replace view aggView8126884180433436396 as select v50, v49 from aggJoin6111762836142515185 group by v50,v49;
create or replace view aggJoin3888431842885293932 as (
with aggView2342492179415337293 as (select v49, MIN(v35) as v62 from aggView8626990349516450905 group by v49)
select person_id as v40, movie_id as v49, note as v5, v62 from cast_info as ci, aggView2342492179415337293 where ci.movie_id=aggView2342492179415337293.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2065066593572824961 as (
with aggView8564172040167913661 as (select v40, MIN(v41) as v63 from aggView7819191753884945729 group by v40)
select v49, v5, v62 as v62, v63 from aggJoin3888431842885293932 join aggView8564172040167913661 using(v40));
create or replace view aggJoin6844756925157417856 as (
with aggView8621754144127224690 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8621754144127224690 where mk.keyword_id=aggView8621754144127224690.v19);
create or replace view aggJoin4693068635428583172 as (
with aggView1083584453528677139 as (select v49 from aggJoin6844756925157417856 group by v49)
select v49, v5, v62 as v62, v63 as v63 from aggJoin2065066593572824961 join aggView1083584453528677139 using(v49));
create or replace view aggJoin7945505164277530076 as (
with aggView4819342865280354267 as (select v49, MIN(v62) as v62, MIN(v63) as v63 from aggJoin4693068635428583172 group by v49,v63,v62)
select v50, v49, v62, v63 from aggView8126884180433436396 join aggView4819342865280354267 using(v49));
create or replace view aggJoin5662197001817089255 as (
with aggView3154503254392184900 as (select v49, MIN(v62) as v62, MIN(v63) as v63, MIN(v50) as v64 from aggJoin7945505164277530076 group by v49,v63,v62)
select v30, v62, v63, v64 from aggView1927846765041051762 join aggView3154503254392184900 using(v49));
select MIN(v30) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin5662197001817089255;
