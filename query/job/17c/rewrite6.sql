create or replace view aggJoin8024554498794555463 as (
with aggView769346364049491675 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView769346364049491675 where mk.keyword_id=aggView769346364049491675.v25);
create or replace view aggJoin8831676837390782789 as (
with aggView5605396410733146355 as (select v3 from aggJoin8024554498794555463 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5605396410733146355 where ci.movie_id=aggView5605396410733146355.v3);
create or replace view aggJoin7365526441218295562 as (
with aggView400498992789790953 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView400498992789790953 where mc.company_id=aggView400498992789790953.v20);
create or replace view aggJoin3996218068535809470 as (
with aggView6215832781928478547 as (select v3 from aggJoin7365526441218295562 group by v3)
select id as v3 from title as t, aggView6215832781928478547 where t.id=aggView6215832781928478547.v3);
create or replace view aggJoin5962356438609475153 as (
with aggView4118281716706831048 as (select v3 from aggJoin3996218068535809470 group by v3)
select v26 from aggJoin8831676837390782789 join aggView4118281716706831048 using(v3));
create or replace view aggJoin2949092184158648769 as (
with aggView58896718860455843 as (select v26 from aggJoin5962356438609475153 group by v26)
select name as v27 from name as n, aggView58896718860455843 where n.id=aggView58896718860455843.v26 and name LIKE 'X%');
create or replace view aggView9055457748195124054 as select v27 from aggJoin2949092184158648769 group by v27;
select MIN(v27) as v47 from aggView9055457748195124054;
