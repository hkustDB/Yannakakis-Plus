create or replace view aggJoin4731956373098707627 as (
with aggView4963234660494385858 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView4963234660494385858 where mc.company_id=aggView4963234660494385858.v13);
create or replace view aggJoin3003227878299632523 as (
with aggView5795906218156694136 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5795906218156694136 where mk.keyword_id=aggView5795906218156694136.v24);
create or replace view aggJoin1260875058181113271 as (
with aggView1477425249551073181 as (select id as v20 from company_type as ct)
select v40 from aggJoin4731956373098707627 join aggView1477425249551073181 using(v20));
create or replace view aggJoin7665373309190325606 as (
with aggView8918124822446171936 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView8918124822446171936 where mi.movie_id=aggView8918124822446171936.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin6815366476289884504 as (
with aggView7068021644237194077 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin7665373309190325606 join aggView7068021644237194077 using(v22));
create or replace view aggJoin4697352548402814058 as (
with aggView2620905603805895517 as (select v40, MIN(v35) as v52 from aggJoin6815366476289884504 group by v40)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView2620905603805895517 where t.id=aggView2620905603805895517.v40 and production_year>1990);
create or replace view aggJoin6941387421705158983 as (
with aggView2431964844650375163 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin4697352548402814058 group by v40,v52)
select v40, v52, v53 from aggJoin1260875058181113271 join aggView2431964844650375163 using(v40));
create or replace view aggJoin1179150525729474979 as (
with aggView6044679554130105066 as (select v40, MIN(v52) as v52, MIN(v53) as v53 from aggJoin6941387421705158983 group by v40,v52,v53)
select v52, v53 from aggJoin3003227878299632523 join aggView6044679554130105066 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1179150525729474979;
