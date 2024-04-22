create or replace view aggJoin8004027586146794572 as (
with aggView2899218534069836515 as (select id as v40, title as v53 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v40, info_type_id as v22, info as v35, note as v36, v53 from movie_info as mi, aggView2899218534069836515 where mi.movie_id=aggView2899218534069836515.v40 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin2794727360132046519 as (
with aggView7353304265508895964 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36, v53 from aggJoin8004027586146794572 join aggView7353304265508895964 using(v22));
create or replace view aggJoin5022144896592866762 as (
with aggView3742747461103611114 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin2794727360132046519 group by v40,v53)
select movie_id as v40, keyword_id as v24, v53, v52 from movie_keyword as mk, aggView3742747461103611114 where mk.movie_id=aggView3742747461103611114.v40);
create or replace view aggJoin2666860542927643705 as (
with aggView4937058911053333287 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView4937058911053333287 where mc.company_id=aggView4937058911053333287.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4602459649461030970 as (
with aggView8114131028718573691 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin2666860542927643705 join aggView8114131028718573691 using(v20));
create or replace view aggJoin8748517989542304301 as (
with aggView3392815881341367161 as (select v40 from aggJoin4602459649461030970 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView3392815881341367161 where aka_t.movie_id=aggView3392815881341367161.v40);
create or replace view aggJoin8241513553522602820 as (
with aggView1342167010627632691 as (select v40 from aggJoin8748517989542304301 group by v40)
select v24, v53 as v53, v52 as v52 from aggJoin5022144896592866762 join aggView1342167010627632691 using(v40));
create or replace view aggJoin7888653016818901160 as (
with aggView4739332154282551008 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin8241513553522602820 join aggView4739332154282551008 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin7888653016818901160;
