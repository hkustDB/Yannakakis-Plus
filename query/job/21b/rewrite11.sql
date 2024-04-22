create or replace view aggJoin3716265679647794113 as (
with aggView2121037999884015019 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView2121037999884015019 where ml.link_type_id=aggView2121037999884015019.v13);
create or replace view aggJoin6838287039530696430 as (
with aggView8956260407752574931 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView8956260407752574931 where mc.company_id=aggView8956260407752574931.v17);
create or replace view aggJoin3251865875473169733 as (
with aggView159599334679035955 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=2000)
select v29, v45, v46 from aggJoin3716265679647794113 join aggView159599334679035955 using(v29));
create or replace view aggJoin2860124705399096998 as (
with aggView985786663121272670 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView985786663121272670 where mk.keyword_id=aggView985786663121272670.v27);
create or replace view aggJoin3848147175321626442 as (
with aggView9037841916183582641 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin6838287039530696430 join aggView9037841916183582641 using(v18));
create or replace view aggJoin7952455826892498602 as (
with aggView8485320298356055576 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v29, v45 as v45, v46 as v46 from aggJoin3251865875473169733 join aggView8485320298356055576 using(v29));
create or replace view aggJoin7843854611781470575 as (
with aggView680715215717618425 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin7952455826892498602 group by v29,v46,v45)
select v29, v45, v46 from aggJoin2860124705399096998 join aggView680715215717618425 using(v29));
create or replace view aggJoin2274724146150804871 as (
with aggView748960863516204058 as (select v29, MIN(v44) as v44 from aggJoin3848147175321626442 group by v29,v44)
select v45 as v45, v46 as v46, v44 from aggJoin7843854611781470575 join aggView748960863516204058 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin2274724146150804871;
