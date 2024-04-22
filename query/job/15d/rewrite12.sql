create or replace view aggJoin2133938817288581051 as (
with aggView6560498829048634416 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, title as v3, v53 from aka_title as aka_t, aggView6560498829048634416 where aka_t.movie_id=aggView6560498829048634416.v40);
create or replace view aggJoin4308063037138960145 as (
with aggView7243558819186270887 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7243558819186270887 where mc.company_id=aggView7243558819186270887.v13);
create or replace view aggJoin6587419567372965226 as (
with aggView7395475910438725890 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView7395475910438725890 where mi.info_type_id=aggView7395475910438725890.v22 and note LIKE '%internet%');
create or replace view aggJoin4245468602867828985 as (
with aggView7551010391724604375 as (select v40 from aggJoin6587419567372965226 group by v40)
select v40, v3, v53 as v53 from aggJoin2133938817288581051 join aggView7551010391724604375 using(v40));
create or replace view aggJoin8990668394944240950 as (
with aggView367710089731181141 as (select v40, MIN(v53) as v53, MIN(v3) as v52 from aggJoin4245468602867828985 group by v40,v53)
select movie_id as v40, keyword_id as v24, v53, v52 from movie_keyword as mk, aggView367710089731181141 where mk.movie_id=aggView367710089731181141.v40);
create or replace view aggJoin549591317797442944 as (
with aggView5020133626372572284 as (select id as v20 from company_type as ct)
select v40 from aggJoin4308063037138960145 join aggView5020133626372572284 using(v20));
create or replace view aggJoin7123140519019890807 as (
with aggView8573861446695054147 as (select v40 from aggJoin549591317797442944 group by v40)
select v24, v53 as v53, v52 as v52 from aggJoin8990668394944240950 join aggView8573861446695054147 using(v40));
create or replace view aggJoin5764087593498967007 as (
with aggView5293115029956818956 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin7123140519019890807 join aggView5293115029956818956 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin5764087593498967007;
