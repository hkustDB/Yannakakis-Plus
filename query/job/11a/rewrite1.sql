create or replace view aggView6672631739571527644 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin3395647670262362339 as (
with aggView6397542546361098050 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView6397542546361098050 where mk.keyword_id=aggView6397542546361098050.v22);
create or replace view aggJoin2096923271504402465 as (
with aggView1787249127764212324 as (select v24 from aggJoin3395647670262362339 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView1787249127764212324 where t.id=aggView1787249127764212324.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggView4226579437202990372 as select v28, v24 from aggJoin2096923271504402465 group by v28,v24;
create or replace view aggJoin7967998458321034941 as (
with aggView4372131105578575089 as (select v24, MIN(v28) as v41 from aggView4226579437202990372 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView4372131105578575089 where ml.movie_id=aggView4372131105578575089.v24);
create or replace view aggJoin6441041761330317191 as (
with aggView8099471203554150954 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select v24, v41, v40 from aggJoin7967998458321034941 join aggView8099471203554150954 using(v13));
create or replace view aggJoin6257944397041137746 as (
with aggView6168496510011571360 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin6441041761330317191 group by v24,v40,v41)
select company_id as v17, company_type_id as v18, v41, v40 from movie_companies as mc, aggView6168496510011571360 where mc.movie_id=aggView6168496510011571360.v24);
create or replace view aggJoin7125458870853136458 as (
with aggView604748725063221747 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v41, v40 from aggJoin6257944397041137746 join aggView604748725063221747 using(v18));
create or replace view aggJoin5275687643430875018 as (
with aggView7312703953910809622 as (select v17, MIN(v41) as v41, MIN(v40) as v40 from aggJoin7125458870853136458 group by v17,v40,v41)
select v2, v41, v40 from aggView6672631739571527644 join aggView7312703953910809622 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5275687643430875018;
