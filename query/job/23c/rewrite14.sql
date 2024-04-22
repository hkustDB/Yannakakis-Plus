create or replace view aggJoin4066419304927104650 as (
with aggView4821726687371528662 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView4821726687371528662 where t.kind_id=aggView4821726687371528662.v21 and production_year>1990);
create or replace view aggJoin757195540705244013 as (
with aggView7894088400634779150 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView7894088400634779150 where mi.info_type_id=aggView7894088400634779150.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin4615194788804389259 as (
with aggView4551636567369511012 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4551636567369511012 where mk.keyword_id=aggView4551636567369511012.v18);
create or replace view aggJoin3249354640933969069 as (
with aggView403301653023460679 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView403301653023460679 where mc.company_type_id=aggView403301653023460679.v14);
create or replace view aggJoin4719362858772418728 as (
with aggView8969361816523065518 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin3249354640933969069 join aggView8969361816523065518 using(v7));
create or replace view aggJoin4203787944686933474 as (
with aggView8715456526675997900 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView8715456526675997900 where cc.status_id=aggView8715456526675997900.v5);
create or replace view aggJoin8719120255520179022 as (
with aggView338096797209519968 as (select v36 from aggJoin757195540705244013 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin4066419304927104650 join aggView338096797209519968 using(v36));
create or replace view aggJoin7058569047033083703 as (
with aggView5469527334057734299 as (select v36 from aggJoin4719362858772418728 group by v36)
select v36 from aggJoin4615194788804389259 join aggView5469527334057734299 using(v36));
create or replace view aggJoin9179541888126846278 as (
with aggView2278385647504697331 as (select v36 from aggJoin4203787944686933474 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin8719120255520179022 join aggView2278385647504697331 using(v36));
create or replace view aggJoin407522023289756889 as (
with aggView8592159411707388365 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin9179541888126846278 group by v36,v48)
select v48, v49 from aggJoin7058569047033083703 join aggView8592159411707388365 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin407522023289756889;
