create or replace view aggJoin1299127274360108578 as (
with aggView5636650768852562231 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5636650768852562231 where mk.keyword_id=aggView5636650768852562231.v25);
create or replace view aggJoin228989741838299934 as (
with aggView7266147617377229809 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7266147617377229809 where mc.company_id=aggView7266147617377229809.v20);
create or replace view aggJoin7064359397286674906 as (
with aggView4714445160253765825 as (select id as v3 from title as t)
select v3 from aggJoin228989741838299934 join aggView4714445160253765825 using(v3));
create or replace view aggJoin5153617078592300806 as (
with aggView6534309179033482750 as (select v3 from aggJoin7064359397286674906 group by v3)
select v3 from aggJoin1299127274360108578 join aggView6534309179033482750 using(v3));
create or replace view aggJoin2891678308071830528 as (
with aggView6222477574181533352 as (select v3 from aggJoin5153617078592300806 group by v3)
select person_id as v26 from cast_info as ci, aggView6222477574181533352 where ci.movie_id=aggView6222477574181533352.v3);
create or replace view aggJoin4586999103379907553 as (
with aggView1880172475308403309 as (select v26 from aggJoin2891678308071830528 group by v26)
select name as v27 from name as n, aggView1880172475308403309 where n.id=aggView1880172475308403309.v26 and name LIKE '%B%');
create or replace view aggView3291296761441185984 as select v27 from aggJoin4586999103379907553 group by v27;
select MIN(v27) as v47 from aggView3291296761441185984;
