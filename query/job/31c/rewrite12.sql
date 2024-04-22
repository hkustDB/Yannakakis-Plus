create or replace view aggJoin7327739551639447244 as (
with aggView4138828004232777240 as (select id as v49, title as v64 from title as t)
select person_id as v40, movie_id as v49, note as v5, v64 from cast_info as ci, aggView4138828004232777240 where ci.movie_id=aggView4138828004232777240.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8132910225398831747 as (
with aggView5170827208341940387 as (select id as v40, name as v63 from name as n)
select v49, v5, v64, v63 from aggJoin7327739551639447244 join aggView5170827208341940387 using(v40));
create or replace view aggJoin2596489038449171862 as (
with aggView2628657276904834253 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2628657276904834253 where mk.keyword_id=aggView2628657276904834253.v19);
create or replace view aggJoin7203203331887936568 as (
with aggView4570685754874970880 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4570685754874970880 where mi_idx.info_type_id=aggView4570685754874970880.v17);
create or replace view aggJoin4749277615669870225 as (
with aggView942944010819295415 as (select v49, MIN(v35) as v62 from aggJoin7203203331887936568 group by v49)
select v49, v5, v64 as v64, v63 as v63, v62 from aggJoin8132910225398831747 join aggView942944010819295415 using(v49));
create or replace view aggJoin7827216745408728264 as (
with aggView9212518987952469681 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView9212518987952469681 where mc.company_id=aggView9212518987952469681.v8);
create or replace view aggJoin8320884727716287273 as (
with aggView2542557920507432139 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView2542557920507432139 where mi.info_type_id=aggView2542557920507432139.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2405909620338397405 as (
with aggView34120861537751563 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v62) as v62 from aggJoin4749277615669870225 group by v49,v63,v64,v62)
select v49, v64, v63, v62 from aggJoin7827216745408728264 join aggView34120861537751563 using(v49));
create or replace view aggJoin936002772056946901 as (
with aggView6583418157598493030 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v62) as v62 from aggJoin2405909620338397405 group by v49,v63,v64,v62)
select v49, v30, v64, v63, v62 from aggJoin8320884727716287273 join aggView6583418157598493030 using(v49));
create or replace view aggJoin8540623144776913199 as (
with aggView5330430881709028241 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v62) as v62, MIN(v30) as v61 from aggJoin936002772056946901 group by v49,v63,v64,v62)
select v64, v63, v62, v61 from aggJoin2596489038449171862 join aggView5330430881709028241 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin8540623144776913199;
