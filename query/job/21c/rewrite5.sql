create or replace view aggView3626426368820155235 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2299824688497844450 as (
with aggView7124575895607059173 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView7124575895607059173 where mk.keyword_id=aggView7124575895607059173.v27);
create or replace view aggJoin5671548432569683955 as (
with aggView4210968096805300189 as (select v29 from aggJoin2299824688497844450 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView4210968096805300189 where t.id=aggView4210968096805300189.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView4647574666424111785 as select v33, v29 from aggJoin5671548432569683955 group by v33,v29;
create or replace view aggJoin7647231942816080560 as (
with aggView1138925527546589946 as (select v29, MIN(v33) as v46 from aggView4647574666424111785 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView1138925527546589946 where ml.movie_id=aggView1138925527546589946.v29);
create or replace view aggJoin2621105266484726016 as (
with aggView6851157150250840403 as (select v17, MIN(v2) as v44 from aggView3626426368820155235 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView6851157150250840403 where mc.company_id=aggView6851157150250840403.v17);
create or replace view aggJoin4343096175318298150 as (
with aggView3483637177101409575 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v29, v18, v44 as v44 from aggJoin2621105266484726016 join aggView3483637177101409575 using(v29));
create or replace view aggJoin8005532817911320971 as (
with aggView2990046205388480664 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin4343096175318298150 join aggView2990046205388480664 using(v18));
create or replace view aggJoin2173331926456665713 as (
with aggView7792939416151577375 as (select v29, MIN(v44) as v44 from aggJoin8005532817911320971 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin7647231942816080560 join aggView7792939416151577375 using(v29));
create or replace view aggJoin145746829708955508 as (
with aggView6488929693470808032 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin2173331926456665713 group by v13,v44,v46)
select link as v14, v46, v44 from link_type as lt, aggView6488929693470808032 where lt.id=aggView6488929693470808032.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin145746829708955508;
