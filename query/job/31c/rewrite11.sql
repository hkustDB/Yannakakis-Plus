create or replace view aggJoin4813424296379404598 as (
with aggView541126543507300528 as (select id as v40, name as v63 from name as n)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView541126543507300528 where ci.person_id=aggView541126543507300528.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2659637191169051957 as (
with aggView1543839942998186074 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView1543839942998186074 where mk.keyword_id=aggView1543839942998186074.v19);
create or replace view aggJoin6699669916886563660 as (
with aggView902192231112635615 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView902192231112635615 where mi_idx.info_type_id=aggView902192231112635615.v17);
create or replace view aggJoin5243333917354066045 as (
with aggView5456066021309567595 as (select v49, MIN(v35) as v62 from aggJoin6699669916886563660 group by v49)
select movie_id as v49, company_id as v8, v62 from movie_companies as mc, aggView5456066021309567595 where mc.movie_id=aggView5456066021309567595.v49);
create or replace view aggJoin4657824675300685050 as (
with aggView2632593928200219494 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView2632593928200219494 where mi.info_type_id=aggView2632593928200219494.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2431666503818577102 as (
with aggView8629963175293843727 as (select v49, MIN(v30) as v61 from aggJoin4657824675300685050 group by v49)
select v49, v5, v63 as v63, v61 from aggJoin4813424296379404598 join aggView8629963175293843727 using(v49));
create or replace view aggJoin4740401333971541919 as (
with aggView800153607854915405 as (select v49, MIN(v63) as v63, MIN(v61) as v61 from aggJoin2431666503818577102 group by v49,v63,v61)
select id as v49, title as v50, v63, v61 from title as t, aggView800153607854915405 where t.id=aggView800153607854915405.v49);
create or replace view aggJoin8792818633161073029 as (
with aggView6227794903422806625 as (select v49, MIN(v63) as v63, MIN(v61) as v61, MIN(v50) as v64 from aggJoin4740401333971541919 group by v49,v63,v61)
select v49, v8, v62 as v62, v63, v61, v64 from aggJoin5243333917354066045 join aggView6227794903422806625 using(v49));
create or replace view aggJoin750822002186862064 as (
with aggView2206974679737318616 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v62, v63, v61, v64 from aggJoin8792818633161073029 join aggView2206974679737318616 using(v8));
create or replace view aggJoin5282582713426531177 as (
with aggView8395261797541092107 as (select v49, MIN(v62) as v62, MIN(v63) as v63, MIN(v61) as v61, MIN(v64) as v64 from aggJoin750822002186862064 group by v49,v63,v64,v61,v62)
select v62, v63, v61, v64 from aggJoin2659637191169051957 join aggView8395261797541092107 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin5282582713426531177;
