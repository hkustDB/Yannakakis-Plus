create or replace view aggView1948167074317238666 as select id as v49, title as v50 from title as t;
create or replace view aggView8200002127717943001 as select name as v41, id as v40 from name as n;
create or replace view aggJoin2151799239905046098 as (
with aggView2996028259657091286 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView2996028259657091286 where mi.info_type_id=aggView2996028259657091286.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView2831888638931017318 as select v49, v30 from aggJoin2151799239905046098 group by v49,v30;
create or replace view aggJoin2197084355961933062 as (
with aggView255881418187100382 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView255881418187100382 where mi_idx.info_type_id=aggView255881418187100382.v17);
create or replace view aggView8952423238310675790 as select v49, v35 from aggJoin2197084355961933062 group by v49,v35;
create or replace view aggJoin5832569890373988861 as (
with aggView5400408297577543854 as (select v49, MIN(v30) as v61 from aggView2831888638931017318 group by v49)
select v49, v35, v61 from aggView8952423238310675790 join aggView5400408297577543854 using(v49));
create or replace view aggJoin7263730634333833814 as (
with aggView5332043468820320424 as (select v49, MIN(v61) as v61, MIN(v35) as v62 from aggJoin5832569890373988861 group by v49,v61)
select v49, v50, v61, v62 from aggView1948167074317238666 join aggView5332043468820320424 using(v49));
create or replace view aggJoin4967175897495242479 as (
with aggView5637045661483273468 as (select v49, MIN(v61) as v61, MIN(v62) as v62, MIN(v50) as v64 from aggJoin7263730634333833814 group by v49,v61,v62)
select person_id as v40, movie_id as v49, note as v5, v61, v62, v64 from cast_info as ci, aggView5637045661483273468 where ci.movie_id=aggView5637045661483273468.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1417878385919853168 as (
with aggView4059027615635258533 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView4059027615635258533 where mk.keyword_id=aggView4059027615635258533.v19);
create or replace view aggJoin8615231520754025995 as (
with aggView7472973842894873709 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView7472973842894873709 where mc.company_id=aggView7472973842894873709.v8);
create or replace view aggJoin1004997211252050373 as (
with aggView2241287888652481489 as (select v49 from aggJoin1417878385919853168 group by v49)
select v49 from aggJoin8615231520754025995 join aggView2241287888652481489 using(v49));
create or replace view aggJoin8862866819423672952 as (
with aggView7449343411955077441 as (select v49 from aggJoin1004997211252050373 group by v49)
select v40, v5, v61 as v61, v62 as v62, v64 as v64 from aggJoin4967175897495242479 join aggView7449343411955077441 using(v49));
create or replace view aggJoin1025061895647302483 as (
with aggView5910323332606880181 as (select v40, MIN(v61) as v61, MIN(v62) as v62, MIN(v64) as v64 from aggJoin8862866819423672952 group by v40,v64,v61,v62)
select v41, v61, v62, v64 from aggView8200002127717943001 join aggView5910323332606880181 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin1025061895647302483;
