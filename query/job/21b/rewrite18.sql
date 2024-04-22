create or replace view aggJoin2178462046750808902 as (
with aggView6729106918734587392 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6729106918734587392 where ml.link_type_id=aggView6729106918734587392.v13);
create or replace view aggJoin2733873016927411591 as (
with aggView5859569276806119358 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5859569276806119358 where mc.company_id=aggView5859569276806119358.v17);
create or replace view aggJoin7775300187806593179 as (
with aggView2327683358277826474 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView2327683358277826474 where mk.keyword_id=aggView2327683358277826474.v27);
create or replace view aggJoin132183533399234300 as (
with aggView2694657360772599483 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin2733873016927411591 join aggView2694657360772599483 using(v18));
create or replace view aggJoin1420002520577021982 as (
with aggView2817088841067449725 as (select v29, MIN(v45) as v45 from aggJoin2178462046750808902 group by v29,v45)
select v29, v45 from aggJoin7775300187806593179 join aggView2817088841067449725 using(v29));
create or replace view aggJoin2274472112791786604 as (
with aggView6905073523944370208 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView6905073523944370208 where t.id=aggView6905073523944370208.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggJoin857203224017940013 as (
with aggView8503805828152427830 as (select v29, MIN(v33) as v46 from aggJoin2274472112791786604 group by v29)
select v29, v45 as v45, v46 from aggJoin1420002520577021982 join aggView8503805828152427830 using(v29));
create or replace view aggJoin1614736828086484741 as (
with aggView6621967101435147552 as (select v29, MIN(v44) as v44 from aggJoin132183533399234300 group by v29,v44)
select v45 as v45, v46 as v46, v44 from aggJoin857203224017940013 join aggView6621967101435147552 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin1614736828086484741;
