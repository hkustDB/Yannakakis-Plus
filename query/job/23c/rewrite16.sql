create or replace view aggJoin3849088034621641333 as (
with aggView5948213858271111604 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5948213858271111604 where mi.info_type_id=aggView5948213858271111604.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin5563361304948517777 as (
with aggView1039456362598525978 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView1039456362598525978 where mk.keyword_id=aggView1039456362598525978.v18);
create or replace view aggJoin2247727604893365076 as (
with aggView2600915857772499386 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2600915857772499386 where mc.company_type_id=aggView2600915857772499386.v14);
create or replace view aggJoin2228451894820397637 as (
with aggView3190839477553999131 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2247727604893365076 join aggView3190839477553999131 using(v7));
create or replace view aggJoin6408862364932866401 as (
with aggView422623832199052746 as (select v36 from aggJoin5563361304948517777 group by v36)
select v36, v31, v32 from aggJoin3849088034621641333 join aggView422623832199052746 using(v36));
create or replace view aggJoin168925978880760979 as (
with aggView1364511534299059713 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView1364511534299059713 where cc.status_id=aggView1364511534299059713.v5);
create or replace view aggJoin2696655525728541275 as (
with aggView3892454943295283556 as (select v36 from aggJoin168925978880760979 group by v36)
select v36, v31, v32 from aggJoin6408862364932866401 join aggView3892454943295283556 using(v36));
create or replace view aggJoin8478220684982630140 as (
with aggView2624944556695438455 as (select v36 from aggJoin2228451894820397637 group by v36)
select v36, v31, v32 from aggJoin2696655525728541275 join aggView2624944556695438455 using(v36));
create or replace view aggJoin1885307093771483608 as (
with aggView6254372276400213578 as (select v36 from aggJoin8478220684982630140 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView6254372276400213578 where t.id=aggView6254372276400213578.v36 and production_year>1990);
create or replace view aggView2662271529390791988 as select v37, v21 from aggJoin1885307093771483608 group by v37,v21;
create or replace view aggJoin5133542851979197564 as (
with aggView8517286452286696174 as (select v21, MIN(v37) as v49 from aggView2662271529390791988 group by v21)
select kind as v22, v49 from kind_type as kt, aggView8517286452286696174 where kt.id=aggView8517286452286696174.v21 and kind IN ('movie','tv movie','video movie','video game'));
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin5133542851979197564;
