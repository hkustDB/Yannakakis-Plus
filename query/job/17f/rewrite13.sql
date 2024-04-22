create or replace view aggJoin2795073874425708195 as (
with aggView8360394941925667454 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView8360394941925667454 where ci.person_id=aggView8360394941925667454.v26);
create or replace view aggJoin301623562369832995 as (
with aggView7520252113788096934 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView7520252113788096934 where mk.movie_id=aggView7520252113788096934.v3);
create or replace view aggJoin4609972280910617878 as (
with aggView4396177670659459654 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin301623562369832995 join aggView4396177670659459654 using(v25));
create or replace view aggJoin3261607438177441027 as (
with aggView5013166706554679 as (select v3 from aggJoin4609972280910617878 group by v3)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView5013166706554679 where mc.movie_id=aggView5013166706554679.v3);
create or replace view aggJoin1825772912567848360 as (
with aggView976757754717063851 as (select id as v20 from company_name as cn)
select v3 from aggJoin3261607438177441027 join aggView976757754717063851 using(v20));
create or replace view aggJoin9089757100829549837 as (
with aggView1404517737019237107 as (select v3 from aggJoin1825772912567848360 group by v3)
select v47 as v47 from aggJoin2795073874425708195 join aggView1404517737019237107 using(v3));
select MIN(v47) as v47 from aggJoin9089757100829549837;
