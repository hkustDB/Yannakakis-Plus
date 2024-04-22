create or replace view aggView2693383149675727383 as select title as v33, id as v29 from title as t where production_year<=2010 and production_year>=2000;
create or replace view aggView6394624457417930379 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin5059752524032482055 as (
with aggView1579663551780102691 as (select v29, MIN(v33) as v46 from aggView2693383149675727383 group by v29)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView1579663551780102691 where mc.movie_id=aggView1579663551780102691.v29);
create or replace view aggJoin1140826967260163572 as (
with aggView7783892088581774123 as (select v17, MIN(v2) as v44 from aggView6394624457417930379 group by v17)
select v29, v18, v46 as v46, v44 from aggJoin5059752524032482055 join aggView7783892088581774123 using(v17));
create or replace view aggJoin1285568854144966589 as (
with aggView4073043439750893025 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4073043439750893025 where mk.keyword_id=aggView4073043439750893025.v27);
create or replace view aggJoin1130430393172040844 as (
with aggView8848687704603352032 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v46, v44 from aggJoin1140826967260163572 join aggView8848687704603352032 using(v18));
create or replace view aggJoin5510404874423933734 as (
with aggView6141272531186006235 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select movie_id as v29, link_type_id as v13 from movie_link as ml, aggView6141272531186006235 where ml.movie_id=aggView6141272531186006235.v29);
create or replace view aggJoin5052219205219368700 as (
with aggView2705614508983684548 as (select v29 from aggJoin1285568854144966589 group by v29)
select v29, v46 as v46, v44 as v44 from aggJoin1130430393172040844 join aggView2705614508983684548 using(v29));
create or replace view aggJoin3430575542173743936 as (
with aggView6074331479013086030 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin5052219205219368700 group by v29,v46,v44)
select v13, v46, v44 from aggJoin5510404874423933734 join aggView6074331479013086030 using(v29));
create or replace view aggJoin8204297158283661305 as (
with aggView5244050857974513098 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin3430575542173743936 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView5244050857974513098 where lt.id=aggView5244050857974513098.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin8204297158283661305;
