create or replace view aggView5146217784605531918 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin4735014762866308713 as (
with aggView807948205160877221 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView807948205160877221 where mk.keyword_id=aggView807948205160877221.v27);
create or replace view aggJoin8471291254137967139 as (
with aggView946192336611585826 as (select v29 from aggJoin4735014762866308713 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView946192336611585826 where t.id=aggView946192336611585826.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggView3763877549688001104 as select v33, v29 from aggJoin8471291254137967139 group by v33,v29;
create or replace view aggJoin2406909768100050153 as (
with aggView7651217890461535422 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7651217890461535422 where ml.link_type_id=aggView7651217890461535422.v13);
create or replace view aggJoin456107699064992322 as (
with aggView7463853505441361679 as (select v29, MIN(v33) as v46 from aggView3763877549688001104 group by v29)
select v29, v45 as v45, v46 from aggJoin2406909768100050153 join aggView7463853505441361679 using(v29));
create or replace view aggJoin9023318975641928754 as (
with aggView6530495926753225435 as (select id as v18 from company_type as ct where kind= 'production companies')
select movie_id as v29, company_id as v17 from movie_companies as mc, aggView6530495926753225435 where mc.company_type_id=aggView6530495926753225435.v18);
create or replace view aggJoin107519369504853621 as (
with aggView1325202877461142766 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v29, v17 from aggJoin9023318975641928754 join aggView1325202877461142766 using(v29));
create or replace view aggJoin7783167334856999139 as (
with aggView1576483858285617192 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin456107699064992322 group by v29,v46,v45)
select v17, v45, v46 from aggJoin107519369504853621 join aggView1576483858285617192 using(v29));
create or replace view aggJoin265861018494040815 as (
with aggView4134480583797534733 as (select v17, MIN(v45) as v45, MIN(v46) as v46 from aggJoin7783167334856999139 group by v17,v46,v45)
select v2, v45, v46 from aggView5146217784605531918 join aggView4134480583797534733 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin265861018494040815;
