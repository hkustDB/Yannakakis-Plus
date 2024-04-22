create or replace view aggJoin1309327017796879218 as (
with aggView720267513273325714 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView720267513273325714 where mc.company_id=aggView720267513273325714.v17);
create or replace view aggJoin3084161182001922372 as (
with aggView7003566726357418314 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView7003566726357418314 where ml.link_type_id=aggView7003566726357418314.v13);
create or replace view aggJoin928509890959551230 as (
with aggView892461846556920238 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView892461846556920238 where mk.keyword_id=aggView892461846556920238.v22);
create or replace view aggJoin112793477669072381 as (
with aggView143627896871866117 as (select v24, MIN(v40) as v40 from aggJoin3084161182001922372 group by v24,v40)
select id as v24, title as v28, production_year as v31, v40 from title as t, aggView143627896871866117 where t.id=aggView143627896871866117.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin4615444359006271582 as (
with aggView5200959233604200803 as (select v24, MIN(v40) as v40, MIN(v28) as v41 from aggJoin112793477669072381 group by v24,v40)
select v24, v18, v39 as v39, v40, v41 from aggJoin1309327017796879218 join aggView5200959233604200803 using(v24));
create or replace view aggJoin5345080220175543801 as (
with aggView6000925945426497885 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v40, v41 from aggJoin4615444359006271582 join aggView6000925945426497885 using(v18));
create or replace view aggJoin6366870554770269410 as (
with aggView974789289314372063 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v41) as v41 from aggJoin5345080220175543801 group by v24,v39,v40,v41)
select v39, v40, v41 from aggJoin928509890959551230 join aggView974789289314372063 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6366870554770269410;
