create or replace view aggJoin8108624286313366083 as (
with aggView7680425188937583789 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView7680425188937583789 where ci.person_id=aggView7680425188937583789.v26);
create or replace view aggJoin4038054612592419103 as (
with aggView1401927859744003607 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1401927859744003607 where mc.company_id=aggView1401927859744003607.v20);
create or replace view aggJoin6709090132764642627 as (
with aggView2779337854281463719 as (select v3 from aggJoin4038054612592419103 group by v3)
select v3, v47 as v47 from aggJoin8108624286313366083 join aggView2779337854281463719 using(v3));
create or replace view aggJoin1824105462396573789 as (
with aggView4165279067739840105 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4165279067739840105 where mk.keyword_id=aggView4165279067739840105.v25);
create or replace view aggJoin129966804535453939 as (
with aggView7874739469741893110 as (select id as v3 from title as t)
select v3 from aggJoin1824105462396573789 join aggView7874739469741893110 using(v3));
create or replace view aggJoin5857519502181316777 as (
with aggView4858053683249152500 as (select v3 from aggJoin129966804535453939 group by v3)
select v47 as v47 from aggJoin6709090132764642627 join aggView4858053683249152500 using(v3));
select MIN(v47) as v47 from aggJoin5857519502181316777;
