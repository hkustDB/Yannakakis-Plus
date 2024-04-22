create or replace view aggJoin691695435930042809 as (
with aggView8633965090225718686 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView8633965090225718686 where an.person_id=aggView8633965090225718686.v2);
create or replace view aggView7574255711304874980 as select v2, v3 from aggJoin691695435930042809 group by v2,v3;
create or replace view aggJoin2233040520187963184 as (
with aggView1992337004736544539 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1992337004736544539 where mc.company_id=aggView1992337004736544539.v28);
create or replace view aggJoin1547893730813602105 as (
with aggView8310560713688238590 as (select v11 from aggJoin2233040520187963184 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView8310560713688238590 where t.id=aggView8310560713688238590.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggView6997723485827065573 as select v44, v11 from aggJoin1547893730813602105 group by v44,v11;
create or replace view aggJoin5294409060798378498 as (
with aggView6984601618961660908 as (select v2, MIN(v3) as v55 from aggView7574255711304874980 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView6984601618961660908 where ci.person_id=aggView6984601618961660908.v2);
create or replace view aggJoin3101823822861841369 as (
with aggView180661810495759987 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView180661810495759987 where mk.keyword_id=aggView180661810495759987.v33);
create or replace view aggJoin4375463822945758189 as (
with aggView2933709785025614118 as (select v11 from aggJoin3101823822861841369 group by v11)
select v11, v55 as v55 from aggJoin5294409060798378498 join aggView2933709785025614118 using(v11));
create or replace view aggJoin1309002853408714294 as (
with aggView917853804369640535 as (select v11, MIN(v55) as v55 from aggJoin4375463822945758189 group by v11,v55)
select v44, v55 from aggView6997723485827065573 join aggView917853804369640535 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin1309002853408714294;
