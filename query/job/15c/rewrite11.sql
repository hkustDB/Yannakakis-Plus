create or replace view aggJoin7595157609647571125 as (
with aggView2865768487955035805 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView2865768487955035805 where mc.company_id=aggView2865768487955035805.v13);
create or replace view aggJoin128589759367411846 as (
with aggView4731967878928538719 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView4731967878928538719 where t.id=aggView4731967878928538719.v40 and production_year>1990);
create or replace view aggJoin3325291511608105156 as (
with aggView797480855834247121 as (select v40, MIN(v41) as v53 from aggJoin128589759367411846 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36, v53 from movie_info as mi, aggView797480855834247121 where mi.movie_id=aggView797480855834247121.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin4348597282978296113 as (
with aggView8996022409380970877 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView8996022409380970877 where mk.keyword_id=aggView8996022409380970877.v24);
create or replace view aggJoin2276051272459205911 as (
with aggView3886897759127938486 as (select id as v20 from company_type as ct)
select v40 from aggJoin7595157609647571125 join aggView3886897759127938486 using(v20));
create or replace view aggJoin7532120518876473406 as (
with aggView4233048040682454751 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36, v53 from aggJoin3325291511608105156 join aggView4233048040682454751 using(v22));
create or replace view aggJoin3478362056945279221 as (
with aggView6366982533697293617 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin7532120518876473406 group by v40,v53)
select v40, v53, v52 from aggJoin2276051272459205911 join aggView6366982533697293617 using(v40));
create or replace view aggJoin1885970709510353902 as (
with aggView7768710959627350157 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin3478362056945279221 group by v40,v52,v53)
select v53, v52 from aggJoin4348597282978296113 join aggView7768710959627350157 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1885970709510353902;
