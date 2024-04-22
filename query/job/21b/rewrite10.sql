create or replace view aggJoin4681246930124891818 as (
with aggView4129470312404260441 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=2000)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView4129470312404260441 where mc.movie_id=aggView4129470312404260441.v29);
create or replace view aggJoin8333953797899835208 as (
with aggView949540389191366008 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView949540389191366008 where ml.link_type_id=aggView949540389191366008.v13);
create or replace view aggJoin6372023225484001087 as (
with aggView8646274352035102129 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select v29, v18, v46, v44 from aggJoin4681246930124891818 join aggView8646274352035102129 using(v17));
create or replace view aggJoin5145479564300707418 as (
with aggView195434348835525312 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView195434348835525312 where mk.keyword_id=aggView195434348835525312.v27);
create or replace view aggJoin1278183551601669057 as (
with aggView7280394465666346651 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v46, v44 from aggJoin6372023225484001087 join aggView7280394465666346651 using(v18));
create or replace view aggJoin7549112126747505766 as (
with aggView5704453829472840793 as (select v29, MIN(v45) as v45 from aggJoin8333953797899835208 group by v29,v45)
select v29, v45 from aggJoin5145479564300707418 join aggView5704453829472840793 using(v29));
create or replace view aggJoin80243982655675104 as (
with aggView7008311540889418369 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin1278183551601669057 group by v29,v46,v44)
select movie_id as v29, info as v23, v46, v44 from movie_info as mi, aggView7008311540889418369 where mi.movie_id=aggView7008311540889418369.v29 and info IN ('Germany','German'));
create or replace view aggJoin6842077810403181266 as (
with aggView6558791662680696242 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin80243982655675104 group by v29,v46,v44)
select v45 as v45, v46, v44 from aggJoin7549112126747505766 join aggView6558791662680696242 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin6842077810403181266;
