create or replace view aggView6324048582700141144 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin7888654745019080948 as (
with aggView1789409503984541064 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView1789409503984541064 where t.id=aggView1789409503984541064.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggView1776202681408503217 as select v33, v29 from aggJoin7888654745019080948 group by v33,v29;
create or replace view aggJoin3929973260389183886 as (
with aggView1400709993615623908 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView1400709993615623908 where ml.link_type_id=aggView1400709993615623908.v13);
create or replace view aggJoin1619433955368194393 as (
with aggView303755839392294051 as (select v17, MIN(v2) as v44 from aggView6324048582700141144 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView303755839392294051 where mc.company_id=aggView303755839392294051.v17);
create or replace view aggJoin1248469050850776149 as (
with aggView8179918685663280732 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView8179918685663280732 where mk.keyword_id=aggView8179918685663280732.v27);
create or replace view aggJoin4268073891365486544 as (
with aggView3548627485905043187 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin1619433955368194393 join aggView3548627485905043187 using(v18));
create or replace view aggJoin157297004212127784 as (
with aggView1441075582642756563 as (select v29 from aggJoin1248469050850776149 group by v29)
select v29, v44 as v44 from aggJoin4268073891365486544 join aggView1441075582642756563 using(v29));
create or replace view aggJoin3065908767125860676 as (
with aggView895468232187152551 as (select v29, MIN(v44) as v44 from aggJoin157297004212127784 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin3929973260389183886 join aggView895468232187152551 using(v29));
create or replace view aggJoin2516078941413526290 as (
with aggView5473666751358708256 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin3065908767125860676 group by v29,v45,v44)
select v33, v45, v44 from aggView1776202681408503217 join aggView5473666751358708256 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin2516078941413526290;
