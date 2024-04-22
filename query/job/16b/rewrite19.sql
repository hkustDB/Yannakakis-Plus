create or replace view aggJoin6079026009083656805 as (
with aggView7919047623234888681 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView7919047623234888681 where ci.person_id=aggView7919047623234888681.v2);
create or replace view aggJoin6070081291946726873 as (
with aggView9121120829456605756 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView9121120829456605756 where mc.company_id=aggView9121120829456605756.v28);
create or replace view aggJoin7217827171697398379 as (
with aggView5350632627134266601 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5350632627134266601 where mk.keyword_id=aggView5350632627134266601.v33);
create or replace view aggJoin3952770462894919348 as (
with aggView5017913724263776449 as (select id as v2 from name as n)
select v11, v55 from aggJoin6079026009083656805 join aggView5017913724263776449 using(v2));
create or replace view aggJoin3265224638039720322 as (
with aggView5422848022045357078 as (select v11 from aggJoin7217827171697398379 group by v11)
select id as v11, title as v44 from title as t, aggView5422848022045357078 where t.id=aggView5422848022045357078.v11);
create or replace view aggJoin8993290279835293662 as (
with aggView3765758773481375295 as (select v11, MIN(v44) as v56 from aggJoin3265224638039720322 group by v11)
select v11, v55 as v55, v56 from aggJoin3952770462894919348 join aggView3765758773481375295 using(v11));
create or replace view aggJoin8036991317918495549 as (
with aggView3792285964452839033 as (select v11 from aggJoin6070081291946726873 group by v11)
select v55 as v55, v56 as v56 from aggJoin8993290279835293662 join aggView3792285964452839033 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin8036991317918495549;
