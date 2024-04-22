create or replace view aggJoin4709185230641535753 as (
with aggView7653514438665763534 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView7653514438665763534 where mc.company_id=aggView7653514438665763534.v17);
create or replace view aggJoin8355512860909855754 as (
with aggView3260762149685407129 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3260762149685407129 where ml.link_type_id=aggView3260762149685407129.v13);
create or replace view aggJoin6115923684347058258 as (
with aggView3140955003087863863 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin4709185230641535753 join aggView3140955003087863863 using(v18));
create or replace view aggJoin6647171119758295997 as (
with aggView6403403377771128648 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView6403403377771128648 where mk.keyword_id=aggView6403403377771128648.v27);
create or replace view aggJoin6881024565523652549 as (
with aggView1210303870408654387 as (select v29, MIN(v45) as v45 from aggJoin8355512860909855754 group by v29,v45)
select id as v29, title as v33, production_year as v36, v45 from title as t, aggView1210303870408654387 where t.id=aggView1210303870408654387.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin4240824016392608241 as (
with aggView6200867213333266871 as (select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin6881024565523652549 group by v29,v45)
select movie_id as v29, info as v23, v45, v46 from movie_info as mi, aggView6200867213333266871 where mi.movie_id=aggView6200867213333266871.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin3572118370952858703 as (
with aggView5618371935782180443 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin4240824016392608241 group by v29,v45,v46)
select v29, v44 as v44, v45, v46 from aggJoin6115923684347058258 join aggView5618371935782180443 using(v29));
create or replace view aggJoin3672659498195141101 as (
with aggView8143939302733498786 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin3572118370952858703 group by v29,v44,v46,v45)
select v44, v45, v46 from aggJoin6647171119758295997 join aggView8143939302733498786 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin3672659498195141101;
