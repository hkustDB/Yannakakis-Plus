create or replace view aggJoin7970436176264920768 as (
with aggView3028940292848837896 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3028940292848837896 where ml.link_type_id=aggView3028940292848837896.v13);
create or replace view aggJoin7559735628266545837 as (
with aggView4516110275701778876 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4516110275701778876 where mc.company_id=aggView4516110275701778876.v17);
create or replace view aggJoin4816432031880475556 as (
with aggView5245302248864926696 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=2000)
select v29, v45, v46 from aggJoin7970436176264920768 join aggView5245302248864926696 using(v29));
create or replace view aggJoin8356468525678386178 as (
with aggView4503265253100516724 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4503265253100516724 where mk.keyword_id=aggView4503265253100516724.v27);
create or replace view aggJoin1214562529259897592 as (
with aggView1293510857245361109 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin7559735628266545837 join aggView1293510857245361109 using(v18));
create or replace view aggJoin4568504488663689362 as (
with aggView7788832995016418220 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin4816432031880475556 group by v29,v46,v45)
select v29, v44 as v44, v45, v46 from aggJoin1214562529259897592 join aggView7788832995016418220 using(v29));
create or replace view aggJoin6176955471544374144 as (
with aggView2901634581050827148 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin4568504488663689362 group by v29,v46,v45,v44)
select movie_id as v29, info as v23, v44, v45, v46 from movie_info as mi, aggView2901634581050827148 where mi.movie_id=aggView2901634581050827148.v29 and info IN ('Germany','German'));
create or replace view aggJoin5499814498849011924 as (
with aggView909762940332787788 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin6176955471544374144 group by v29,v46,v45,v44)
select v44, v45, v46 from aggJoin8356468525678386178 join aggView909762940332787788 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5499814498849011924;
