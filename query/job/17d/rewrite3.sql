create or replace view aggJoin597875685142993147 as (
with aggView3767124986382945736 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3767124986382945736 where mc.company_id=aggView3767124986382945736.v20);
create or replace view aggJoin1226337166913039070 as (
with aggView6023399295105554805 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6023399295105554805 where mk.keyword_id=aggView6023399295105554805.v25);
create or replace view aggJoin6592698379595343986 as (
with aggView8852597380239848476 as (select v3 from aggJoin597875685142993147 group by v3)
select id as v3 from title as t, aggView8852597380239848476 where t.id=aggView8852597380239848476.v3);
create or replace view aggJoin8326873391180681936 as (
with aggView3846499215962058839 as (select v3 from aggJoin6592698379595343986 group by v3)
select v3 from aggJoin1226337166913039070 join aggView3846499215962058839 using(v3));
create or replace view aggJoin3885133800230361703 as (
with aggView3059017972318915723 as (select v3 from aggJoin8326873391180681936 group by v3)
select person_id as v26 from cast_info as ci, aggView3059017972318915723 where ci.movie_id=aggView3059017972318915723.v3);
create or replace view aggJoin6171516033029513994 as (
with aggView8938761748530016336 as (select v26 from aggJoin3885133800230361703 group by v26)
select name as v27 from name as n, aggView8938761748530016336 where n.id=aggView8938761748530016336.v26 and name LIKE '%Bert%');
create or replace view aggView624644016353360925 as select v27 from aggJoin6171516033029513994 group by v27;
select MIN(v27) as v47 from aggView624644016353360925;
