create or replace view aggView7267184255686481553 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2331381538850618996 as (
with aggView6365700654840722381 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView6365700654840722381 where mk.keyword_id=aggView6365700654840722381.v27);
create or replace view aggJoin3454853412151793583 as (
with aggView1948559182481173063 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView1948559182481173063 where t.id=aggView1948559182481173063.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggJoin6899129088206382576 as (
with aggView7790764097177896617 as (select v29 from aggJoin2331381538850618996 group by v29)
select v29, v33, v36 from aggJoin3454853412151793583 join aggView7790764097177896617 using(v29));
create or replace view aggView3446138231433357193 as select v33, v29 from aggJoin6899129088206382576 group by v33,v29;
create or replace view aggJoin7372737861496026524 as (
with aggView2132183951565561499 as (select v17, MIN(v2) as v44 from aggView7267184255686481553 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView2132183951565561499 where mc.company_id=aggView2132183951565561499.v17);
create or replace view aggJoin3457937541961619434 as (
with aggView601752743514742946 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin7372737861496026524 join aggView601752743514742946 using(v18));
create or replace view aggJoin2796242841142360442 as (
with aggView9164240280733051349 as (select v29, MIN(v44) as v44 from aggJoin3457937541961619434 group by v29,v44)
select v33, v29, v44 from aggView3446138231433357193 join aggView9164240280733051349 using(v29));
create or replace view aggJoin179884318019333597 as (
with aggView2679636723488626653 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin2796242841142360442 group by v29,v44)
select link_type_id as v13, v44, v46 from movie_link as ml, aggView2679636723488626653 where ml.movie_id=aggView2679636723488626653.v29);
create or replace view aggJoin4813545057133539848 as (
with aggView2020084905924187738 as (select v13, MIN(v44) as v44, MIN(v46) as v46 from aggJoin179884318019333597 group by v13,v46,v44)
select link as v14, v44, v46 from link_type as lt, aggView2020084905924187738 where lt.id=aggView2020084905924187738.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin4813545057133539848;
