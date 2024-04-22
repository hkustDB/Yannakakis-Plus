create or replace view aggJoin7421813652658549996 as (
with aggView6504847235351028280 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6504847235351028280 where t.kind_id=aggView6504847235351028280.v26 and production_year>2000);
create or replace view aggJoin9218265208037634960 as (
with aggView2029155676875018452 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView2029155676875018452 where ci.person_role_id=aggView2029155676875018452.v9);
create or replace view aggJoin5586737803715076759 as (
with aggView1905720536712496990 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin9218265208037634960 join aggView1905720536712496990 using(v31));
create or replace view aggJoin1508501625956469562 as (
with aggView7249429235383668260 as (select v40 from aggJoin5586737803715076759 group by v40)
select movie_id as v40, subject_id as v5, status_id as v7 from complete_cast as cc, aggView7249429235383668260 where cc.movie_id=aggView7249429235383668260.v40);
create or replace view aggJoin8137607487673187338 as (
with aggView3167456559708306014 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40, v5 from aggJoin1508501625956469562 join aggView3167456559708306014 using(v7));
create or replace view aggJoin40939509302649321 as (
with aggView6745374216467837089 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin8137607487673187338 join aggView6745374216467837089 using(v5));
create or replace view aggJoin4588174521552158087 as (
with aggView3299622382682008184 as (select v40 from aggJoin40939509302649321 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView3299622382682008184 where mk.movie_id=aggView3299622382682008184.v40);
create or replace view aggJoin5707751930833338147 as (
with aggView5120387287218141863 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin4588174521552158087 join aggView5120387287218141863 using(v23));
create or replace view aggJoin5149855604562674492 as (
with aggView7909232531135785115 as (select v40 from aggJoin5707751930833338147 group by v40)
select v41, v44 from aggJoin7421813652658549996 join aggView7909232531135785115 using(v40));
create or replace view aggView2982864488450805462 as select v41 from aggJoin5149855604562674492 group by v41;
select MIN(v41) as v52 from aggView2982864488450805462;
