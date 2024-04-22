create or replace view aggJoin6662188176608391471 as (
with aggView3645890133601710011 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView3645890133601710011 where mc.company_id=aggView3645890133601710011.v17);
create or replace view aggJoin7781625084517428785 as (
with aggView8186889787548005432 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView8186889787548005432 where ml.link_type_id=aggView8186889787548005432.v13);
create or replace view aggJoin7958197299476705692 as (
with aggView1452740707727165070 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView1452740707727165070 where mk.keyword_id=aggView1452740707727165070.v22);
create or replace view aggJoin642795890299510171 as (
with aggView5767001414560427332 as (select v24, MIN(v40) as v40 from aggJoin7781625084517428785 group by v24,v40)
select id as v24, title as v28, production_year as v31, v40 from title as t, aggView5767001414560427332 where t.id=aggView5767001414560427332.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggJoin526065910089894613 as (
with aggView5558678995644696612 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin6662188176608391471 join aggView5558678995644696612 using(v18));
create or replace view aggJoin3599961698918275640 as (
with aggView6757901011566348339 as (select v24, MIN(v39) as v39 from aggJoin526065910089894613 group by v24,v39)
select v24, v28, v31, v40 as v40, v39 from aggJoin642795890299510171 join aggView6757901011566348339 using(v24));
create or replace view aggJoin7097973074753302972 as (
with aggView614238133913816360 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v28) as v41 from aggJoin3599961698918275640 group by v24,v39,v40)
select v40, v39, v41 from aggJoin7958197299476705692 join aggView614238133913816360 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7097973074753302972;
