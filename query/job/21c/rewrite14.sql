create or replace view aggJoin8770925428144904785 as (
with aggView6629988051796605468 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView6629988051796605468 where mc.company_id=aggView6629988051796605468.v17);
create or replace view aggJoin19664306609993063 as (
with aggView5983319289143359302 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView5983319289143359302 where ml.link_type_id=aggView5983319289143359302.v13);
create or replace view aggJoin5693296662221079229 as (
with aggView5899212336285153683 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin8770925428144904785 join aggView5899212336285153683 using(v18));
create or replace view aggJoin7186063497918583037 as (
with aggView1115549294337393251 as (select v29, MIN(v44) as v44 from aggJoin5693296662221079229 group by v29,v44)
select movie_id as v29, info as v23, v44 from movie_info as mi, aggView1115549294337393251 where mi.movie_id=aggView1115549294337393251.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin5410757042690744870 as (
with aggView8795322745005652515 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView8795322745005652515 where mk.keyword_id=aggView8795322745005652515.v27);
create or replace view aggJoin2522383884479021111 as (
with aggView7093288430461451647 as (select v29, MIN(v45) as v45 from aggJoin19664306609993063 group by v29,v45)
select id as v29, title as v33, production_year as v36, v45 from title as t, aggView7093288430461451647 where t.id=aggView7093288430461451647.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin9019066521940706392 as (
with aggView6945672332459851233 as (select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin2522383884479021111 group by v29,v45)
select v29, v45, v46 from aggJoin5410757042690744870 join aggView6945672332459851233 using(v29));
create or replace view aggJoin9110708627907765730 as (
with aggView8353064342832160527 as (select v29, MIN(v44) as v44 from aggJoin7186063497918583037 group by v29,v44)
select v45 as v45, v46 as v46, v44 from aggJoin9019066521940706392 join aggView8353064342832160527 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin9110708627907765730;
