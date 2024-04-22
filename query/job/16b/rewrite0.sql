create or replace view aggView4018651187320752179 as select name as v3, person_id as v2 from aka_name as an group by name,person_id;
create or replace view aggJoin7252690507332903756 as (
with aggView8654607201989230235 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8654607201989230235 where mc.company_id=aggView8654607201989230235.v28);
create or replace view aggJoin5790037759617523149 as (
with aggView8234487113076131824 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8234487113076131824 where mk.keyword_id=aggView8234487113076131824.v33);
create or replace view aggJoin5922730372452346678 as (
with aggView8377906127074945293 as (select v11 from aggJoin7252690507332903756 group by v11)
select v11 from aggJoin5790037759617523149 join aggView8377906127074945293 using(v11));
create or replace view aggJoin8695712765506487973 as (
with aggView8710365567649881117 as (select v11 from aggJoin5922730372452346678 group by v11)
select id as v11, title as v44 from title as t, aggView8710365567649881117 where t.id=aggView8710365567649881117.v11);
create or replace view aggView7407635982183452294 as select v44, v11 from aggJoin8695712765506487973 group by v44,v11;
create or replace view aggJoin1337666684690592646 as (
with aggView5649783913119165115 as (select v2, MIN(v3) as v55 from aggView4018651187320752179 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView5649783913119165115 where ci.person_id=aggView5649783913119165115.v2);
create or replace view aggJoin974045069751742032 as (
with aggView8552381888278430202 as (select id as v2 from name as n)
select v11, v55 from aggJoin1337666684690592646 join aggView8552381888278430202 using(v2));
create or replace view aggJoin4620623434057009899 as (
with aggView9060070864804649385 as (select v11, MIN(v55) as v55 from aggJoin974045069751742032 group by v11,v55)
select v44, v55 from aggView7407635982183452294 join aggView9060070864804649385 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin4620623434057009899;
