create or replace view aggJoin1966300087633778798 as (
with aggView1989654654450001436 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView1989654654450001436 where v28 LIKE '%Money%');
create or replace view aggView6724214483951936854 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2555186555982871843 as (
with aggView8931953958702205442 as (select v24, MIN(v28) as v41 from aggJoin1966300087633778798 group by v24)
select movie_id as v24, company_id as v17, company_type_id as v18, v41 from movie_companies as mc, aggView8931953958702205442 where mc.movie_id=aggView8931953958702205442.v24);
create or replace view aggJoin5124308395843037646 as (
with aggView8474232234698924568 as (select v17, MIN(v2) as v39 from aggView6724214483951936854 group by v17)
select v24, v18, v41 as v41, v39 from aggJoin2555186555982871843 join aggView8474232234698924568 using(v17));
create or replace view aggJoin7364546256874224413 as (
with aggView4238591825535926969 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView4238591825535926969 where mk.keyword_id=aggView4238591825535926969.v22);
create or replace view aggJoin7980633013904769366 as (
with aggView4117290543173628602 as (select v24 from aggJoin7364546256874224413 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView4117290543173628602 where ml.movie_id=aggView4117290543173628602.v24);
create or replace view aggJoin4483278038907287795 as (
with aggView57834424101662585 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v41, v39 from aggJoin5124308395843037646 join aggView57834424101662585 using(v18));
create or replace view aggJoin181711977908256190 as (
with aggView3443298632794572977 as (select v24, MIN(v41) as v41, MIN(v39) as v39 from aggJoin4483278038907287795 group by v24,v39,v41)
select v13, v41, v39 from aggJoin7980633013904769366 join aggView3443298632794572977 using(v24));
create or replace view aggJoin4863010026992120250 as (
with aggView1401644800412099487 as (select v13, MIN(v41) as v41, MIN(v39) as v39 from aggJoin181711977908256190 group by v13,v39,v41)
select link as v14, v41, v39 from link_type as lt, aggView1401644800412099487 where lt.id=aggView1401644800412099487.v13 and link LIKE '%follows%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin4863010026992120250;
