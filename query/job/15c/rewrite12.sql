create or replace view aggJoin363243457136560578 as (
with aggView160145390618956727 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, info_type_id as v22, info as v35, note as v36, v53 from movie_info as mi, aggView160145390618956727 where mi.movie_id=aggView160145390618956727.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin1535474751868799439 as (
with aggView4461037258782929057 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView4461037258782929057 where mc.company_id=aggView4461037258782929057.v13);
create or replace view aggJoin2748678561654439425 as (
with aggView3530430154640373880 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView3530430154640373880 where mk.keyword_id=aggView3530430154640373880.v24);
create or replace view aggJoin4127006384859104946 as (
with aggView7005591602854763044 as (select id as v20 from company_type as ct)
select v40 from aggJoin1535474751868799439 join aggView7005591602854763044 using(v20));
create or replace view aggJoin627286343533719775 as (
with aggView8458453538209618836 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40, v22, v35, v36, v53 as v53 from aggJoin363243457136560578 join aggView8458453538209618836 using(v40));
create or replace view aggJoin8587054076548705224 as (
with aggView7097505033010240197 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36, v53 from aggJoin627286343533719775 join aggView7097505033010240197 using(v22));
create or replace view aggJoin53877706133318361 as (
with aggView4269405729340749510 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin8587054076548705224 group by v40,v53)
select v40, v53, v52 from aggJoin4127006384859104946 join aggView4269405729340749510 using(v40));
create or replace view aggJoin6958364719393664747 as (
with aggView8426266835943163854 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin53877706133318361 group by v40,v52,v53)
select v53, v52 from aggJoin2748678561654439425 join aggView8426266835943163854 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin6958364719393664747;
