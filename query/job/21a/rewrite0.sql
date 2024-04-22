create or replace view aggView6038424808696916534 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin187834168733570410 as (
with aggView233750620448117880 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView233750620448117880 where mk.keyword_id=aggView233750620448117880.v27);
create or replace view aggJoin2995041244162577064 as (
with aggView2889535002276275777 as (select v29 from aggJoin187834168733570410 group by v29)
select movie_id as v29, info as v23 from movie_info as mi, aggView2889535002276275777 where mi.movie_id=aggView2889535002276275777.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin5301264513773918130 as (
with aggView5641482087110827834 as (select v29 from aggJoin2995041244162577064 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView5641482087110827834 where t.id=aggView5641482087110827834.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggView6947537789750797434 as select v29, v33 from aggJoin5301264513773918130 group by v29,v33;
create or replace view aggJoin3372385858954033035 as (
with aggView7911969459504372935 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7911969459504372935 where ml.link_type_id=aggView7911969459504372935.v13);
create or replace view aggJoin4440889401818674973 as (
with aggView4041496970752165591 as (select v29, MIN(v33) as v46 from aggView6947537789750797434 group by v29)
select v29, v45 as v45, v46 from aggJoin3372385858954033035 join aggView4041496970752165591 using(v29));
create or replace view aggJoin9089630954803525469 as (
with aggView6709306890829784564 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin4440889401818674973 group by v29,v46,v45)
select company_id as v17, company_type_id as v18, v45, v46 from movie_companies as mc, aggView6709306890829784564 where mc.movie_id=aggView6709306890829784564.v29);
create or replace view aggJoin1996738888156940594 as (
with aggView4412436571084854186 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v45, v46 from aggJoin9089630954803525469 join aggView4412436571084854186 using(v18));
create or replace view aggJoin5228567733695460263 as (
with aggView695246845651324623 as (select v17, MIN(v45) as v45, MIN(v46) as v46 from aggJoin1996738888156940594 group by v17,v46,v45)
select v2, v45, v46 from aggView6038424808696916534 join aggView695246845651324623 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5228567733695460263;
