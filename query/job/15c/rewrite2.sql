create or replace view aggJoin234212075668269052 as (
with aggView2553945623733587838 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView2553945623733587838 where mc.company_id=aggView2553945623733587838.v13);
create or replace view aggJoin6353153190829113477 as (
with aggView7232102104620852134 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7232102104620852134 where mk.keyword_id=aggView7232102104620852134.v24);
create or replace view aggJoin9129391369281512263 as (
with aggView1691784408326675397 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin6353153190829113477 join aggView1691784408326675397 using(v40));
create or replace view aggJoin109805885406528570 as (
with aggView2989322484875229730 as (select id as v20 from company_type as ct)
select v40 from aggJoin234212075668269052 join aggView2989322484875229730 using(v20));
create or replace view aggJoin4650717405770098838 as (
with aggView1901927252282846843 as (select v40 from aggJoin109805885406528570 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView1901927252282846843 where t.id=aggView1901927252282846843.v40 and production_year>1990);
create or replace view aggView2106994950794360003 as select v41, v40 from aggJoin4650717405770098838 group by v41,v40;
create or replace view aggJoin785094501046135428 as (
with aggView7543761303228343208 as (select v40 from aggJoin9129391369281512263 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView7543761303228343208 where mi.movie_id=aggView7543761303228343208.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin7438430756112486648 as (
with aggView2545530693212356793 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin785094501046135428 join aggView2545530693212356793 using(v22));
create or replace view aggView4589860349475581219 as select v40, v35 from aggJoin7438430756112486648 group by v40,v35;
create or replace view aggJoin5508693927464162716 as (
with aggView6996870229447743683 as (select v40, MIN(v35) as v52 from aggView4589860349475581219 group by v40)
select v41, v52 from aggView2106994950794360003 join aggView6996870229447743683 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin5508693927464162716;
