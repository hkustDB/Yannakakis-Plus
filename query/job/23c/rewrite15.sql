create or replace view aggJoin5024011313117753063 as (
with aggView7130386850250655812 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView7130386850250655812 where t.kind_id=aggView7130386850250655812.v21 and production_year>1990);
create or replace view aggJoin9074276883422403325 as (
with aggView1889194821417048062 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin5024011313117753063 group by v36,v48)
select movie_id as v36, status_id as v5, v48, v49 from complete_cast as cc, aggView1889194821417048062 where cc.movie_id=aggView1889194821417048062.v36);
create or replace view aggJoin1357659072513288321 as (
with aggView7058816026509264542 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView7058816026509264542 where mi.info_type_id=aggView7058816026509264542.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin3157817745624182329 as (
with aggView7158764450347501718 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7158764450347501718 where mc.company_type_id=aggView7158764450347501718.v14);
create or replace view aggJoin1879734841369333079 as (
with aggView7741507761848860516 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView7741507761848860516 where mk.keyword_id=aggView7741507761848860516.v18);
create or replace view aggJoin1596263355977345373 as (
with aggView4944896036469896254 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin3157817745624182329 join aggView4944896036469896254 using(v7));
create or replace view aggJoin4387597789893079106 as (
with aggView5493919621235059202 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36, v48, v49 from aggJoin9074276883422403325 join aggView5493919621235059202 using(v5));
create or replace view aggJoin4200857348785109209 as (
with aggView7938471330723632936 as (select v36 from aggJoin1596263355977345373 group by v36)
select v36, v31, v32 from aggJoin1357659072513288321 join aggView7938471330723632936 using(v36));
create or replace view aggJoin2460464664317023931 as (
with aggView6255918881989040594 as (select v36 from aggJoin4200857348785109209 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin4387597789893079106 join aggView6255918881989040594 using(v36));
create or replace view aggJoin2786507880001226251 as (
with aggView6156027554350149673 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin2460464664317023931 group by v36,v49,v48)
select v48, v49 from aggJoin1879734841369333079 join aggView6156027554350149673 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin2786507880001226251;
