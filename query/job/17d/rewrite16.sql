create or replace view aggJoin2620433330233882421 as (
with aggView6168397104599580156 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView6168397104599580156 where ci.person_id=aggView6168397104599580156.v26);
create or replace view aggJoin9079924109439082819 as (
with aggView1261828040286806600 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1261828040286806600 where mc.company_id=aggView1261828040286806600.v20);
create or replace view aggJoin4772329996564771956 as (
with aggView5643844970851194566 as (select v3 from aggJoin9079924109439082819 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView5643844970851194566 where mk.movie_id=aggView5643844970851194566.v3);
create or replace view aggJoin3363668361255004298 as (
with aggView8666341520958204306 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin4772329996564771956 join aggView8666341520958204306 using(v25));
create or replace view aggJoin4989112211151757871 as (
with aggView7923445708770816605 as (select v3 from aggJoin3363668361255004298 group by v3)
select id as v3 from title as t, aggView7923445708770816605 where t.id=aggView7923445708770816605.v3);
create or replace view aggJoin965201068857485401 as (
with aggView5327636843114500550 as (select v3 from aggJoin4989112211151757871 group by v3)
select v47 as v47 from aggJoin2620433330233882421 join aggView5327636843114500550 using(v3));
select MIN(v47) as v47 from aggJoin965201068857485401;
