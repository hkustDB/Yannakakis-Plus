create or replace view aggView6152630626497667670 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin1388176871451636578 as (
with aggView3029203663298518531 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3029203663298518531 where mk.keyword_id=aggView3029203663298518531.v27);
create or replace view aggJoin6310075135562640777 as (
with aggView8834351899372426457 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29 from aggJoin1388176871451636578 join aggView8834351899372426457 using(v29));
create or replace view aggJoin1434910150360864929 as (
with aggView1593772429013820143 as (select v29 from aggJoin6310075135562640777 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView1593772429013820143 where t.id=aggView1593772429013820143.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggView7897608117699450800 as select v29, v33 from aggJoin1434910150360864929 group by v29,v33;
create or replace view aggJoin7199032552089163741 as (
with aggView5910628062313199513 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView5910628062313199513 where ml.link_type_id=aggView5910628062313199513.v13);
create or replace view aggJoin6430946212496655843 as (
with aggView4225663941641452350 as (select v17, MIN(v2) as v44 from aggView6152630626497667670 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4225663941641452350 where mc.company_id=aggView4225663941641452350.v17);
create or replace view aggJoin6601243749283649072 as (
with aggView7578763283045618150 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin6430946212496655843 join aggView7578763283045618150 using(v18));
create or replace view aggJoin5877909447762813501 as (
with aggView4169566727922621059 as (select v29, MIN(v44) as v44 from aggJoin6601243749283649072 group by v29,v44)
select v29, v33, v44 from aggView7897608117699450800 join aggView4169566727922621059 using(v29));
create or replace view aggJoin8411675791426918384 as (
with aggView1131698707669438873 as (select v29, MIN(v45) as v45 from aggJoin7199032552089163741 group by v29,v45)
select v33, v44 as v44, v45 from aggJoin5877909447762813501 join aggView1131698707669438873 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin8411675791426918384;
