create or replace view aggJoin5711800885289277042 as (
with aggView3735828130496334330 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView3735828130496334330 where mc.company_id=aggView3735828130496334330.v17);
create or replace view aggJoin3866443149247333527 as (
with aggView2231418500864503965 as (select id as v24, title as v41 from title as t where title LIKE '%Money%' and production_year= 1998)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView2231418500864503965 where ml.movie_id=aggView2231418500864503965.v24);
create or replace view aggJoin3189294738002033205 as (
with aggView8726920966776867334 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select v24, v41, v40 from aggJoin3866443149247333527 join aggView8726920966776867334 using(v13));
create or replace view aggJoin750276552433363355 as (
with aggView5188219503765363169 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView5188219503765363169 where mk.keyword_id=aggView5188219503765363169.v22);
create or replace view aggJoin4926025233227382322 as (
with aggView7041231616402960947 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin5711800885289277042 join aggView7041231616402960947 using(v18));
create or replace view aggJoin4204502986793379579 as (
with aggView1641815435500970953 as (select v24, MIN(v39) as v39 from aggJoin4926025233227382322 group by v24,v39)
select v24, v41 as v41, v40 as v40, v39 from aggJoin3189294738002033205 join aggView1641815435500970953 using(v24));
create or replace view aggJoin4327814397783068869 as (
with aggView8334947569901227957 as (select v24, MIN(v41) as v41, MIN(v40) as v40, MIN(v39) as v39 from aggJoin4204502986793379579 group by v24,v39,v40,v41)
select v41, v40, v39 from aggJoin750276552433363355 join aggView8334947569901227957 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4327814397783068869;
