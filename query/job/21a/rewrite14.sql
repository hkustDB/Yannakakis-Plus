create or replace view aggJoin1634585388717012338 as (
with aggView6425425980510357155 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6425425980510357155 where ml.link_type_id=aggView6425425980510357155.v13);
create or replace view aggJoin8572911444368640843 as (
with aggView2168543137539583501 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView2168543137539583501 where mc.company_id=aggView2168543137539583501.v17);
create or replace view aggJoin4962636611801455089 as (
with aggView3438375519797912286 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3438375519797912286 where mk.keyword_id=aggView3438375519797912286.v27);
create or replace view aggJoin5341069633752024424 as (
with aggView2371906585759492460 as (select v29, MIN(v45) as v45 from aggJoin1634585388717012338 group by v29,v45)
select v29, v45 from aggJoin4962636611801455089 join aggView2371906585759492460 using(v29));
create or replace view aggJoin6957506389633382659 as (
with aggView3494201338093729884 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29, v18, v44 as v44 from aggJoin8572911444368640843 join aggView3494201338093729884 using(v29));
create or replace view aggJoin4641509331685620415 as (
with aggView3918033806997102533 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin6957506389633382659 join aggView3918033806997102533 using(v18));
create or replace view aggJoin8750521983366570220 as (
with aggView699771536048614510 as (select v29, MIN(v44) as v44 from aggJoin4641509331685620415 group by v29,v44)
select id as v29, title as v33, production_year as v36, v44 from title as t, aggView699771536048614510 where t.id=aggView699771536048614510.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin2140909977796430052 as (
with aggView1153917722588474857 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin8750521983366570220 group by v29,v44)
select v45 as v45, v44, v46 from aggJoin5341069633752024424 join aggView1153917722588474857 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin2140909977796430052;
