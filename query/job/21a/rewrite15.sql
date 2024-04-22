create or replace view aggJoin8307501734070957759 as (
with aggView8573012839846662096 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView8573012839846662096 where ml.link_type_id=aggView8573012839846662096.v13);
create or replace view aggJoin488455860166285025 as (
with aggView465147676574511396 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView465147676574511396 where mc.company_id=aggView465147676574511396.v17);
create or replace view aggJoin2931077599296017527 as (
with aggView2150520561952205427 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView2150520561952205427 where mk.keyword_id=aggView2150520561952205427.v27);
create or replace view aggJoin8490743640743491223 as (
with aggView3936101174257603144 as (select v29, MIN(v45) as v45 from aggJoin8307501734070957759 group by v29,v45)
select id as v29, title as v33, production_year as v36, v45 from title as t, aggView3936101174257603144 where t.id=aggView3936101174257603144.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin8320785061312480497 as (
with aggView2803441756074188928 as (select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin8490743640743491223 group by v29,v45)
select movie_id as v29, info as v23, v45, v46 from movie_info as mi, aggView2803441756074188928 where mi.movie_id=aggView2803441756074188928.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin7112003283906179294 as (
with aggView1308571006362709634 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin8320785061312480497 group by v29,v46,v45)
select v29, v45, v46 from aggJoin2931077599296017527 join aggView1308571006362709634 using(v29));
create or replace view aggJoin6877747208136084906 as (
with aggView3645051173525664233 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin488455860166285025 join aggView3645051173525664233 using(v18));
create or replace view aggJoin2559307694468416380 as (
with aggView1365840386209586239 as (select v29, MIN(v44) as v44 from aggJoin6877747208136084906 group by v29,v44)
select v45 as v45, v46 as v46, v44 from aggJoin7112003283906179294 join aggView1365840386209586239 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin2559307694468416380;
