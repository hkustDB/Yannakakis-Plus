create or replace view aggView6076048288947117547 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2054122349071235047 as (
with aggView1137002835676342461 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView1137002835676342461 where mk.keyword_id=aggView1137002835676342461.v22);
create or replace view aggJoin7508011799629743854 as (
with aggView3628543752810304775 as (select v24 from aggJoin2054122349071235047 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView3628543752810304775 where t.id=aggView3628543752810304775.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggView6164805245133676711 as select v28, v24 from aggJoin7508011799629743854 group by v28,v24;
create or replace view aggJoin2447814874041465659 as (
with aggView8121095838024361061 as (select v17, MIN(v2) as v39 from aggView6076048288947117547 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView8121095838024361061 where mc.company_id=aggView8121095838024361061.v17);
create or replace view aggJoin2457255463540714626 as (
with aggView5632142170240122560 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView5632142170240122560 where ml.link_type_id=aggView5632142170240122560.v13);
create or replace view aggJoin1838666383367155843 as (
with aggView5239110612101522436 as (select v24, MIN(v40) as v40 from aggJoin2457255463540714626 group by v24,v40)
select v24, v18, v39 as v39, v40 from aggJoin2447814874041465659 join aggView5239110612101522436 using(v24));
create or replace view aggJoin915881336907247113 as (
with aggView1950944974527902898 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v40 from aggJoin1838666383367155843 join aggView1950944974527902898 using(v18));
create or replace view aggJoin5811936975108375973 as (
with aggView4431824234446270973 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin915881336907247113 group by v24,v39,v40)
select v28, v39, v40 from aggView6164805245133676711 join aggView4431824234446270973 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin5811936975108375973;
