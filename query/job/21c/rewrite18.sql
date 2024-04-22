create or replace view aggJoin5005114106395448031 as (
with aggView1641338433509192666 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView1641338433509192666 where mc.company_id=aggView1641338433509192666.v17);
create or replace view aggJoin8721511717864303138 as (
with aggView7851387351275684256 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7851387351275684256 where ml.link_type_id=aggView7851387351275684256.v13);
create or replace view aggJoin1594845968943516844 as (
with aggView6049907395012681553 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=1950)
select v29, v18, v44, v46 from aggJoin5005114106395448031 join aggView6049907395012681553 using(v29));
create or replace view aggJoin5554698132222250611 as (
with aggView1852538117814180508 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v29, v18, v44 as v44, v46 as v46 from aggJoin1594845968943516844 join aggView1852538117814180508 using(v29));
create or replace view aggJoin6041084943539935437 as (
with aggView5604055634654034081 as (select v29, MIN(v45) as v45 from aggJoin8721511717864303138 group by v29,v45)
select movie_id as v29, keyword_id as v27, v45 from movie_keyword as mk, aggView5604055634654034081 where mk.movie_id=aggView5604055634654034081.v29);
create or replace view aggJoin818740018327972920 as (
with aggView8541095423317944822 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44, v46 from aggJoin5554698132222250611 join aggView8541095423317944822 using(v18));
create or replace view aggJoin4983821514901770160 as (
with aggView715986496352950474 as (select id as v27 from keyword as k where keyword= 'sequel')
select v29, v45 from aggJoin6041084943539935437 join aggView715986496352950474 using(v27));
create or replace view aggJoin7130346342070404923 as (
with aggView2916525609266466589 as (select v29, MIN(v44) as v44, MIN(v46) as v46 from aggJoin818740018327972920 group by v29,v44,v46)
select v45 as v45, v44, v46 from aggJoin4983821514901770160 join aggView2916525609266466589 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin7130346342070404923;
