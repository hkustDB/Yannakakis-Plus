create or replace view aggJoin7389756222851280219 as (
with aggView1945917711115768608 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, info_type_id as v22, note as v36, v53 from movie_info as mi, aggView1945917711115768608 where mi.movie_id=aggView1945917711115768608.v40 and note LIKE '%internet%');
create or replace view aggJoin2094004233825003040 as (
with aggView7751587742247534691 as (select movie_id as v40, MIN(title) as v52 from aka_title as aka_t group by movie_id)
select movie_id as v40, keyword_id as v24, v52 from movie_keyword as mk, aggView7751587742247534691 where mk.movie_id=aggView7751587742247534691.v40);
create or replace view aggJoin4059474958994547999 as (
with aggView5068752808952794419 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView5068752808952794419 where mc.company_id=aggView5068752808952794419.v13);
create or replace view aggJoin3766247520099992337 as (
with aggView7770051720671845900 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v36, v53 from aggJoin7389756222851280219 join aggView7770051720671845900 using(v22));
create or replace view aggJoin2319896455453513475 as (
with aggView2092198239695429693 as (select v40, MIN(v53) as v53 from aggJoin3766247520099992337 group by v40,v53)
select v40, v24, v52 as v52, v53 from aggJoin2094004233825003040 join aggView2092198239695429693 using(v40));
create or replace view aggJoin3577848351675961570 as (
with aggView1128027364839322017 as (select id as v20 from company_type as ct)
select v40 from aggJoin4059474958994547999 join aggView1128027364839322017 using(v20));
create or replace view aggJoin6583895493478209857 as (
with aggView2162910131421695245 as (select v40 from aggJoin3577848351675961570 group by v40)
select v24, v52 as v52, v53 as v53 from aggJoin2319896455453513475 join aggView2162910131421695245 using(v40));
create or replace view aggJoin1931156033588855148 as (
with aggView4304149280959106638 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin6583895493478209857 join aggView4304149280959106638 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1931156033588855148;
