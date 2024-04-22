create or replace view aggView2275337499057531319 as select title as v50, id as v49 from title as t;
create or replace view aggView3613965585045671246 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin5920925356305574034 as (
with aggView6189491480594437483 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView6189491480594437483 where mi_idx.info_type_id=aggView6189491480594437483.v17);
create or replace view aggView5989911390405560478 as select v49, v35 from aggJoin5920925356305574034 group by v49,v35;
create or replace view aggJoin5201369545607884077 as (
with aggView2829112580725152514 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2829112580725152514 where mk.keyword_id=aggView2829112580725152514.v19);
create or replace view aggJoin239078887435777624 as (
with aggView8946795242599065647 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView8946795242599065647 where mi.info_type_id=aggView8946795242599065647.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin1365607159688221288 as (
with aggView2065374939201434157 as (select v49 from aggJoin5201369545607884077 group by v49)
select v49, v30 from aggJoin239078887435777624 join aggView2065374939201434157 using(v49));
create or replace view aggView2494208314463398767 as select v30, v49 from aggJoin1365607159688221288 group by v30,v49;
create or replace view aggJoin5865956951698377639 as (
with aggView703973180406550469 as (select v49, MIN(v35) as v62 from aggView5989911390405560478 group by v49)
select v30, v49, v62 from aggView2494208314463398767 join aggView703973180406550469 using(v49));
create or replace view aggJoin7057750576557527003 as (
with aggView3115657198598287097 as (select v49, MIN(v62) as v62, MIN(v30) as v61 from aggJoin5865956951698377639 group by v49,v62)
select v50, v49, v62, v61 from aggView2275337499057531319 join aggView3115657198598287097 using(v49));
create or replace view aggJoin1397620730936344910 as (
with aggView2712919139140769562 as (select v49, MIN(v62) as v62, MIN(v61) as v61, MIN(v50) as v64 from aggJoin7057750576557527003 group by v49,v61,v62)
select person_id as v40, movie_id as v49, note as v5, v62, v61, v64 from cast_info as ci, aggView2712919139140769562 where ci.movie_id=aggView2712919139140769562.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6623261414083438544 as (
with aggView8244587142816248198 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView8244587142816248198 where mc.company_id=aggView8244587142816248198.v8);
create or replace view aggJoin8562702756856014225 as (
with aggView7088224170945865830 as (select v49 from aggJoin6623261414083438544 group by v49)
select v40, v5, v62 as v62, v61 as v61, v64 as v64 from aggJoin1397620730936344910 join aggView7088224170945865830 using(v49));
create or replace view aggJoin4185622339480038955 as (
with aggView6057699906095585335 as (select v40, MIN(v62) as v62, MIN(v61) as v61, MIN(v64) as v64 from aggJoin8562702756856014225 group by v40,v64,v61,v62)
select v41, v62, v61, v64 from aggView3613965585045671246 join aggView6057699906095585335 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin4185622339480038955;
