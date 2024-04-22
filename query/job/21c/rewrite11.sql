create or replace view aggJoin1400827575573541956 as (
with aggView6822667044720273335 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView6822667044720273335 where mc.company_id=aggView6822667044720273335.v17);
create or replace view aggJoin5492545929171136969 as (
with aggView8233114232228395319 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView8233114232228395319 where ml.link_type_id=aggView8233114232228395319.v13);
create or replace view aggJoin5107264406918706972 as (
with aggView3937434309288542141 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin1400827575573541956 join aggView3937434309288542141 using(v18));
create or replace view aggJoin8872214449722490378 as (
with aggView4531173133627637271 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView4531173133627637271 where t.id=aggView4531173133627637271.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin1319598926120161443 as (
with aggView2745555305357363406 as (select v29, MIN(v33) as v46 from aggJoin8872214449722490378 group by v29)
select movie_id as v29, keyword_id as v27, v46 from movie_keyword as mk, aggView2745555305357363406 where mk.movie_id=aggView2745555305357363406.v29);
create or replace view aggJoin8227038096018970362 as (
with aggView7992590660421519243 as (select id as v27 from keyword as k where keyword= 'sequel')
select v29, v46 from aggJoin1319598926120161443 join aggView7992590660421519243 using(v27));
create or replace view aggJoin4773435378407618663 as (
with aggView2264225153022553773 as (select v29, MIN(v45) as v45 from aggJoin5492545929171136969 group by v29,v45)
select v29, v44 as v44, v45 from aggJoin5107264406918706972 join aggView2264225153022553773 using(v29));
create or replace view aggJoin8179200398275735780 as (
with aggView3234326627860620009 as (select v29, MIN(v44) as v44, MIN(v45) as v45 from aggJoin4773435378407618663 group by v29,v44,v45)
select v46 as v46, v44, v45 from aggJoin8227038096018970362 join aggView3234326627860620009 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin8179200398275735780;
