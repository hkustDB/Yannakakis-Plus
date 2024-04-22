create or replace view aggJoin5343478527503634912 as (
with aggView159348259146768884 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView159348259146768884 where ci.person_id=aggView159348259146768884.v26);
create or replace view aggJoin8426919176151197692 as (
with aggView8804609631755580040 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8804609631755580040 where mk.keyword_id=aggView8804609631755580040.v25);
create or replace view aggJoin8723489456774780229 as (
with aggView7719426625508944435 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7719426625508944435 where mc.company_id=aggView7719426625508944435.v20);
create or replace view aggJoin6121944441817458058 as (
with aggView4940641188453609143 as (select v3 from aggJoin8723489456774780229 group by v3)
select v3 from aggJoin8426919176151197692 join aggView4940641188453609143 using(v3));
create or replace view aggJoin9030129671602435995 as (
with aggView9066677396749677786 as (select v3 from aggJoin6121944441817458058 group by v3)
select id as v3 from title as t, aggView9066677396749677786 where t.id=aggView9066677396749677786.v3);
create or replace view aggJoin4722899965903462569 as (
with aggView7529402815162619704 as (select v3 from aggJoin9030129671602435995 group by v3)
select v47 as v47 from aggJoin5343478527503634912 join aggView7529402815162619704 using(v3));
select MIN(v47) as v47 from aggJoin4722899965903462569;
