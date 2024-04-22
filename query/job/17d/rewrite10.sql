create or replace view aggJoin6484598343262028934 as (
with aggView4578834957902356397 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView4578834957902356397 where ci.person_id=aggView4578834957902356397.v26);
create or replace view aggJoin2233452019754727152 as (
with aggView4233249303193265159 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView4233249303193265159 where mc.company_id=aggView4233249303193265159.v20);
create or replace view aggJoin215343479625914081 as (
with aggView8490855044684871682 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8490855044684871682 where mk.keyword_id=aggView8490855044684871682.v25);
create or replace view aggJoin7894445475489896538 as (
with aggView4218900643935941282 as (select v3 from aggJoin2233452019754727152 group by v3)
select id as v3 from title as t, aggView4218900643935941282 where t.id=aggView4218900643935941282.v3);
create or replace view aggJoin8332444968159885909 as (
with aggView768023582657493194 as (select v3 from aggJoin7894445475489896538 group by v3)
select v3 from aggJoin215343479625914081 join aggView768023582657493194 using(v3));
create or replace view aggJoin1667116084057213382 as (
with aggView4982912588640237762 as (select v3 from aggJoin8332444968159885909 group by v3)
select v47 as v47 from aggJoin6484598343262028934 join aggView4982912588640237762 using(v3));
select MIN(v47) as v47 from aggJoin1667116084057213382;
