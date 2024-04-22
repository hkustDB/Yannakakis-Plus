create or replace view aggJoin1570488281836363975 as (
with aggView8654978625901963817 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8654978625901963817 where mc.company_id=aggView8654978625901963817.v20);
create or replace view aggJoin5236676917502022629 as (
with aggView8085285082854858214 as (select v3 from aggJoin1570488281836363975 group by v3)
select id as v3 from title as t, aggView8085285082854858214 where t.id=aggView8085285082854858214.v3);
create or replace view aggJoin5533896851735374683 as (
with aggView2713362063158542963 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2713362063158542963 where mk.keyword_id=aggView2713362063158542963.v25);
create or replace view aggJoin7940273401006418142 as (
with aggView3117559729563652258 as (select v3 from aggJoin5236676917502022629 group by v3)
select v3 from aggJoin5533896851735374683 join aggView3117559729563652258 using(v3));
create or replace view aggJoin1678418226811053272 as (
with aggView3587374373297963386 as (select v3 from aggJoin7940273401006418142 group by v3)
select person_id as v26 from cast_info as ci, aggView3587374373297963386 where ci.movie_id=aggView3587374373297963386.v3);
create or replace view aggJoin1174869055703614425 as (
with aggView3539269941752932281 as (select v26 from aggJoin1678418226811053272 group by v26)
select name as v27 from name as n, aggView3539269941752932281 where n.id=aggView3539269941752932281.v26 and name LIKE 'X%');
create or replace view aggView9132895420515869414 as select v27 from aggJoin1174869055703614425 group by v27;
select MIN(v27) as v47 from aggView9132895420515869414;
