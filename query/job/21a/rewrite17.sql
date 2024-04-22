create or replace view aggView6494393513158799818 as select id as v29, title as v33 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView7553097870477648735 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2528621067761618908 as (
with aggView3579558404692860356 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3579558404692860356 where ml.link_type_id=aggView3579558404692860356.v13);
create or replace view aggJoin7075814256998499105 as (
with aggView500711118399021015 as (select v17, MIN(v2) as v44 from aggView7553097870477648735 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView500711118399021015 where mc.company_id=aggView500711118399021015.v17);
create or replace view aggJoin1054651723817698701 as (
with aggView1134777096932903752 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView1134777096932903752 where mk.keyword_id=aggView1134777096932903752.v27);
create or replace view aggJoin2154272942611150071 as (
with aggView7839515554814888384 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29, v45 as v45 from aggJoin2528621067761618908 join aggView7839515554814888384 using(v29));
create or replace view aggJoin6649868625908043830 as (
with aggView6076956578086450512 as (select v29 from aggJoin1054651723817698701 group by v29)
select v29, v45 as v45 from aggJoin2154272942611150071 join aggView6076956578086450512 using(v29));
create or replace view aggJoin8489639969579930585 as (
with aggView8552640876806860340 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin7075814256998499105 join aggView8552640876806860340 using(v18));
create or replace view aggJoin648853332681498891 as (
with aggView6335593040226068430 as (select v29, MIN(v44) as v44 from aggJoin8489639969579930585 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin6649868625908043830 join aggView6335593040226068430 using(v29));
create or replace view aggJoin838094228937258583 as (
with aggView529677641516105451 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin648853332681498891 group by v29,v44,v45)
select v33, v45, v44 from aggView6494393513158799818 join aggView529677641516105451 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin838094228937258583;
