create or replace view aggJoin2256610598735333501 as (
with aggView5287019489389428283 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5287019489389428283 where ci.movie_id=aggView5287019489389428283.v3);
create or replace view aggJoin7840733854101949233 as (
with aggView8923885680408335267 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView8923885680408335267 where mc.company_id=aggView8923885680408335267.v20);
create or replace view aggJoin1678033791533731615 as (
with aggView8969508778023388800 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8969508778023388800 where mk.keyword_id=aggView8969508778023388800.v25);
create or replace view aggJoin8527786132493799717 as (
with aggView195887458754226138 as (select v3 from aggJoin1678033791533731615 group by v3)
select v3 from aggJoin7840733854101949233 join aggView195887458754226138 using(v3));
create or replace view aggJoin8680781411257551841 as (
with aggView5103350440814434662 as (select v3 from aggJoin8527786132493799717 group by v3)
select v26 from aggJoin2256610598735333501 join aggView5103350440814434662 using(v3));
create or replace view aggJoin2988927454852745324 as (
with aggView1092374249774138581 as (select v26 from aggJoin8680781411257551841 group by v26)
select name as v27 from name as n, aggView1092374249774138581 where n.id=aggView1092374249774138581.v26);
create or replace view aggView386892364893618212 as select v27 from aggJoin2988927454852745324 group by v27;
select MIN(v27) as v47 from aggView386892364893618212;
