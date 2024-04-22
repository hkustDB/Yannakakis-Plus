create or replace view aggJoin9183057078943992933 as (
with aggView3906828571373391796 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView3906828571373391796 where t.kind_id=aggView3906828571373391796.v21 and production_year>1990);
create or replace view aggJoin940343300672498352 as (
with aggView7550998652450405998 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView7550998652450405998 where mi.info_type_id=aggView7550998652450405998.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin7293154851093916432 as (
with aggView224585848023097373 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView224585848023097373 where mc.company_type_id=aggView224585848023097373.v14);
create or replace view aggJoin1389236894581595957 as (
with aggView4012143304706465001 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4012143304706465001 where mk.keyword_id=aggView4012143304706465001.v18);
create or replace view aggJoin4865353753622099726 as (
with aggView180834479750019594 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7293154851093916432 join aggView180834479750019594 using(v7));
create or replace view aggJoin9044358822882296533 as (
with aggView8022047275707930904 as (select v36 from aggJoin4865353753622099726 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin9183057078943992933 join aggView8022047275707930904 using(v36));
create or replace view aggJoin6435901709611377393 as (
with aggView602756042820218587 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView602756042820218587 where cc.status_id=aggView602756042820218587.v5);
create or replace view aggJoin3472269849355512613 as (
with aggView3330269231770722359 as (select v36 from aggJoin6435901709611377393 group by v36)
select v36 from aggJoin1389236894581595957 join aggView3330269231770722359 using(v36));
create or replace view aggJoin7830663763022845043 as (
with aggView3271551216073377099 as (select v36 from aggJoin940343300672498352 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin9044358822882296533 join aggView3271551216073377099 using(v36));
create or replace view aggJoin7879616496524723686 as (
with aggView4628678200263484400 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin7830663763022845043 group by v36,v48)
select v48, v49 from aggJoin3472269849355512613 join aggView4628678200263484400 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin7879616496524723686;
