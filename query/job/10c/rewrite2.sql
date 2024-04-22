create or replace view aggJoin2170485291478754538 as (
with aggView8019635709867659711 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView8019635709867659711 where mc.company_type_id=aggView8019635709867659711.v22);
create or replace view aggJoin4684208649249247513 as (
with aggView3883750107026495750 as (select id as v29 from role_type as rt)
select movie_id as v31, person_role_id as v1, note as v12 from cast_info as ci, aggView3883750107026495750 where ci.role_id=aggView3883750107026495750.v29 and note LIKE '%(producer)%');
create or replace view aggJoin7558093062915163521 as (
with aggView4467243773086601076 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin2170485291478754538 join aggView4467243773086601076 using(v15));
create or replace view aggJoin3224429167289300634 as (
with aggView5424727933360889196 as (select v31 from aggJoin7558093062915163521 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView5424727933360889196 where t.id=aggView5424727933360889196.v31 and production_year>1990);
create or replace view aggJoin5428363349334401817 as (
with aggView5322936650705407649 as (select v31, MIN(v32) as v44 from aggJoin3224429167289300634 group by v31)
select v1, v12, v44 from aggJoin4684208649249247513 join aggView5322936650705407649 using(v31));
create or replace view aggJoin7816348569287261934 as (
with aggView705343634948052013 as (select v1, MIN(v44) as v44 from aggJoin5428363349334401817 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView705343634948052013 where chn.id=aggView705343634948052013.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin7816348569287261934;
