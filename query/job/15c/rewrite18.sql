create or replace view aggJoin6878121251810056562 as (
with aggView422904397131971639 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, company_id as v13, company_type_id as v20, v53 from movie_companies as mc, aggView422904397131971639 where mc.movie_id=aggView422904397131971639.v40);
create or replace view aggJoin2332416381604455771 as (
with aggView7965742652903214830 as (select id as v13 from company_name as cn where country_code= '[us]')
select v40, v20, v53 from aggJoin6878121251810056562 join aggView7965742652903214830 using(v13));
create or replace view aggJoin2574427637310390088 as (
with aggView1776310702985953903 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView1776310702985953903 where mk.keyword_id=aggView1776310702985953903.v24);
create or replace view aggJoin6460959447188462646 as (
with aggView1027435372080331187 as (select id as v20 from company_type as ct)
select v40, v53 from aggJoin2332416381604455771 join aggView1027435372080331187 using(v20));
create or replace view aggJoin255777410205972247 as (
with aggView2733673953864585154 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2733673953864585154 where mi.info_type_id=aggView2733673953864585154.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin2699832493890682261 as (
with aggView6664041704635348177 as (select v40, MIN(v35) as v52 from aggJoin255777410205972247 group by v40)
select movie_id as v40, v52 from aka_title as aka_t, aggView6664041704635348177 where aka_t.movie_id=aggView6664041704635348177.v40);
create or replace view aggJoin7348097755702991233 as (
with aggView1451669864220657898 as (select v40, MIN(v52) as v52 from aggJoin2699832493890682261 group by v40,v52)
select v40, v53 as v53, v52 from aggJoin6460959447188462646 join aggView1451669864220657898 using(v40));
create or replace view aggJoin3729298015542580317 as (
with aggView1150944637178966049 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin7348097755702991233 group by v40,v52,v53)
select v53, v52 from aggJoin2574427637310390088 join aggView1150944637178966049 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin3729298015542580317;
