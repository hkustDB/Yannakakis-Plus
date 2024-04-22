create or replace view aggView6602227138087260444 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin3518065955544874509 as (
with aggView1438559378268384493 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView1438559378268384493 where mk.keyword_id=aggView1438559378268384493.v22);
create or replace view aggJoin7876360009561116876 as (
with aggView5546283027096250257 as (select v24 from aggJoin3518065955544874509 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView5546283027096250257 where t.id=aggView5546283027096250257.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggView159584732526597487 as select v28, v24 from aggJoin7876360009561116876 group by v28,v24;
create or replace view aggJoin6336264616324585441 as (
with aggView7505483795196708345 as (select v24, MIN(v28) as v41 from aggView159584732526597487 group by v24)
select movie_id as v24, company_id as v17, company_type_id as v18, v41 from movie_companies as mc, aggView7505483795196708345 where mc.movie_id=aggView7505483795196708345.v24);
create or replace view aggJoin8135945097943739630 as (
with aggView63706087782662080 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView63706087782662080 where ml.link_type_id=aggView63706087782662080.v13);
create or replace view aggJoin5477003062076684827 as (
with aggView1469638131058713173 as (select v24, MIN(v40) as v40 from aggJoin8135945097943739630 group by v24,v40)
select v17, v18, v41 as v41, v40 from aggJoin6336264616324585441 join aggView1469638131058713173 using(v24));
create or replace view aggJoin4169210895441094214 as (
with aggView6889516108741984258 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v41, v40 from aggJoin5477003062076684827 join aggView6889516108741984258 using(v18));
create or replace view aggJoin7412152982514464024 as (
with aggView5840658617054633888 as (select v17, MIN(v41) as v41, MIN(v40) as v40 from aggJoin4169210895441094214 group by v17,v40,v41)
select v2, v41, v40 from aggView6602227138087260444 join aggView5840658617054633888 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7412152982514464024;
