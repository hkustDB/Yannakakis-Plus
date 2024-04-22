create or replace view aggView2579900288019914255 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin8710657148891469924 as (
with aggView4080992041631893073 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4080992041631893073 where mi_idx.info_type_id=aggView4080992041631893073.v17);
create or replace view aggView6331877484865236705 as select v49, v35 from aggJoin8710657148891469924 group by v49,v35;
create or replace view aggJoin9001724760032680306 as (
with aggView2382186558393860830 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2382186558393860830 where mk.keyword_id=aggView2382186558393860830.v19);
create or replace view aggJoin3042482556861624792 as (
with aggView3070315203814101023 as (select v49 from aggJoin9001724760032680306 group by v49)
select id as v49, title as v50 from title as t, aggView3070315203814101023 where t.id=aggView3070315203814101023.v49);
create or replace view aggJoin3084019223325022638 as (
with aggView3347921121735182470 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView3347921121735182470 where mc.company_id=aggView3347921121735182470.v8);
create or replace view aggJoin1941274564939985601 as (
with aggView5704741234432863723 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView5704741234432863723 where mi.info_type_id=aggView5704741234432863723.v15);
create or replace view aggJoin1721153869222586389 as (
with aggView2765308445046378255 as (select v30, v49 from aggJoin1941274564939985601 group by v30,v49)
select v49, v30 from aggView2765308445046378255 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin2817655506620454466 as (
with aggView6969515717173228440 as (select v49 from aggJoin3084019223325022638 group by v49)
select v49, v50 from aggJoin3042482556861624792 join aggView6969515717173228440 using(v49));
create or replace view aggView682534684783511450 as select v50, v49 from aggJoin2817655506620454466 group by v50,v49;
create or replace view aggJoin5126461699399919976 as (
with aggView106473291785608086 as (select v49, MIN(v50) as v64 from aggView682534684783511450 group by v49)
select v49, v30, v64 from aggJoin1721153869222586389 join aggView106473291785608086 using(v49));
create or replace view aggJoin986844334656350390 as (
with aggView7205765124108246092 as (select v40, MIN(v41) as v63 from aggView2579900288019914255 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView7205765124108246092 where ci.person_id=aggView7205765124108246092.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3431431811758110973 as (
with aggView1659555926397890726 as (select v49, MIN(v35) as v62 from aggView6331877484865236705 group by v49)
select v49, v5, v63 as v63, v62 from aggJoin986844334656350390 join aggView1659555926397890726 using(v49));
create or replace view aggJoin8183191979781279922 as (
with aggView785971711178928188 as (select v49, MIN(v63) as v63, MIN(v62) as v62 from aggJoin3431431811758110973 group by v49,v63,v62)
select v30, v64 as v64, v63, v62 from aggJoin5126461699399919976 join aggView785971711178928188 using(v49));
select MIN(v30) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin8183191979781279922;
