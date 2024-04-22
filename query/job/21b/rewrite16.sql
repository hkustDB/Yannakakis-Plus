create or replace view aggView4563443646787783143 as select title as v33, id as v29 from title as t where production_year<=2010 and production_year>=2000;
create or replace view aggView6101577229696569950 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin7706085611983295749 as (
with aggView5816305246133714768 as (select v17, MIN(v2) as v44 from aggView6101577229696569950 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5816305246133714768 where mc.company_id=aggView5816305246133714768.v17);
create or replace view aggJoin9171685568877025431 as (
with aggView8419438800291318652 as (select v29, MIN(v33) as v46 from aggView4563443646787783143 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView8419438800291318652 where ml.movie_id=aggView8419438800291318652.v29);
create or replace view aggJoin6872483016747742669 as (
with aggView3295281131201858975 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3295281131201858975 where mk.keyword_id=aggView3295281131201858975.v27);
create or replace view aggJoin2103300124773271592 as (
with aggView2288292302830098174 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin7706085611983295749 join aggView2288292302830098174 using(v18));
create or replace view aggJoin3903367069357527756 as (
with aggView6331333839675074709 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v29, v44 as v44 from aggJoin2103300124773271592 join aggView6331333839675074709 using(v29));
create or replace view aggJoin4949412045030225249 as (
with aggView6308602004453037741 as (select v29 from aggJoin6872483016747742669 group by v29)
select v29, v44 as v44 from aggJoin3903367069357527756 join aggView6308602004453037741 using(v29));
create or replace view aggJoin4086769496475194703 as (
with aggView6453663729759302478 as (select v29, MIN(v44) as v44 from aggJoin4949412045030225249 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin9171685568877025431 join aggView6453663729759302478 using(v29));
create or replace view aggJoin7368330710792830894 as (
with aggView6181878955478791959 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin4086769496475194703 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView6181878955478791959 where lt.id=aggView6181878955478791959.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin7368330710792830894;
