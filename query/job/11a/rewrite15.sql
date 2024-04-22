create or replace view aggJoin3054200708553106920 as (
with aggView7532666494753464826 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView7532666494753464826 where mc.company_id=aggView7532666494753464826.v17);
create or replace view aggJoin6866054648789395819 as (
with aggView8771578073458717806 as (select id as v24, title as v41 from title as t where production_year<=2000 and production_year>=1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView8771578073458717806 where ml.movie_id=aggView8771578073458717806.v24);
create or replace view aggJoin5827051250846293181 as (
with aggView3047914475160261135 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select v24, v41, v40 from aggJoin6866054648789395819 join aggView3047914475160261135 using(v13));
create or replace view aggJoin3510827407858853701 as (
with aggView7760185428376787887 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView7760185428376787887 where mk.keyword_id=aggView7760185428376787887.v22);
create or replace view aggJoin451573629360971976 as (
with aggView2869755874810152103 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin5827051250846293181 group by v24,v40,v41)
select v24, v18, v39 as v39, v41, v40 from aggJoin3054200708553106920 join aggView2869755874810152103 using(v24));
create or replace view aggJoin7946383874363935527 as (
with aggView2383427547714219005 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v41, v40 from aggJoin451573629360971976 join aggView2383427547714219005 using(v18));
create or replace view aggJoin1793461691006954046 as (
with aggView4141838093499655500 as (select v24, MIN(v39) as v39, MIN(v41) as v41, MIN(v40) as v40 from aggJoin7946383874363935527 group by v24,v39,v40,v41)
select v39, v41, v40 from aggJoin3510827407858853701 join aggView4141838093499655500 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1793461691006954046;
