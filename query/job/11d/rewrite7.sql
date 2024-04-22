create or replace view aggJoin4087073017526069666 as (
with aggView6875909614125136223 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView6875909614125136223 where mc.company_id=aggView6875909614125136223.v17);
create or replace view aggJoin4273800526539476823 as (
with aggView3344320700596496287 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView3344320700596496287 where mk.keyword_id=aggView3344320700596496287.v22);
create or replace view aggJoin5388836942914579795 as (
with aggView7675549987546466984 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin4087073017526069666 join aggView7675549987546466984 using(v18));
create or replace view aggJoin1337735733327087387 as (
with aggView444466473852236790 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin5388836942914579795 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView444466473852236790 where t.id=aggView444466473852236790.v24 and production_year>1950);
create or replace view aggJoin2732103644059558554 as (
with aggView1356084648082827074 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView1356084648082827074 where ml.link_type_id=aggView1356084648082827074.v13);
create or replace view aggJoin187115452173992900 as (
with aggView6441273342906185917 as (select v24 from aggJoin2732103644059558554 group by v24)
select v24, v28, v31, v39 as v39, v40 as v40 from aggJoin1337735733327087387 join aggView6441273342906185917 using(v24));
create or replace view aggJoin4645826377624554898 as (
with aggView6391664474484264871 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin187115452173992900 group by v24,v39,v40)
select v39, v40, v41 from aggJoin4273800526539476823 join aggView6391664474484264871 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4645826377624554898;
