create or replace view aggView568161953484626858 as select title as v50, id as v49 from title as t;
create or replace view aggView3474944262141010770 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin3670981854318147758 as (
with aggView8617184038325366726 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8617184038325366726 where mk.keyword_id=aggView8617184038325366726.v19);
create or replace view aggJoin856255600080122015 as (
with aggView4720888243690640542 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4720888243690640542 where mi_idx.info_type_id=aggView4720888243690640542.v17);
create or replace view aggJoin8284905891098523142 as (
with aggView8704773373632072387 as (select v49 from aggJoin3670981854318147758 group by v49)
select movie_id as v49, company_id as v8 from movie_companies as mc, aggView8704773373632072387 where mc.movie_id=aggView8704773373632072387.v49);
create or replace view aggJoin5704556570122151990 as (
with aggView5935169775666669909 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49 from aggJoin8284905891098523142 join aggView5935169775666669909 using(v8));
create or replace view aggJoin2949887707887031512 as (
with aggView2531341811444843017 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView2531341811444843017 where mi.info_type_id=aggView2531341811444843017.v15);
create or replace view aggJoin3826262096754226261 as (
with aggView3690114307206743450 as (select v30, v49 from aggJoin2949887707887031512 group by v30,v49)
select v49, v30 from aggView3690114307206743450 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin7033022584575282667 as (
with aggView57294137417520491 as (select v49 from aggJoin5704556570122151990 group by v49)
select v49, v35 from aggJoin856255600080122015 join aggView57294137417520491 using(v49));
create or replace view aggView5834053656327715486 as select v49, v35 from aggJoin7033022584575282667 group by v49,v35;
create or replace view aggJoin302422972895245009 as (
with aggView6988547545525203843 as (select v40, MIN(v41) as v63 from aggView3474944262141010770 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView6988547545525203843 where ci.person_id=aggView6988547545525203843.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1087636067889316453 as (
with aggView3863008181576385655 as (select v49, MIN(v35) as v62 from aggView5834053656327715486 group by v49)
select v49, v5, v63 as v63, v62 from aggJoin302422972895245009 join aggView3863008181576385655 using(v49));
create or replace view aggJoin5312210729415049185 as (
with aggView1532227182857193427 as (select v49, MIN(v63) as v63, MIN(v62) as v62 from aggJoin1087636067889316453 group by v49,v63,v62)
select v49, v30, v63, v62 from aggJoin3826262096754226261 join aggView1532227182857193427 using(v49));
create or replace view aggJoin2520268669869831032 as (
with aggView1371944628886081063 as (select v49, MIN(v63) as v63, MIN(v62) as v62, MIN(v30) as v61 from aggJoin5312210729415049185 group by v49,v63,v62)
select v50, v63, v62, v61 from aggView568161953484626858 join aggView1371944628886081063 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin2520268669869831032;
