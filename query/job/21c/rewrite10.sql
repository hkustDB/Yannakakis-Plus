create or replace view aggJoin2921686505405188268 as (
with aggView4199209382951643072 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4199209382951643072 where mc.company_id=aggView4199209382951643072.v17);
create or replace view aggJoin5454840496017357634 as (
with aggView6235277348741251563 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6235277348741251563 where ml.link_type_id=aggView6235277348741251563.v13);
create or replace view aggJoin5465265617254156315 as (
with aggView4077310609791758302 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin2921686505405188268 join aggView4077310609791758302 using(v18));
create or replace view aggJoin6948651814336262557 as (
with aggView8844285116943925225 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView8844285116943925225 where mk.keyword_id=aggView8844285116943925225.v27);
create or replace view aggJoin7734889890147863153 as (
with aggView63918164426055960 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v29, v45 as v45 from aggJoin5454840496017357634 join aggView63918164426055960 using(v29));
create or replace view aggJoin7724935157173862672 as (
with aggView2203922463527074662 as (select v29, MIN(v45) as v45 from aggJoin7734889890147863153 group by v29,v45)
select id as v29, title as v33, production_year as v36, v45 from title as t, aggView2203922463527074662 where t.id=aggView2203922463527074662.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin8032909299933832571 as (
with aggView5284420500039055984 as (select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin7724935157173862672 group by v29,v45)
select v29, v44 as v44, v45, v46 from aggJoin5465265617254156315 join aggView5284420500039055984 using(v29));
create or replace view aggJoin104359306888843745 as (
with aggView3098218654551464828 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin8032909299933832571 group by v29,v44,v46,v45)
select v44, v45, v46 from aggJoin6948651814336262557 join aggView3098218654551464828 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin104359306888843745;
