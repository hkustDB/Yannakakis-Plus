create or replace view aggJoin8219290467117070900 as (
with aggView8629369703407982052 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView8629369703407982052 where ci.person_id=aggView8629369703407982052.v26);
create or replace view aggJoin3766194882573664414 as (
with aggView4877469522193528559 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView4877469522193528559 where mc.movie_id=aggView4877469522193528559.v3);
create or replace view aggJoin7075368901666124389 as (
with aggView8327780561137692258 as (select id as v20 from company_name as cn where country_code= '[us]')
select v3 from aggJoin3766194882573664414 join aggView8327780561137692258 using(v20));
create or replace view aggJoin4658124931680437173 as (
with aggView1256469520586024817 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1256469520586024817 where mk.keyword_id=aggView1256469520586024817.v25);
create or replace view aggJoin8295267205911581553 as (
with aggView7507139088743429300 as (select v3 from aggJoin4658124931680437173 group by v3)
select v3 from aggJoin7075368901666124389 join aggView7507139088743429300 using(v3));
create or replace view aggJoin23373659974839818 as (
with aggView417110631006511270 as (select v3 from aggJoin8295267205911581553 group by v3)
select v47 as v47 from aggJoin8219290467117070900 join aggView417110631006511270 using(v3));
select MIN(v47) as v47 from aggJoin23373659974839818;
