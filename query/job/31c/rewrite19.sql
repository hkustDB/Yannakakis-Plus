create or replace view aggJoin7267683281571224876 as (
with aggView2525209562741777614 as (select id as v49, title as v64 from title as t)
select movie_id as v49, company_id as v8, v64 from movie_companies as mc, aggView2525209562741777614 where mc.movie_id=aggView2525209562741777614.v49);
create or replace view aggJoin7294382534799402399 as (
with aggView7797969975211206656 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView7797969975211206656 where mk.keyword_id=aggView7797969975211206656.v19);
create or replace view aggJoin8544698456809778546 as (
with aggView1509412949902972329 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView1509412949902972329 where mi_idx.info_type_id=aggView1509412949902972329.v17);
create or replace view aggJoin3813193758748101026 as (
with aggView1644831870107032803 as (select v49, MIN(v35) as v62 from aggJoin8544698456809778546 group by v49)
select v49, v8, v64 as v64, v62 from aggJoin7267683281571224876 join aggView1644831870107032803 using(v49));
create or replace view aggJoin5556939779453485489 as (
with aggView825598973869920640 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView825598973869920640 where mi.info_type_id=aggView825598973869920640.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2309683014767105351 as (
with aggView3754657890010921746 as (select v49, MIN(v30) as v61 from aggJoin5556939779453485489 group by v49)
select v49, v8, v64 as v64, v62 as v62, v61 from aggJoin3813193758748101026 join aggView3754657890010921746 using(v49));
create or replace view aggJoin178417699137112069 as (
with aggView4773168091258060850 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v64, v62, v61 from aggJoin2309683014767105351 join aggView4773168091258060850 using(v8));
create or replace view aggJoin6472335782300549758 as (
with aggView563810625100615633 as (select v49 from aggJoin7294382534799402399 group by v49)
select v49, v64 as v64, v62 as v62, v61 as v61 from aggJoin178417699137112069 join aggView563810625100615633 using(v49));
create or replace view aggJoin7134438589693195011 as (
with aggView2124039306915080688 as (select v49, MIN(v64) as v64, MIN(v62) as v62, MIN(v61) as v61 from aggJoin6472335782300549758 group by v49,v64,v61,v62)
select person_id as v40, note as v5, v64, v62, v61 from cast_info as ci, aggView2124039306915080688 where ci.movie_id=aggView2124039306915080688.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1451045045008384649 as (
with aggView6106502609620429139 as (select v40, MIN(v64) as v64, MIN(v62) as v62, MIN(v61) as v61 from aggJoin7134438589693195011 group by v40,v64,v61,v62)
select name as v41, v64, v62, v61 from name as n, aggView6106502609620429139 where n.id=aggView6106502609620429139.v40);
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin1451045045008384649;
