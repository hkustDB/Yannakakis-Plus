create or replace view aggJoin566706363754258460 as (
with aggView1243343934232431550 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView1243343934232431550 where ml.link_type_id=aggView1243343934232431550.v13);
create or replace view aggJoin8461562064618953598 as (
with aggView5105989730109531683 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5105989730109531683 where mc.company_id=aggView5105989730109531683.v17);
create or replace view aggJoin2313124207087557791 as (
with aggView2086241647887883482 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView2086241647887883482 where mk.keyword_id=aggView2086241647887883482.v27);
create or replace view aggJoin3241238025514979620 as (
with aggView627714443578124734 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin8461562064618953598 join aggView627714443578124734 using(v18));
create or replace view aggJoin7103261311461625660 as (
with aggView6921371872304435520 as (select v29, MIN(v45) as v45 from aggJoin566706363754258460 group by v29,v45)
select movie_id as v29, info as v23, v45 from movie_info as mi, aggView6921371872304435520 where mi.movie_id=aggView6921371872304435520.v29 and info IN ('Germany','German'));
create or replace view aggJoin7308209361581160646 as (
with aggView5832966226414202009 as (select v29, MIN(v45) as v45 from aggJoin7103261311461625660 group by v29,v45)
select id as v29, title as v33, production_year as v36, v45 from title as t, aggView5832966226414202009 where t.id=aggView5832966226414202009.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggJoin7845893323280802541 as (
with aggView1747446713768163598 as (select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin7308209361581160646 group by v29,v45)
select v29, v44 as v44, v45, v46 from aggJoin3241238025514979620 join aggView1747446713768163598 using(v29));
create or replace view aggJoin864092232441878217 as (
with aggView4401795920723835003 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin7845893323280802541 group by v29,v46,v45,v44)
select v44, v45, v46 from aggJoin2313124207087557791 join aggView4401795920723835003 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin864092232441878217;
