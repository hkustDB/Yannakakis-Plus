create or replace view aggView1522486871623342637 as select movie_id as v40, title as v3 from aka_title as aka_t group by movie_id,title;
create or replace view aggJoin8310032741617422884 as (
with aggView7210900758010356048 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7210900758010356048 where mc.company_id=aggView7210900758010356048.v13);
create or replace view aggJoin3891733910954842853 as (
with aggView3558398607373053176 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView3558398607373053176 where mi.info_type_id=aggView3558398607373053176.v22 and note LIKE '%internet%');
create or replace view aggJoin8917645574386223172 as (
with aggView5823542724058931175 as (select v40 from aggJoin3891733910954842853 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView5823542724058931175 where mk.movie_id=aggView5823542724058931175.v40);
create or replace view aggJoin7606002830580152800 as (
with aggView2137401520352385943 as (select id as v20 from company_type as ct)
select v40 from aggJoin8310032741617422884 join aggView2137401520352385943 using(v20));
create or replace view aggJoin1116274209544923498 as (
with aggView842461113050767132 as (select id as v24 from keyword as k)
select v40 from aggJoin8917645574386223172 join aggView842461113050767132 using(v24));
create or replace view aggJoin1082265939093438558 as (
with aggView3168708887010534975 as (select v40 from aggJoin1116274209544923498 group by v40)
select v40 from aggJoin7606002830580152800 join aggView3168708887010534975 using(v40));
create or replace view aggJoin6525244267845057295 as (
with aggView4153960992882684170 as (select v40 from aggJoin1082265939093438558 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView4153960992882684170 where t.id=aggView4153960992882684170.v40 and production_year>1990);
create or replace view aggView208356470997253182 as select v40, v41 from aggJoin6525244267845057295 group by v40,v41;
create or replace view aggJoin4654514561849875714 as (
with aggView4580638443475647892 as (select v40, MIN(v41) as v53 from aggView208356470997253182 group by v40)
select v3, v53 from aggView1522486871623342637 join aggView4580638443475647892 using(v40));
select MIN(v3) as v52,MIN(v53) as v53 from aggJoin4654514561849875714;
