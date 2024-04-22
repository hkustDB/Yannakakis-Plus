create or replace view aggJoin9214907810793820097 as (
with aggView5942601564904980346 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5942601564904980346 where mc.company_id=aggView5942601564904980346.v17);
create or replace view aggJoin8589255721608316109 as (
with aggView6335649603199315606 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6335649603199315606 where ml.link_type_id=aggView6335649603199315606.v13);
create or replace view aggJoin4541348343423473984 as (
with aggView2840597412030131940 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin9214907810793820097 join aggView2840597412030131940 using(v18));
create or replace view aggJoin1260135389501379573 as (
with aggView1758355376980475028 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView1758355376980475028 where mk.keyword_id=aggView1758355376980475028.v27);
create or replace view aggJoin2750180194782157559 as (
with aggView5620220688755657765 as (select v29, MIN(v44) as v44 from aggJoin4541348343423473984 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin8589255721608316109 join aggView5620220688755657765 using(v29));
create or replace view aggJoin8428748725559324876 as (
with aggView3652302860429115540 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin2750180194782157559 group by v29,v44,v45)
select id as v29, title as v33, production_year as v36, v45, v44 from title as t, aggView3652302860429115540 where t.id=aggView3652302860429115540.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin6437599128557780200 as (
with aggView7630761399521138226 as (select v29, MIN(v45) as v45, MIN(v44) as v44, MIN(v33) as v46 from aggJoin8428748725559324876 group by v29,v44,v45)
select v29, v45, v44, v46 from aggJoin1260135389501379573 join aggView7630761399521138226 using(v29));
create or replace view aggJoin5872156421308391875 as (
with aggView1991030447171192560 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v45 as v45, v44 as v44, v46 as v46 from aggJoin6437599128557780200 join aggView1991030447171192560 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5872156421308391875;
