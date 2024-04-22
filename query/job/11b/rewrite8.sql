create or replace view aggJoin1484191633972878626 as (
with aggView8412367016286674906 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView8412367016286674906 where v28 LIKE '%Money%');
create or replace view aggView925548873755259857 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin5208094041874927165 as (
with aggView1259915294541192395 as (select v17, MIN(v2) as v39 from aggView925548873755259857 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView1259915294541192395 where mc.company_id=aggView1259915294541192395.v17);
create or replace view aggJoin6626345217199709646 as (
with aggView5781448864230841953 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView5781448864230841953 where ml.link_type_id=aggView5781448864230841953.v13);
create or replace view aggJoin7677475274606767420 as (
with aggView6066526452074714921 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView6066526452074714921 where mk.keyword_id=aggView6066526452074714921.v22);
create or replace view aggJoin1233170847642516633 as (
with aggView4501167952254187049 as (select v24 from aggJoin7677475274606767420 group by v24)
select v24, v40 as v40 from aggJoin6626345217199709646 join aggView4501167952254187049 using(v24));
create or replace view aggJoin3977892465860477567 as (
with aggView2463267662899903526 as (select v24, MIN(v40) as v40 from aggJoin1233170847642516633 group by v24,v40)
select v24, v28, v40 from aggJoin1484191633972878626 join aggView2463267662899903526 using(v24));
create or replace view aggJoin1486956816573260713 as (
with aggView786036080971937173 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin5208094041874927165 join aggView786036080971937173 using(v18));
create or replace view aggJoin152767009794809997 as (
with aggView5697668820106093102 as (select v24, MIN(v39) as v39 from aggJoin1486956816573260713 group by v24,v39)
select v28, v40 as v40, v39 from aggJoin3977892465860477567 join aggView5697668820106093102 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin152767009794809997;
