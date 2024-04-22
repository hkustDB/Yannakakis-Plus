create or replace view aggView369046684646734064 as select id as v37, title as v41 from title as t where production_year>=1950 and production_year<=2010;
create or replace view aggView4832089826067073250 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin1571154735557432139 as (
with aggView1149300913767031696 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView1149300913767031696 where ml.link_type_id=aggView1149300913767031696.v21);
create or replace view aggJoin1629616951184948916 as (
with aggView2553792367477513335 as (select v25, MIN(v10) as v52 from aggView4832089826067073250 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView2553792367477513335 where mc.company_id=aggView2553792367477513335.v25);
create or replace view aggJoin3113576788920858939 as (
with aggView7403517523781778170 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView7403517523781778170 where mk.keyword_id=aggView7403517523781778170.v35);
create or replace view aggJoin2840011126943415647 as (
with aggView6870172275978318664 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView6870172275978318664 where cc.subject_id=aggView6870172275978318664.v5);
create or replace view aggJoin4496330994861293934 as (
with aggView4056274381649765114 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin2840011126943415647 join aggView4056274381649765114 using(v7));
create or replace view aggJoin2127312650129407374 as (
with aggView5291418726962084630 as (select v37 from aggJoin3113576788920858939 group by v37)
select v37, v53 as v53 from aggJoin1571154735557432139 join aggView5291418726962084630 using(v37));
create or replace view aggJoin9026561102190976423 as (
with aggView7984664096571099092 as (select v37 from aggJoin4496330994861293934 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView7984664096571099092 where mi.movie_id=aggView7984664096571099092.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin1083963603356206837 as (
with aggView8068499442252075082 as (select v37 from aggJoin9026561102190976423 group by v37)
select v37, v53 as v53 from aggJoin2127312650129407374 join aggView8068499442252075082 using(v37));
create or replace view aggJoin1877848667618758493 as (
with aggView580080362171313985 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin1629616951184948916 join aggView580080362171313985 using(v26));
create or replace view aggJoin5283989472370254940 as (
with aggView1044691527729315613 as (select v37, MIN(v52) as v52 from aggJoin1877848667618758493 group by v37,v52)
select v37, v53 as v53, v52 from aggJoin1083963603356206837 join aggView1044691527729315613 using(v37));
create or replace view aggJoin2089227920451378690 as (
with aggView5992752629545250060 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin5283989472370254940 group by v37,v52,v53)
select v41, v53, v52 from aggView369046684646734064 join aggView5992752629545250060 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v41) as v54 from aggJoin2089227920451378690;
