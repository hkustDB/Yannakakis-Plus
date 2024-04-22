create or replace view aggJoin272233270997130485 as (
with aggView8121906528840582764 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView8121906528840582764 where ci.person_id=aggView8121906528840582764.v26);
create or replace view aggJoin5529160493234776382 as (
with aggView4921434340716074206 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4921434340716074206 where mc.company_id=aggView4921434340716074206.v20);
create or replace view aggJoin4976924703894294210 as (
with aggView7263427686472452307 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7263427686472452307 where mk.keyword_id=aggView7263427686472452307.v25);
create or replace view aggJoin2221567495625256159 as (
with aggView5097535818353169035 as (select id as v3 from title as t)
select v3 from aggJoin5529160493234776382 join aggView5097535818353169035 using(v3));
create or replace view aggJoin1197379117894425632 as (
with aggView2812818253474889435 as (select v3 from aggJoin2221567495625256159 group by v3)
select v3 from aggJoin4976924703894294210 join aggView2812818253474889435 using(v3));
create or replace view aggJoin3046216070107891410 as (
with aggView3071485229663557852 as (select v3 from aggJoin1197379117894425632 group by v3)
select v47 as v47 from aggJoin272233270997130485 join aggView3071485229663557852 using(v3));
select MIN(v47) as v47 from aggJoin3046216070107891410;
