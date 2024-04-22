create or replace view aggJoin7323573005192844592 as (
with aggView8528076775671897719 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView8528076775671897719 where mc.company_id=aggView8528076775671897719.v17);
create or replace view aggJoin8091067307391742755 as (
with aggView1988716948468244110 as (select id as v24, title as v41 from title as t where title LIKE '%Money%' and production_year= 1998)
select v24, v18, v39, v41 from aggJoin7323573005192844592 join aggView1988716948468244110 using(v24));
create or replace view aggJoin487781978538980414 as (
with aggView3378468011821925969 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView3378468011821925969 where ml.link_type_id=aggView3378468011821925969.v13);
create or replace view aggJoin1209124562358304582 as (
with aggView2553642775400230816 as (select v24, MIN(v40) as v40 from aggJoin487781978538980414 group by v24,v40)
select movie_id as v24, keyword_id as v22, v40 from movie_keyword as mk, aggView2553642775400230816 where mk.movie_id=aggView2553642775400230816.v24);
create or replace view aggJoin6316882732027417510 as (
with aggView4024156238967932316 as (select id as v22 from keyword as k where keyword= 'sequel')
select v24, v40 from aggJoin1209124562358304582 join aggView4024156238967932316 using(v22));
create or replace view aggJoin2016547866066753365 as (
with aggView827938571705230628 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v41 from aggJoin8091067307391742755 join aggView827938571705230628 using(v18));
create or replace view aggJoin5049224369625991250 as (
with aggView1336115219785467771 as (select v24, MIN(v39) as v39, MIN(v41) as v41 from aggJoin2016547866066753365 group by v24,v39,v41)
select v40 as v40, v39, v41 from aggJoin6316882732027417510 join aggView1336115219785467771 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5049224369625991250;
