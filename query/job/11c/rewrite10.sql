create or replace view aggView4413073927919667061 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin2342371417252974550 as (
with aggView8038779986713574349 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView8038779986713574349 where mk.keyword_id=aggView8038779986713574349.v22);
create or replace view aggJoin6338696631479847417 as (
with aggView6314781633426720691 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView6314781633426720691 where mc.company_type_id=aggView6314781633426720691.v18);
create or replace view aggJoin7508803842113518680 as (
with aggView8937833100944642881 as (select v24 from aggJoin2342371417252974550 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView8937833100944642881 where t.id=aggView8937833100944642881.v24 and production_year>1950);
create or replace view aggView864725670005697426 as select v28, v24 from aggJoin7508803842113518680 group by v28,v24;
create or replace view aggJoin4314295299999213177 as (
with aggView179428698993059797 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView179428698993059797 where ml.link_type_id=aggView179428698993059797.v13);
create or replace view aggJoin4514087175953950652 as (
with aggView7544152397580483875 as (select v24 from aggJoin4314295299999213177 group by v24)
select v24, v17, v19 from aggJoin6338696631479847417 join aggView7544152397580483875 using(v24));
create or replace view aggView6480078545336790192 as select v19, v24, v17 from aggJoin4514087175953950652 group by v19,v24,v17;
create or replace view aggJoin2174036035236152489 as (
with aggView75874851079880495 as (select v24, MIN(v28) as v41 from aggView864725670005697426 group by v24)
select v19, v17, v41 from aggView6480078545336790192 join aggView75874851079880495 using(v24));
create or replace view aggJoin3718023881616678943 as (
with aggView1276063488290535830 as (select v17, MIN(v2) as v39 from aggView4413073927919667061 group by v17)
select v19, v41 as v41, v39 from aggJoin2174036035236152489 join aggView1276063488290535830 using(v17));
select MIN(v39) as v39,MIN(v19) as v40,MIN(v41) as v41 from aggJoin3718023881616678943;
