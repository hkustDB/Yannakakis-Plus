create or replace view aggJoin6215366683903000598 as (
with aggView3186249430363810785 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView3186249430363810785 where mk.movie_id=aggView3186249430363810785.v40);
create or replace view aggJoin3966288494661528444 as (
with aggView5602191772357505393 as (select movie_id as v40, MIN(title) as v52 from aka_title as aka_t group by movie_id)
select v40, v24, v53 as v53, v52 from aggJoin6215366683903000598 join aggView5602191772357505393 using(v40));
create or replace view aggJoin3231388170026580552 as (
with aggView7411964288382345944 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7411964288382345944 where mc.company_id=aggView7411964288382345944.v13);
create or replace view aggJoin8488970236300763849 as (
with aggView1718037988640461578 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView1718037988640461578 where mi.info_type_id=aggView1718037988640461578.v22 and note LIKE '%internet%');
create or replace view aggJoin753508259194969206 as (
with aggView4566121016978745141 as (select v40 from aggJoin8488970236300763849 group by v40)
select v40, v20 from aggJoin3231388170026580552 join aggView4566121016978745141 using(v40));
create or replace view aggJoin3249633516961571265 as (
with aggView736790698850307783 as (select id as v20 from company_type as ct)
select v40 from aggJoin753508259194969206 join aggView736790698850307783 using(v20));
create or replace view aggJoin239632784052073617 as (
with aggView4761451144157911773 as (select v40 from aggJoin3249633516961571265 group by v40)
select v24, v53 as v53, v52 as v52 from aggJoin3966288494661528444 join aggView4761451144157911773 using(v40));
create or replace view aggJoin6626960077840976465 as (
with aggView2161710633379214492 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin239632784052073617 join aggView2161710633379214492 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin6626960077840976465;
