create or replace view aggView8212048930355069529 as select id as v49, title as v50 from title as t;
create or replace view aggView3238365644975419226 as select name as v41, id as v40 from name as n;
create or replace view aggJoin6247326829601827852 as (
with aggView8874208789552252109 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8874208789552252109 where mi_idx.info_type_id=aggView8874208789552252109.v17);
create or replace view aggView5862036686845619183 as select v49, v35 from aggJoin6247326829601827852 group by v49,v35;
create or replace view aggJoin2692789715656646122 as (
with aggView4438906269319141134 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView4438906269319141134 where mi.info_type_id=aggView4438906269319141134.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView2501691129186609297 as select v49, v30 from aggJoin2692789715656646122 group by v49,v30;
create or replace view aggJoin5553582974613524559 as (
with aggView6766948399409266845 as (select v49, MIN(v35) as v62 from aggView5862036686845619183 group by v49)
select v49, v30, v62 from aggView2501691129186609297 join aggView6766948399409266845 using(v49));
create or replace view aggJoin8449900586116320027 as (
with aggView4557110646418740689 as (select v40, MIN(v41) as v63 from aggView3238365644975419226 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView4557110646418740689 where ci.person_id=aggView4557110646418740689.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin9154942217108030541 as (
with aggView5689463924830846532 as (select v49, MIN(v62) as v62, MIN(v30) as v61 from aggJoin5553582974613524559 group by v49,v62)
select v49, v5, v63 as v63, v62, v61 from aggJoin8449900586116320027 join aggView5689463924830846532 using(v49));
create or replace view aggJoin965042430024227183 as (
with aggView2008869062825240249 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2008869062825240249 where mk.keyword_id=aggView2008869062825240249.v19);
create or replace view aggJoin2853741704582194617 as (
with aggView2266739837717673201 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView2266739837717673201 where mc.company_id=aggView2266739837717673201.v8);
create or replace view aggJoin3370345082948496278 as (
with aggView6774472514350434169 as (select v49 from aggJoin965042430024227183 group by v49)
select v49 from aggJoin2853741704582194617 join aggView6774472514350434169 using(v49));
create or replace view aggJoin7563837905539760344 as (
with aggView8054834663662642392 as (select v49 from aggJoin3370345082948496278 group by v49)
select v49, v5, v63 as v63, v62 as v62, v61 as v61 from aggJoin9154942217108030541 join aggView8054834663662642392 using(v49));
create or replace view aggJoin1751304647752775571 as (
with aggView6049026150661887778 as (select v49, MIN(v63) as v63, MIN(v62) as v62, MIN(v61) as v61 from aggJoin7563837905539760344 group by v49,v63,v61,v62)
select v50, v63, v62, v61 from aggView8212048930355069529 join aggView6049026150661887778 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin1751304647752775571;
