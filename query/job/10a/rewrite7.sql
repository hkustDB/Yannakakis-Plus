create or replace view aggJoin1260054131509159952 as (
with aggView25686799672416473 as (select id as v31, title as v44 from title as t where production_year>2005)
select movie_id as v31, company_id as v15, company_type_id as v22, v44 from movie_companies as mc, aggView25686799672416473 where mc.movie_id=aggView25686799672416473.v31);
create or replace view aggJoin614478339589656963 as (
with aggView6299512408520870117 as (select id as v29 from role_type as rt where role= 'actor')
select movie_id as v31, person_role_id as v1, note as v12 from cast_info as ci, aggView6299512408520870117 where ci.role_id=aggView6299512408520870117.v29 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin7442578556415692112 as (
with aggView7465167199478912748 as (select id as v22 from company_type as ct)
select v31, v15, v44 from aggJoin1260054131509159952 join aggView7465167199478912748 using(v22));
create or replace view aggJoin8895744911696683730 as (
with aggView5836436174556649088 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31, v44 from aggJoin7442578556415692112 join aggView5836436174556649088 using(v15));
create or replace view aggJoin3175471761685685327 as (
with aggView7190337816825182332 as (select v31, MIN(v44) as v44 from aggJoin8895744911696683730 group by v31,v44)
select v1, v12, v44 from aggJoin614478339589656963 join aggView7190337816825182332 using(v31));
create or replace view aggJoin5294841015359850846 as (
with aggView6882691012289931184 as (select v1, MIN(v44) as v44 from aggJoin3175471761685685327 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView6882691012289931184 where chn.id=aggView6882691012289931184.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin5294841015359850846;
