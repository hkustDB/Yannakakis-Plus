create or replace view aggView8928337699487806320 as select id as v37, title as v41 from title as t where production_year>=1950 and production_year<=2010;
create or replace view aggView3214837154610895382 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin1178728959419368986 as (
with aggView7543139350562075411 as (select v25, MIN(v10) as v52 from aggView3214837154610895382 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView7543139350562075411 where mc.company_id=aggView7543139350562075411.v25);
create or replace view aggJoin4819183574066650333 as (
with aggView2979554266861343244 as (select v37, MIN(v41) as v54 from aggView8928337699487806320 group by v37)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView2979554266861343244 where ml.movie_id=aggView2979554266861343244.v37);
create or replace view aggJoin6641908449402426019 as (
with aggView194845951204094520 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView194845951204094520 where mk.keyword_id=aggView194845951204094520.v35);
create or replace view aggJoin4147981116860201075 as (
with aggView8656807098759863926 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView8656807098759863926 where cc.subject_id=aggView8656807098759863926.v5);
create or replace view aggJoin433633350118139224 as (
with aggView893006072159552528 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin4147981116860201075 join aggView893006072159552528 using(v7));
create or replace view aggJoin5228068490505825033 as (
with aggView871568318611662467 as (select v37 from aggJoin433633350118139224 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView871568318611662467 where mi.movie_id=aggView871568318611662467.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin3252285285781680990 as (
with aggView2025494671370334139 as (select v37 from aggJoin5228068490505825033 group by v37)
select v37 from aggJoin6641908449402426019 join aggView2025494671370334139 using(v37));
create or replace view aggJoin736000411281406147 as (
with aggView8049104750547423661 as (select v37 from aggJoin3252285285781680990 group by v37)
select v37, v26, v52 as v52 from aggJoin1178728959419368986 join aggView8049104750547423661 using(v37));
create or replace view aggJoin798873688988305744 as (
with aggView182761088716595401 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin736000411281406147 join aggView182761088716595401 using(v26));
create or replace view aggJoin2878172007272046769 as (
with aggView2670960832388487074 as (select v37, MIN(v52) as v52 from aggJoin798873688988305744 group by v37,v52)
select v21, v54 as v54, v52 from aggJoin4819183574066650333 join aggView2670960832388487074 using(v37));
create or replace view aggJoin8819477470868573989 as (
with aggView4184873508672256471 as (select v21, MIN(v54) as v54, MIN(v52) as v52 from aggJoin2878172007272046769 group by v21,v54,v52)
select link as v22, v54, v52 from link_type as lt, aggView4184873508672256471 where lt.id=aggView4184873508672256471.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin8819477470868573989;
