create or replace view aggJoin5321131520316320581 as (
with aggView4500335051480887340 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView4500335051480887340 where mc.company_id=aggView4500335051480887340.v17);
create or replace view aggJoin8738999854971019953 as (
with aggView7086866177706977054 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView7086866177706977054 where ml.link_type_id=aggView7086866177706977054.v13);
create or replace view aggJoin1618925817333335537 as (
with aggView2866897080525606855 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView2866897080525606855 where mk.keyword_id=aggView2866897080525606855.v22);
create or replace view aggJoin198612093009864757 as (
with aggView1664672524913073842 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin5321131520316320581 join aggView1664672524913073842 using(v18));
create or replace view aggJoin2773970215422846101 as (
with aggView829989878479624408 as (select v24, MIN(v39) as v39 from aggJoin198612093009864757 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39 from title as t, aggView829989878479624408 where t.id=aggView829989878479624408.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggJoin2019175477493624224 as (
with aggView6308472684897926063 as (select v24, MIN(v39) as v39, MIN(v28) as v41 from aggJoin2773970215422846101 group by v24,v39)
select v24, v40 as v40, v39, v41 from aggJoin8738999854971019953 join aggView6308472684897926063 using(v24));
create or replace view aggJoin6878452515118591755 as (
with aggView5450880581788371407 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v41) as v41 from aggJoin2019175477493624224 group by v24,v39,v40,v41)
select v40, v39, v41 from aggJoin1618925817333335537 join aggView5450880581788371407 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6878452515118591755;
