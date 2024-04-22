create or replace view aggJoin6676398282924301762 as (
with aggView430013518199149048 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView430013518199149048 where ci.person_id=aggView430013518199149048.v26);
create or replace view aggJoin5069574037289649065 as (
with aggView3824080717313996591 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView3824080717313996591 where mk.movie_id=aggView3824080717313996591.v3);
create or replace view aggJoin3381431519619865320 as (
with aggView7990436483193668894 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7990436483193668894 where mc.company_id=aggView7990436483193668894.v20);
create or replace view aggJoin3020041047405180217 as (
with aggView693401937003384315 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin5069574037289649065 join aggView693401937003384315 using(v25));
create or replace view aggJoin619133009544417592 as (
with aggView1539757986952776723 as (select v3 from aggJoin3020041047405180217 group by v3)
select v3, v47 as v47 from aggJoin6676398282924301762 join aggView1539757986952776723 using(v3));
create or replace view aggJoin2567884382665739915 as (
with aggView7443539949236439363 as (select v3 from aggJoin3381431519619865320 group by v3)
select v47 as v47 from aggJoin619133009544417592 join aggView7443539949236439363 using(v3));
select MIN(v47) as v47 from aggJoin2567884382665739915;
