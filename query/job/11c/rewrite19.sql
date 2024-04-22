create or replace view aggJoin1735736988571230621 as (
with aggView4912062676305029507 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView4912062676305029507 where mc.company_id=aggView4912062676305029507.v17);
create or replace view aggJoin485448635994353125 as (
with aggView1674636670166376795 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView1674636670166376795 where ml.movie_id=aggView1674636670166376795.v24);
create or replace view aggJoin1268987820081826309 as (
with aggView2512760859583762515 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView2512760859583762515 where mk.keyword_id=aggView2512760859583762515.v22);
create or replace view aggJoin2112346013081996295 as (
with aggView9069246632697329966 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin1735736988571230621 join aggView9069246632697329966 using(v18));
create or replace view aggJoin5924524697391546787 as (
with aggView2852159361339747530 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin2112346013081996295 group by v24,v39)
select v24, v39, v40 from aggJoin1268987820081826309 join aggView2852159361339747530 using(v24));
create or replace view aggJoin7510535279630490368 as (
with aggView7008356332103807214 as (select id as v13 from link_type as lt)
select v24, v41 from aggJoin485448635994353125 join aggView7008356332103807214 using(v13));
create or replace view aggJoin267345923590891533 as (
with aggView1897330502812729727 as (select v24, MIN(v41) as v41 from aggJoin7510535279630490368 group by v24,v41)
select v39 as v39, v40 as v40, v41 from aggJoin5924524697391546787 join aggView1897330502812729727 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin267345923590891533;
