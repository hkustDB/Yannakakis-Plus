create or replace view aggJoin4955088353126116313 as (
with aggView422110945617964127 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView422110945617964127 where ci.person_id=aggView422110945617964127.v26);
create or replace view aggJoin3966033757532026284 as (
with aggView691044722257855145 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView691044722257855145 where mc.company_id=aggView691044722257855145.v20);
create or replace view aggJoin6289898438122041145 as (
with aggView3968575496209079147 as (select v3 from aggJoin3966033757532026284 group by v3)
select id as v3 from title as t, aggView3968575496209079147 where t.id=aggView3968575496209079147.v3);
create or replace view aggJoin2570777329260911351 as (
with aggView8562548686600985524 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8562548686600985524 where mk.keyword_id=aggView8562548686600985524.v25);
create or replace view aggJoin5963216992219128397 as (
with aggView4389955715131896627 as (select v3 from aggJoin2570777329260911351 group by v3)
select v3 from aggJoin6289898438122041145 join aggView4389955715131896627 using(v3));
create or replace view aggJoin838182030296636496 as (
with aggView5033770417218039145 as (select v3 from aggJoin5963216992219128397 group by v3)
select v47 as v47 from aggJoin4955088353126116313 join aggView5033770417218039145 using(v3));
select MIN(v47) as v47 from aggJoin838182030296636496;
