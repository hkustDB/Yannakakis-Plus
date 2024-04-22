create or replace view aggView8043203420386347575 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin2282444003310956742 as (
with aggView7510533309486486552 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7510533309486486552 where mk.keyword_id=aggView7510533309486486552.v22);
create or replace view aggJoin725062524524570186 as (
with aggView2379596566401767024 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView2379596566401767024 where mc.company_type_id=aggView2379596566401767024.v18);
create or replace view aggView7620747253718320267 as select v19, v24, v17 from aggJoin725062524524570186 group by v19,v24,v17;
create or replace view aggJoin8230246579936353223 as (
with aggView1968493009608832214 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView1968493009608832214 where ml.link_type_id=aggView1968493009608832214.v13);
create or replace view aggJoin284155813422689288 as (
with aggView6894621915896616917 as (select v24 from aggJoin8230246579936353223 group by v24)
select v24 from aggJoin2282444003310956742 join aggView6894621915896616917 using(v24));
create or replace view aggJoin5998061958394651474 as (
with aggView2856065893077148846 as (select v24 from aggJoin284155813422689288 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView2856065893077148846 where t.id=aggView2856065893077148846.v24 and production_year>1950);
create or replace view aggView723451581281876922 as select v24, v28 from aggJoin5998061958394651474 group by v24,v28;
create or replace view aggJoin3504986405837729058 as (
with aggView4392497188061350187 as (select v24, MIN(v28) as v41 from aggView723451581281876922 group by v24)
select v19, v17, v41 from aggView7620747253718320267 join aggView4392497188061350187 using(v24));
create or replace view aggJoin7831259801594863016 as (
with aggView340909640588984387 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin3504986405837729058 group by v17,v41)
select v2, v41, v40 from aggView8043203420386347575 join aggView340909640588984387 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7831259801594863016;
