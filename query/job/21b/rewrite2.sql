create or replace view aggView8078567170916191924 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView7449096527567956198 as select title as v33, id as v29 from title as t where production_year<=2010 and production_year>=2000;
create or replace view aggJoin8140384938985678368 as (
with aggView6166869748818831395 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6166869748818831395 where ml.link_type_id=aggView6166869748818831395.v13);
create or replace view aggJoin1672207323702699712 as (
with aggView4307708946867181558 as (select v17, MIN(v2) as v44 from aggView8078567170916191924 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4307708946867181558 where mc.company_id=aggView4307708946867181558.v17);
create or replace view aggJoin3076071046569833374 as (
with aggView2567447816070380575 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView2567447816070380575 where mk.keyword_id=aggView2567447816070380575.v27);
create or replace view aggJoin6531942614671970402 as (
with aggView7653146382924980415 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin1672207323702699712 join aggView7653146382924980415 using(v18));
create or replace view aggJoin5845681095037748476 as (
with aggView8377739074983559793 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v29 from aggJoin3076071046569833374 join aggView8377739074983559793 using(v29));
create or replace view aggJoin75600320976941590 as (
with aggView472033618881844680 as (select v29 from aggJoin5845681095037748476 group by v29)
select v29, v45 as v45 from aggJoin8140384938985678368 join aggView472033618881844680 using(v29));
create or replace view aggJoin7615903954448567064 as (
with aggView6165195373277181767 as (select v29, MIN(v44) as v44 from aggJoin6531942614671970402 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin75600320976941590 join aggView6165195373277181767 using(v29));
create or replace view aggJoin4456740023678203536 as (
with aggView6968594753049646034 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin7615903954448567064 group by v29,v45,v44)
select v33, v45, v44 from aggView7449096527567956198 join aggView6968594753049646034 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin4456740023678203536;
