create or replace view aggJoin8841931676833141148 as (
with aggView4974578721539165667 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView4974578721539165667 where ci.person_id=aggView4974578721539165667.v26);
create or replace view aggJoin3290908448401162602 as (
with aggView3047088328368769995 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView3047088328368769995 where mk.keyword_id=aggView3047088328368769995.v25);
create or replace view aggJoin2014263739066171448 as (
with aggView1631478178931690655 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1631478178931690655 where mc.company_id=aggView1631478178931690655.v20);
create or replace view aggJoin2214935616358626015 as (
with aggView314969481055627222 as (select v3 from aggJoin2014263739066171448 group by v3)
select id as v3 from title as t, aggView314969481055627222 where t.id=aggView314969481055627222.v3);
create or replace view aggJoin8897215049891576327 as (
with aggView6839996782696560725 as (select v3 from aggJoin2214935616358626015 group by v3)
select v3 from aggJoin3290908448401162602 join aggView6839996782696560725 using(v3));
create or replace view aggJoin626518513281350622 as (
with aggView6186635261232877705 as (select v3 from aggJoin8897215049891576327 group by v3)
select v47 as v47 from aggJoin8841931676833141148 join aggView6186635261232877705 using(v3));
select MIN(v47) as v47 from aggJoin626518513281350622;
