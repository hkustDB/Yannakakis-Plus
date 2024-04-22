create or replace view aggJoin4909678410359214856 as (
with aggView4731625979060383229 as (select id as v31, title as v44 from title as t where production_year>1990)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView4731625979060383229 where ci.movie_id=aggView4731625979060383229.v31 and note LIKE '%(producer)%');
create or replace view aggJoin1653176010142360474 as (
with aggView4148346788844908490 as (select id as v1, name as v43 from char_name as chn)
select v31, v12, v29, v44, v43 from aggJoin4909678410359214856 join aggView4148346788844908490 using(v1));
create or replace view aggJoin3996714486889307723 as (
with aggView3236661270664716685 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView3236661270664716685 where mc.company_type_id=aggView3236661270664716685.v22);
create or replace view aggJoin8650345238441177255 as (
with aggView4609667451159572832 as (select id as v29 from role_type as rt)
select v31, v12, v44, v43 from aggJoin1653176010142360474 join aggView4609667451159572832 using(v29));
create or replace view aggJoin2134446501825538177 as (
with aggView2181157571042775462 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin3996714486889307723 join aggView2181157571042775462 using(v15));
create or replace view aggJoin833363306108815971 as (
with aggView22661167228921934 as (select v31, MIN(v44) as v44, MIN(v43) as v43 from aggJoin8650345238441177255 group by v31,v43,v44)
select v44, v43 from aggJoin2134446501825538177 join aggView22661167228921934 using(v31));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin833363306108815971;
