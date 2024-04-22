create or replace view aggJoin5488054955810289493 as (
with aggView4719081735558853232 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView4719081735558853232 where mc.company_id=aggView4719081735558853232.v17);
create or replace view aggJoin640532725325476830 as (
with aggView2180955897432473948 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView2180955897432473948 where ml.link_type_id=aggView2180955897432473948.v13);
create or replace view aggJoin6499063115554941544 as (
with aggView8682552467950480958 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView8682552467950480958 where mk.keyword_id=aggView8682552467950480958.v22);
create or replace view aggJoin2965352131695318202 as (
with aggView427075173040912080 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin5488054955810289493 join aggView427075173040912080 using(v18));
create or replace view aggJoin9035014349491896387 as (
with aggView3784434447044540290 as (select v24, MIN(v39) as v39 from aggJoin2965352131695318202 group by v24,v39)
select v24, v40 as v40, v39 from aggJoin640532725325476830 join aggView3784434447044540290 using(v24));
create or replace view aggJoin7418081563511912388 as (
with aggView1511530123174693014 as (select v24, MIN(v40) as v40, MIN(v39) as v39 from aggJoin9035014349491896387 group by v24,v39,v40)
select id as v24, title as v28, production_year as v31, v40, v39 from title as t, aggView1511530123174693014 where t.id=aggView1511530123174693014.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin3415581637333325460 as (
with aggView5573532800958772661 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v28) as v41 from aggJoin7418081563511912388 group by v24,v39,v40)
select v40, v39, v41 from aggJoin6499063115554941544 join aggView5573532800958772661 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin3415581637333325460;
