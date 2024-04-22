create or replace view aggJoin4744837425823421492 as (
with aggView2478260425312188223 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView2478260425312188223 where mc.company_id=aggView2478260425312188223.v17);
create or replace view aggJoin4869736674892834242 as (
with aggView9136085907983295571 as (select id as v24, title as v41 from title as t where production_year<=2000 and production_year>=1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView9136085907983295571 where ml.movie_id=aggView9136085907983295571.v24);
create or replace view aggJoin3973754443737449713 as (
with aggView6290448910593032156 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select v24, v41, v40 from aggJoin4869736674892834242 join aggView6290448910593032156 using(v13));
create or replace view aggJoin5975789372491146652 as (
with aggView1692829525551280654 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView1692829525551280654 where mk.keyword_id=aggView1692829525551280654.v22);
create or replace view aggJoin8688624990889806273 as (
with aggView2419205148584246587 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin4744837425823421492 join aggView2419205148584246587 using(v18));
create or replace view aggJoin6644024488665763027 as (
with aggView35194147407075047 as (select v24, MIN(v39) as v39 from aggJoin8688624990889806273 group by v24,v39)
select v24, v41 as v41, v40 as v40, v39 from aggJoin3973754443737449713 join aggView35194147407075047 using(v24));
create or replace view aggJoin5114938349523390580 as (
with aggView8169432271873372762 as (select v24, MIN(v41) as v41, MIN(v40) as v40, MIN(v39) as v39 from aggJoin6644024488665763027 group by v24,v39,v40,v41)
select v41, v40, v39 from aggJoin5975789372491146652 join aggView8169432271873372762 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5114938349523390580;
