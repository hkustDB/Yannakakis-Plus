create or replace view aggJoin6327802645903159962 as (
with aggView2735623665082463360 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView2735623665082463360 where ml.link_type_id=aggView2735623665082463360.v13);
create or replace view aggJoin4333359445801658659 as (
with aggView4785388041867108759 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4785388041867108759 where mc.company_id=aggView4785388041867108759.v17);
create or replace view aggJoin7942864245344386380 as (
with aggView3569961458708612858 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3569961458708612858 where mk.keyword_id=aggView3569961458708612858.v27);
create or replace view aggJoin3030402009725272583 as (
with aggView7165574197996687068 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin4333359445801658659 join aggView7165574197996687068 using(v18));
create or replace view aggJoin3456131601533629293 as (
with aggView8968110661340016061 as (select v29, MIN(v44) as v44 from aggJoin3030402009725272583 group by v29,v44)
select movie_id as v29, info as v23, v44 from movie_info as mi, aggView8968110661340016061 where mi.movie_id=aggView8968110661340016061.v29 and info IN ('Germany','German'));
create or replace view aggJoin1771906324553037702 as (
with aggView5036865470503079234 as (select v29, MIN(v44) as v44 from aggJoin3456131601533629293 group by v29,v44)
select id as v29, title as v33, production_year as v36, v44 from title as t, aggView5036865470503079234 where t.id=aggView5036865470503079234.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggJoin5994796497139177976 as (
with aggView6422012885637565988 as (select v29, MIN(v45) as v45 from aggJoin6327802645903159962 group by v29,v45)
select v29, v33, v36, v44 as v44, v45 from aggJoin1771906324553037702 join aggView6422012885637565988 using(v29));
create or replace view aggJoin6185156016329527269 as (
with aggView6949548404440760672 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v33) as v46 from aggJoin5994796497139177976 group by v29,v45,v44)
select v44, v45, v46 from aggJoin7942864245344386380 join aggView6949548404440760672 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin6185156016329527269;
