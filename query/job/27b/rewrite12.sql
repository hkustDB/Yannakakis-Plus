create or replace view aggView660741792425426839 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin1388518808745576686 as (
with aggView6033770320689738988 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView6033770320689738988 where cc.subject_id=aggView6033770320689738988.v5);
create or replace view aggJoin7144064647602327819 as (
with aggView2679617476841933912 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin1388518808745576686 join aggView2679617476841933912 using(v7));
create or replace view aggJoin8508980727429402906 as (
with aggView3453085877359502796 as (select v37 from aggJoin7144064647602327819 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView3453085877359502796 where t.id=aggView3453085877359502796.v37 and production_year= 1998);
create or replace view aggView8967254036485934404 as select v37, v41 from aggJoin8508980727429402906 group by v37,v41;
create or replace view aggJoin3862498086173266775 as (
with aggView2592385218965606304 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView2592385218965606304 where ml.link_type_id=aggView2592385218965606304.v21);
create or replace view aggJoin784479530745497227 as (
with aggView1540248442878391760 as (select v25, MIN(v10) as v52 from aggView660741792425426839 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView1540248442878391760 where mc.company_id=aggView1540248442878391760.v25);
create or replace view aggJoin291109620732610444 as (
with aggView5599274470751383069 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView5599274470751383069 where mk.keyword_id=aggView5599274470751383069.v35);
create or replace view aggJoin3885338248610332078 as (
with aggView3657434665906516826 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin784479530745497227 join aggView3657434665906516826 using(v26));
create or replace view aggJoin1100334760524652284 as (
with aggView910762791804904001 as (select v37 from aggJoin291109620732610444 group by v37)
select v37, v53 as v53 from aggJoin3862498086173266775 join aggView910762791804904001 using(v37));
create or replace view aggJoin573613080638916542 as (
with aggView4450419124309138685 as (select v37, MIN(v53) as v53 from aggJoin1100334760524652284 group by v37,v53)
select v37, v52 as v52, v53 from aggJoin3885338248610332078 join aggView4450419124309138685 using(v37));
create or replace view aggJoin8274427519391151159 as (
with aggView761411042631125201 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select v37, v52 as v52, v53 as v53 from aggJoin573613080638916542 join aggView761411042631125201 using(v37));
create or replace view aggJoin6608866352823562411 as (
with aggView5517406207367144770 as (select v37, MIN(v52) as v52, MIN(v53) as v53 from aggJoin8274427519391151159 group by v37,v53,v52)
select v41, v52, v53 from aggView8967254036485934404 join aggView5517406207367144770 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v41) as v54 from aggJoin6608866352823562411;
