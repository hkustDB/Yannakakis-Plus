create or replace view aggJoin4426192308710499297 as (
with aggView8247083363661325442 as (select id as v45, title as v60 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000)
select movie_id as v45, info_type_id as v18, info as v31, v60 from movie_info_idx as mi_idx, aggView8247083363661325442 where mi_idx.movie_id=aggView8247083363661325442.v45);
create or replace view aggJoin3827279626378722111 as (
with aggView1958305743050878540 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView1958305743050878540 where ci.person_id=aggView1958305743050878540.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2131171563403550959 as (
with aggView8348618559418256250 as (select v45, MIN(v59) as v59 from aggJoin3827279626378722111 group by v45,v59)
select movie_id as v45, info_type_id as v16, info as v26, v59 from movie_info as mi, aggView8348618559418256250 where mi.movie_id=aggView8348618559418256250.v45 and info IN ('Horror','Thriller'));
create or replace view aggJoin254278420728863728 as (
with aggView5170675984656930832 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5170675984656930832 where cc.status_id=aggView5170675984656930832.v7);
create or replace view aggJoin3583194592584411199 as (
with aggView5065600742613027600 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView5065600742613027600 where mk.keyword_id=aggView5065600742613027600.v20);
create or replace view aggJoin3993288345208629899 as (
with aggView5740219448770197057 as (select id as v16 from info_type as it1 where info= 'genres')
select v45, v26, v59 from aggJoin2131171563403550959 join aggView5740219448770197057 using(v16));
create or replace view aggJoin8313711056944995046 as (
with aggView2924955171043907993 as (select v45, MIN(v59) as v59, MIN(v26) as v57 from aggJoin3993288345208629899 group by v45,v59)
select v45, v59, v57 from aggJoin3583194592584411199 join aggView2924955171043907993 using(v45));
create or replace view aggJoin2120822893482011847 as (
with aggView1164702188860019046 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin254278420728863728 join aggView1164702188860019046 using(v5));
create or replace view aggJoin5441696863317303486 as (
with aggView4435121458635319352 as (select v45 from aggJoin2120822893482011847 group by v45)
select v45, v59 as v59, v57 as v57 from aggJoin8313711056944995046 join aggView4435121458635319352 using(v45));
create or replace view aggJoin1937811538560224366 as (
with aggView8887059140781929947 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v60 from aggJoin4426192308710499297 join aggView8887059140781929947 using(v18));
create or replace view aggJoin1623308945040767870 as (
with aggView436329623880546077 as (select v45, MIN(v60) as v60, MIN(v31) as v58 from aggJoin1937811538560224366 group by v45,v60)
select v59 as v59, v57 as v57, v60, v58 from aggJoin5441696863317303486 join aggView436329623880546077 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1623308945040767870;
