create or replace view aggJoin2193630416112966983 as (
with aggView5048283847817464924 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView5048283847817464924 where mc.company_id=aggView5048283847817464924.v17);
create or replace view aggJoin1676914165266880484 as (
with aggView1088227263803478172 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView1088227263803478172 where mk.keyword_id=aggView1088227263803478172.v22);
create or replace view aggJoin8138879038649199491 as (
with aggView1459396459785579552 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin2193630416112966983 join aggView1459396459785579552 using(v18));
create or replace view aggJoin8489738574783729326 as (
with aggView1850849234911102685 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin8138879038649199491 group by v24,v39)
select movie_id as v24, link_type_id as v13, v39, v40 from movie_link as ml, aggView1850849234911102685 where ml.movie_id=aggView1850849234911102685.v24);
create or replace view aggJoin2731637209194941806 as (
with aggView4067550368903307443 as (select id as v13 from link_type as lt)
select v24, v39, v40 from aggJoin8489738574783729326 join aggView4067550368903307443 using(v13));
create or replace view aggJoin243839409171682695 as (
with aggView5909800196849844425 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin2731637209194941806 group by v24,v39,v40)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView5909800196849844425 where t.id=aggView5909800196849844425.v24 and production_year>1950);
create or replace view aggJoin7369956815595347455 as (
with aggView6374525905080898822 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin243839409171682695 group by v24,v39,v40)
select v39, v40, v41 from aggJoin1676914165266880484 join aggView6374525905080898822 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7369956815595347455;
