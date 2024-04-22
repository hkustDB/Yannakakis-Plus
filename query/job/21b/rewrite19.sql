create or replace view aggJoin6977345184750636679 as (
with aggView964478141649162340 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=2000)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView964478141649162340 where mc.movie_id=aggView964478141649162340.v29);
create or replace view aggJoin6849266774551322729 as (
with aggView748172870377820438 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView748172870377820438 where ml.link_type_id=aggView748172870377820438.v13);
create or replace view aggJoin374965941209625002 as (
with aggView1996749718088718635 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select v29, v18, v46, v44 from aggJoin6977345184750636679 join aggView1996749718088718635 using(v17));
create or replace view aggJoin3666055421444014325 as (
with aggView9155548219477994079 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView9155548219477994079 where mk.keyword_id=aggView9155548219477994079.v27);
create or replace view aggJoin4253501132573837683 as (
with aggView9163120356505760942 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v46, v44 from aggJoin374965941209625002 join aggView9163120356505760942 using(v18));
create or replace view aggJoin8572705836367132718 as (
with aggView8910029109148828765 as (select v29, MIN(v45) as v45 from aggJoin6849266774551322729 group by v29,v45)
select v29, v45 from aggJoin3666055421444014325 join aggView8910029109148828765 using(v29));
create or replace view aggJoin8877024027665815637 as (
with aggView3105227469042186078 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin4253501132573837683 group by v29,v46,v44)
select v29, v45 as v45, v46, v44 from aggJoin8572705836367132718 join aggView3105227469042186078 using(v29));
create or replace view aggJoin1784569619288599429 as (
with aggView2260787004268134237 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v45 as v45, v46 as v46, v44 as v44 from aggJoin8877024027665815637 join aggView2260787004268134237 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin1784569619288599429;
