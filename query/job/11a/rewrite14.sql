create or replace view aggJoin8818074194477251396 as (
with aggView5445733426800423459 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView5445733426800423459 where mc.company_id=aggView5445733426800423459.v17);
create or replace view aggJoin6765296620014069645 as (
with aggView2700937574528409558 as (select id as v24, title as v41 from title as t where production_year<=2000 and production_year>=1950)
select movie_id as v24, keyword_id as v22, v41 from movie_keyword as mk, aggView2700937574528409558 where mk.movie_id=aggView2700937574528409558.v24);
create or replace view aggJoin8106182213558357449 as (
with aggView7156315704187278459 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView7156315704187278459 where ml.link_type_id=aggView7156315704187278459.v13);
create or replace view aggJoin2938210442846532486 as (
with aggView4582308449263109658 as (select id as v22 from keyword as k where keyword= 'sequel')
select v24, v41 from aggJoin6765296620014069645 join aggView4582308449263109658 using(v22));
create or replace view aggJoin8039452642293406384 as (
with aggView1954453351602236360 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin8818074194477251396 join aggView1954453351602236360 using(v18));
create or replace view aggJoin4036932674901292724 as (
with aggView1719487853364089086 as (select v24, MIN(v39) as v39 from aggJoin8039452642293406384 group by v24,v39)
select v24, v40 as v40, v39 from aggJoin8106182213558357449 join aggView1719487853364089086 using(v24));
create or replace view aggJoin4499410658243608919 as (
with aggView8805725099318861166 as (select v24, MIN(v40) as v40, MIN(v39) as v39 from aggJoin4036932674901292724 group by v24,v39,v40)
select v41 as v41, v40, v39 from aggJoin2938210442846532486 join aggView8805725099318861166 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4499410658243608919;
