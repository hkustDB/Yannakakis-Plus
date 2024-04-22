create or replace view aggJoin7556199112541509318 as (
with aggView5692280594013536343 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView5692280594013536343 where t.kind_id=aggView5692280594013536343.v21 and production_year>2000);
create or replace view aggJoin8867002959989634637 as (
with aggView8219221397189612666 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin7556199112541509318 group by v36,v48)
select movie_id as v36, keyword_id as v18, v48, v49 from movie_keyword as mk, aggView8219221397189612666 where mk.movie_id=aggView8219221397189612666.v36);
create or replace view aggJoin7948216326445324061 as (
with aggView4008537400362705921 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4008537400362705921 where mc.company_type_id=aggView4008537400362705921.v14);
create or replace view aggJoin36299288868803232 as (
with aggView6041693901764479080 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select v36, v48, v49 from aggJoin8867002959989634637 join aggView6041693901764479080 using(v18));
create or replace view aggJoin2917124966127362791 as (
with aggView4943621951480015060 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView4943621951480015060 where mi.info_type_id=aggView4943621951480015060.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin3483214224924537734 as (
with aggView59893146399405164 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView59893146399405164 where cc.status_id=aggView59893146399405164.v5);
create or replace view aggJoin5538736069433315235 as (
with aggView722499154609031059 as (select v36 from aggJoin2917124966127362791 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin36299288868803232 join aggView722499154609031059 using(v36));
create or replace view aggJoin2895674495072199776 as (
with aggView1551200185800672593 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7948216326445324061 join aggView1551200185800672593 using(v7));
create or replace view aggJoin6469695242718432997 as (
with aggView8577771793658551138 as (select v36 from aggJoin3483214224924537734 group by v36)
select v36 from aggJoin2895674495072199776 join aggView8577771793658551138 using(v36));
create or replace view aggJoin4013018503841211756 as (
with aggView5150193181947402279 as (select v36 from aggJoin6469695242718432997 group by v36)
select v48 as v48, v49 as v49 from aggJoin5538736069433315235 join aggView5150193181947402279 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin4013018503841211756;
