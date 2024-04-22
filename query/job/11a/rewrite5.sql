create or replace view aggJoin1011053193852282460 as (
with aggView8007679665676310134 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView8007679665676310134 where mc.company_id=aggView8007679665676310134.v17);
create or replace view aggJoin8244637238670672679 as (
with aggView3527726335105635081 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView3527726335105635081 where ml.link_type_id=aggView3527726335105635081.v13);
create or replace view aggJoin6971255042039995042 as (
with aggView7970344945234179611 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView7970344945234179611 where mk.keyword_id=aggView7970344945234179611.v22);
create or replace view aggJoin2210650766572809396 as (
with aggView276005201154413529 as (select v24, MIN(v40) as v40 from aggJoin8244637238670672679 group by v24,v40)
select id as v24, title as v28, production_year as v31, v40 from title as t, aggView276005201154413529 where t.id=aggView276005201154413529.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin5686345469958629826 as (
with aggView5116903661689986586 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin1011053193852282460 join aggView5116903661689986586 using(v18));
create or replace view aggJoin5165962111618572529 as (
with aggView941464541968810098 as (select v24, MIN(v39) as v39 from aggJoin5686345469958629826 group by v24,v39)
select v24, v28, v31, v40 as v40, v39 from aggJoin2210650766572809396 join aggView941464541968810098 using(v24));
create or replace view aggJoin6857026768501942095 as (
with aggView5051203762172892601 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v28) as v41 from aggJoin5165962111618572529 group by v24,v39,v40)
select v40, v39, v41 from aggJoin6971255042039995042 join aggView5051203762172892601 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6857026768501942095;
