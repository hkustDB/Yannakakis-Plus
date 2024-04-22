create or replace view aggJoin7440576654108809671 as (
with aggView3168982157472315034 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView3168982157472315034 where ci.person_id=aggView3168982157472315034.v26);
create or replace view aggJoin3130926545201308523 as (
with aggView4440567225654060455 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView4440567225654060455 where mc.company_id=aggView4440567225654060455.v20);
create or replace view aggJoin4075472309465283333 as (
with aggView2395345282937085579 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2395345282937085579 where mk.keyword_id=aggView2395345282937085579.v25);
create or replace view aggJoin4004987144277005840 as (
with aggView2951344281864046797 as (select v3 from aggJoin4075472309465283333 group by v3)
select id as v3 from title as t, aggView2951344281864046797 where t.id=aggView2951344281864046797.v3);
create or replace view aggJoin8448419408569541901 as (
with aggView7813300976510557892 as (select v3 from aggJoin4004987144277005840 group by v3)
select v3 from aggJoin3130926545201308523 join aggView7813300976510557892 using(v3));
create or replace view aggJoin1895270310976319277 as (
with aggView8890827903459464481 as (select v3 from aggJoin8448419408569541901 group by v3)
select v47 as v47 from aggJoin7440576654108809671 join aggView8890827903459464481 using(v3));
select MIN(v47) as v47 from aggJoin1895270310976319277;
