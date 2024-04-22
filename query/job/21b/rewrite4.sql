create or replace view aggView405639825923559459 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8729988959390815963 as (
with aggView7919961075163436724 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView7919961075163436724 where mk.keyword_id=aggView7919961075163436724.v27);
create or replace view aggJoin3142153022420744151 as (
with aggView3419624186333524280 as (select v29 from aggJoin8729988959390815963 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView3419624186333524280 where t.id=aggView3419624186333524280.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggView6509420925445889886 as select v33, v29 from aggJoin3142153022420744151 group by v33,v29;
create or replace view aggJoin6335182014974055116 as (
with aggView1415821008720537655 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView1415821008720537655 where ml.link_type_id=aggView1415821008720537655.v13);
create or replace view aggJoin4657275070567821652 as (
with aggView7872271832110489057 as (select v29, MIN(v33) as v46 from aggView6509420925445889886 group by v29)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView7872271832110489057 where mc.movie_id=aggView7872271832110489057.v29);
create or replace view aggJoin8186966009614735923 as (
with aggView207450134483482901 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v17, v46 from aggJoin4657275070567821652 join aggView207450134483482901 using(v18));
create or replace view aggJoin4497873203100320667 as (
with aggView2038756256585117174 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v29, v45 as v45 from aggJoin6335182014974055116 join aggView2038756256585117174 using(v29));
create or replace view aggJoin7615596905164159693 as (
with aggView2416610618678266934 as (select v29, MIN(v45) as v45 from aggJoin4497873203100320667 group by v29,v45)
select v17, v46 as v46, v45 from aggJoin8186966009614735923 join aggView2416610618678266934 using(v29));
create or replace view aggJoin4474981125870574840 as (
with aggView4882280632007126862 as (select v17, MIN(v46) as v46, MIN(v45) as v45 from aggJoin7615596905164159693 group by v17,v46,v45)
select v2, v46, v45 from aggView405639825923559459 join aggView4882280632007126862 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin4474981125870574840;
