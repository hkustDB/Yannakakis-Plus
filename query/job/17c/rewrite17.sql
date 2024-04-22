create or replace view aggJoin2147665512042627993 as (
with aggView2122278289540928425 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView2122278289540928425 where ci.person_id=aggView2122278289540928425.v26);
create or replace view aggJoin9040107747681117099 as (
with aggView1827397239014953569 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1827397239014953569 where mk.keyword_id=aggView1827397239014953569.v25);
create or replace view aggJoin7494410096255983645 as (
with aggView8813499842100520518 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8813499842100520518 where mc.company_id=aggView8813499842100520518.v20);
create or replace view aggJoin163363387202798416 as (
with aggView8149198450075927940 as (select v3 from aggJoin9040107747681117099 group by v3)
select v3 from aggJoin7494410096255983645 join aggView8149198450075927940 using(v3));
create or replace view aggJoin4125627807453600142 as (
with aggView1495129938671691992 as (select v3 from aggJoin163363387202798416 group by v3)
select v3, v47 as v47 from aggJoin2147665512042627993 join aggView1495129938671691992 using(v3));
create or replace view aggJoin5398263375649648572 as (
with aggView6018389487606755086 as (select id as v3 from title as t)
select v47 from aggJoin4125627807453600142 join aggView6018389487606755086 using(v3));
select MIN(v47) as v47 from aggJoin5398263375649648572;
