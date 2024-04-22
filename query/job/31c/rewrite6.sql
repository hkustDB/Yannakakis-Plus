create or replace view aggView344566702605937462 as select name as v41, id as v40 from name as n;
create or replace view aggView1362869554019308764 as select id as v49, title as v50 from title as t;
create or replace view aggJoin1589622935878219546 as (
with aggView3806600300331144681 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView3806600300331144681 where mk.keyword_id=aggView3806600300331144681.v19);
create or replace view aggJoin520453828745052222 as (
with aggView1331246851606598780 as (select v49 from aggJoin1589622935878219546 group by v49)
select movie_id as v49, info_type_id as v17, info as v35 from movie_info_idx as mi_idx, aggView1331246851606598780 where mi_idx.movie_id=aggView1331246851606598780.v49);
create or replace view aggJoin5507001624306881437 as (
with aggView3488277082140981427 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView3488277082140981427 where mc.company_id=aggView3488277082140981427.v8);
create or replace view aggJoin397068190974761897 as (
with aggView2478966088015152428 as (select v49 from aggJoin5507001624306881437 group by v49)
select v49, v17, v35 from aggJoin520453828745052222 join aggView2478966088015152428 using(v49));
create or replace view aggJoin5086959287804600894 as (
with aggView2367282076642538565 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35 from aggJoin397068190974761897 join aggView2367282076642538565 using(v17));
create or replace view aggView2478106187079637789 as select v49, v35 from aggJoin5086959287804600894 group by v49,v35;
create or replace view aggJoin7425454034554257894 as (
with aggView8227296907390043019 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView8227296907390043019 where mi.info_type_id=aggView8227296907390043019.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView7888723682800778832 as select v49, v30 from aggJoin7425454034554257894 group by v49,v30;
create or replace view aggJoin1781780393831791316 as (
with aggView9027637371467036754 as (select v49, MIN(v35) as v62 from aggView2478106187079637789 group by v49)
select v49, v50, v62 from aggView1362869554019308764 join aggView9027637371467036754 using(v49));
create or replace view aggJoin1000226799081902585 as (
with aggView7769656102214553180 as (select v49, MIN(v62) as v62, MIN(v50) as v64 from aggJoin1781780393831791316 group by v49,v62)
select v49, v30, v62, v64 from aggView7888723682800778832 join aggView7769656102214553180 using(v49));
create or replace view aggJoin7174647147439275623 as (
with aggView4406341788713974564 as (select v49, MIN(v62) as v62, MIN(v64) as v64, MIN(v30) as v61 from aggJoin1000226799081902585 group by v49,v64,v62)
select person_id as v40, note as v5, v62, v64, v61 from cast_info as ci, aggView4406341788713974564 where ci.movie_id=aggView4406341788713974564.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5479867949940585755 as (
with aggView3290013275181305470 as (select v40, MIN(v62) as v62, MIN(v64) as v64, MIN(v61) as v61 from aggJoin7174647147439275623 group by v40,v64,v61,v62)
select v41, v62, v64, v61 from aggView344566702605937462 join aggView3290013275181305470 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin5479867949940585755;
