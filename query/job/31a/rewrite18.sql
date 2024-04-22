create or replace view aggJoin1677996228133872085 as (
with aggView674458809379201021 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView674458809379201021 where ci.person_id=aggView674458809379201021.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6824207889908817300 as (
with aggView8301369403280586884 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8301369403280586884 where mi_idx.info_type_id=aggView8301369403280586884.v17);
create or replace view aggJoin6801763923621234864 as (
with aggView2888871482714298525 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2888871482714298525 where mk.keyword_id=aggView2888871482714298525.v19);
create or replace view aggJoin5981947858796229853 as (
with aggView8665452158511215977 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView8665452158511215977 where mi.info_type_id=aggView8665452158511215977.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin2302506155124293417 as (
with aggView1008039017086741071 as (select v49, MIN(v30) as v61 from aggJoin5981947858796229853 group by v49)
select v49, v35, v61 from aggJoin6824207889908817300 join aggView1008039017086741071 using(v49));
create or replace view aggJoin3490932209739999445 as (
with aggView2795042869900523212 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView2795042869900523212 where mc.company_id=aggView2795042869900523212.v8);
create or replace view aggJoin1636811568711514162 as (
with aggView2395721393226251716 as (select v49 from aggJoin3490932209739999445 group by v49)
select v49, v35, v61 as v61 from aggJoin2302506155124293417 join aggView2395721393226251716 using(v49));
create or replace view aggJoin5483576882014827684 as (
with aggView5797099230444169359 as (select v49, MIN(v63) as v63 from aggJoin1677996228133872085 group by v49,v63)
select v49, v35, v61 as v61, v63 from aggJoin1636811568711514162 join aggView5797099230444169359 using(v49));
create or replace view aggJoin2269910036599012618 as (
with aggView4747861916777610992 as (select v49, MIN(v61) as v61, MIN(v63) as v63, MIN(v35) as v62 from aggJoin5483576882014827684 group by v49,v61,v63)
select id as v49, title as v50, v61, v63, v62 from title as t, aggView4747861916777610992 where t.id=aggView4747861916777610992.v49);
create or replace view aggJoin6511678156691988221 as (
with aggView7822870418090262590 as (select v49, MIN(v61) as v61, MIN(v63) as v63, MIN(v62) as v62, MIN(v50) as v64 from aggJoin2269910036599012618 group by v49,v61,v63,v62)
select v61, v63, v62, v64 from aggJoin6801763923621234864 join aggView7822870418090262590 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin6511678156691988221;
