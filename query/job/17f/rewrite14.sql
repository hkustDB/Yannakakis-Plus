create or replace view aggJoin7528825009653991768 as (
with aggView8750461932768110816 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView8750461932768110816 where ci.person_id=aggView8750461932768110816.v26);
create or replace view aggJoin1234253189685680069 as (
with aggView150665406413239173 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView150665406413239173 where mk.keyword_id=aggView150665406413239173.v25);
create or replace view aggJoin4572793661344138253 as (
with aggView3379714931888109244 as (select v3 from aggJoin1234253189685680069 group by v3)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView3379714931888109244 where mc.movie_id=aggView3379714931888109244.v3);
create or replace view aggJoin6988429825745575226 as (
with aggView4863077976487080247 as (select id as v20 from company_name as cn)
select v3 from aggJoin4572793661344138253 join aggView4863077976487080247 using(v20));
create or replace view aggJoin1649292897487837387 as (
with aggView5758738151407046364 as (select v3 from aggJoin6988429825745575226 group by v3)
select id as v3 from title as t, aggView5758738151407046364 where t.id=aggView5758738151407046364.v3);
create or replace view aggJoin1068243981556695850 as (
with aggView8405338869429617199 as (select v3 from aggJoin1649292897487837387 group by v3)
select v47 as v47 from aggJoin7528825009653991768 join aggView8405338869429617199 using(v3));
select MIN(v47) as v47 from aggJoin1068243981556695850;
