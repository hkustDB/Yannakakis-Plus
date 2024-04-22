create or replace view aggJoin4208436494450749703 as (
with aggView4881416636567166230 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4881416636567166230 where mk.keyword_id=aggView4881416636567166230.v33);
create or replace view aggJoin2797732854507166746 as (
with aggView4637892482378859932 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4637892482378859932 where mc.company_id=aggView4637892482378859932.v28);
create or replace view aggJoin1123575332016025972 as (
with aggView966070297479149434 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView966070297479149434 where an.person_id=aggView966070297479149434.v2);
create or replace view aggJoin67970903267163341 as (
with aggView8554481284390548519 as (select v2, MIN(v3) as v55 from aggJoin1123575332016025972 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView8554481284390548519 where ci.person_id=aggView8554481284390548519.v2);
create or replace view aggJoin585327971039266530 as (
with aggView1763209861271021352 as (select v11 from aggJoin4208436494450749703 group by v11)
select id as v11, title as v44 from title as t, aggView1763209861271021352 where t.id=aggView1763209861271021352.v11);
create or replace view aggJoin4103241175218386060 as (
with aggView2334519331168950530 as (select v11, MIN(v44) as v56 from aggJoin585327971039266530 group by v11)
select v11, v56 from aggJoin2797732854507166746 join aggView2334519331168950530 using(v11));
create or replace view aggJoin1599420526533383893 as (
with aggView7725490214354105740 as (select v11, MIN(v56) as v56 from aggJoin4103241175218386060 group by v11,v56)
select v55 as v55, v56 from aggJoin67970903267163341 join aggView7725490214354105740 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1599420526533383893;
