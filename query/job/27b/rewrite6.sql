create or replace view aggJoin5779670996796538988 as (
with aggView6741266744981419005 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView6741266744981419005 where mc.company_id=aggView6741266744981419005.v25);
create or replace view aggJoin8301253544610726075 as (
with aggView131250766063378097 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView131250766063378097 where ml.link_type_id=aggView131250766063378097.v21);
create or replace view aggJoin7745744621469195415 as (
with aggView3516654795211822548 as (select id as v37, title as v54 from title as t where production_year= 1998)
select movie_id as v37, keyword_id as v35, v54 from movie_keyword as mk, aggView3516654795211822548 where mk.movie_id=aggView3516654795211822548.v37);
create or replace view aggJoin2299868948334835962 as (
with aggView3516782749292288763 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView3516782749292288763 where cc.subject_id=aggView3516782749292288763.v5);
create or replace view aggJoin7377787456785327177 as (
with aggView5298397966124029391 as (select id as v35 from keyword as k where keyword= 'sequel')
select v37, v54 from aggJoin7745744621469195415 join aggView5298397966124029391 using(v35));
create or replace view aggJoin4865023875445021635 as (
with aggView4160781034060660097 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin2299868948334835962 join aggView4160781034060660097 using(v7));
create or replace view aggJoin2077440407790742787 as (
with aggView1988356443691594408 as (select v37 from aggJoin4865023875445021635 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView1988356443691594408 where mi.movie_id=aggView1988356443691594408.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin7771872017640849206 as (
with aggView709845923023205519 as (select v37, MIN(v53) as v53 from aggJoin8301253544610726075 group by v37,v53)
select v37, v31, v53 from aggJoin2077440407790742787 join aggView709845923023205519 using(v37));
create or replace view aggJoin5644818028227347973 as (
with aggView2699681366927907859 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin5779670996796538988 join aggView2699681366927907859 using(v26));
create or replace view aggJoin2788825550822476117 as (
with aggView617479066252896471 as (select v37, MIN(v52) as v52 from aggJoin5644818028227347973 group by v37,v52)
select v37, v31, v53 as v53, v52 from aggJoin7771872017640849206 join aggView617479066252896471 using(v37));
create or replace view aggJoin6364344709150370872 as (
with aggView8521915656558965886 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin2788825550822476117 group by v37,v53,v52)
select v54 as v54, v53, v52 from aggJoin7377787456785327177 join aggView8521915656558965886 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin6364344709150370872;
